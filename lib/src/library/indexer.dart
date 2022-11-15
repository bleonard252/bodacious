import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:bodacious/main.dart';
import 'package:bodacious/models/album_data.dart';
import 'package:bodacious/src/config.dart';
import 'package:bodacious/src/library/cache_dir.dart';
import 'package:bodacious/src/library/indexer_logger.dart';
import 'package:bodacious/src/metadata/id3.dart';
import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';
import 'package:lastfm/lastfm.dart';
import 'package:mime/mime.dart';
import 'package:nanoid/non_secure.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pinelogger/pinelogger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:spotify/spotify.dart';
import 'package:xml/xml.dart';

import '../../drift/database.dart';
import '../../models/artist_data.dart';
import '../../models/track_data.dart';
import '../metadata/infer.dart';

abstract class TheIndexer {
  // Isolate main logic
  static final ReceivePort progressReceiver = ReceivePort("The Indexer's Progress Receiver");
  static dynamic _progress;
  static final StreamController<IndexerProgressReport> _sendPortKinda = StreamController();
  static ValueConnectableStream<IndexerProgressReport> get progress => _progress ??=
  progressReceiver.cast<IndexerProgressReport>().concatWith([_sendPortKinda.stream]).publishValue();

  //static late final Isolate indexerIsolate;
  
  /// Don't try to touch the isolate before this aight
  static Future<void> spawn({bool force = false}) async {
    final ReceivePort logReceiver = ReceivePort("Isolate Pinelogger pipe");
    final isoLogger = IsolatedPinelogReceiver.asIndependentChildOf(appLogger, receivePort: logReceiver, name: "Indexer");
    final _dbPath = await () async {
      late String dbPath;
      try {
        dbPath = (await getLibraryDirectory()).absolute.path+"/_boLibrary.sqlite";
      } catch(_) {
        try {
          dbPath = (await getApplicationSupportDirectory()).absolute.path+"/_boLibrary.sqlite";
        } catch(_) {
          dbPath = (await getApplicationDocumentsDirectory()).absolute.path+"/_boLibrary.sqlite";
        }
      }
      return dbPath;
    }();
    progress.connect(); // invoke the getter
    final _cacheDir = await getCacheDirectory();
    try {
      // This seemingly-redundant messaging nonsense is actually necessary.
      // It's passing variables into a separate variable scope from
      // the main app. It's the power of Isolates!
      await compute<Map, dynamic>((message) {
        return _IndexerIsolate(
          dbPath: message["dbDir"],
          cacheDir: message["cacheDir"],
          config: message["config"],
          force: message["force"],
          apiKeys: message["api_keys"],
        )(message["sendPort"], message["log_port"]);
      }, {
        "sendPort": progressReceiver.sendPort,
        "dbDir": _dbPath,
        "cacheDir": _cacheDir,
        "config": ROConfig(config),
        "force": force,
        "api_keys": apiKeys,
        "log_port": logReceiver.sendPort
      });
      if (progress.valueOrNull?.state != IndexerState.FINISHED) {
        progressReceiver.sendPort.send(IndexerProgressReport(
          state: IndexerState.STOPPED,
          currentFilename: progress.valueOrNull?.currentFilename,
          max: progress.valueOrNull?.max ?? 1,
          value: progress.valueOrNull?.value ?? 0
        ));
        isoLogger.error("The indexer has stopped without finishing!");
      }
    } catch(e, st) {
      progressReceiver.sendPort.send(IndexerProgressReport(
        state: IndexerState.STOPPED,
        currentFilename: progress.valueOrNull?.currentFilename,
        max: progress.valueOrNull?.max ?? 1,
        value: progress.valueOrNull?.value ?? 0
      ));
      isoLogger.error("The indexer has stopped!", error: e, stackTrace: st);
    }
  }
}

class _IndexerIsolate {
  /// Force the scanner to rescan everything.
  final bool force;
  /// When used with [force], set the indexer to clean out the database
  /// before writing the new entries to it.
  /// Not yet supported.
  final bool preclean;
  /// Fetch artist and album data in advance.
  final bool fetch;
  /// Scan only this path. It has to be set in the library.
  final String? scanOnlyPath;
  final String dbPath;
  final String cacheDir;
  _IndexerIsolate({
    this.force = false,
    this.preclean = false,
    this.fetch = false,
    this.scanOnlyPath,
    required this.apiKeys,
    required this.config,
    required this.dbPath,
    required this.cacheDir
  });

  late final BoDatabase db;
  late final Pinelogger? logger;
  final ROConfig config;
  final APIKeys apiKeys;

  final List<String> newArtists = [];
  final List<String> newAlbums = [];

  /// This makes this class function as a function.
  /// And gee I wonder why I did that.
  Future<void> call(SendPort sendProgressReport, SendPort logPort) async {
    final log = IsolatedPinelogger(logPort);
    log.info("Indexer started");
    // if (kDebugMode) {
    //   print("This is not complete and may appear to hang");
    //   //sendProgressReport.send(const IndexerProgressReport(state: IndexerState.STARTING, max));
    //   //await Future.delayed(const Duration(seconds: 5)); // just so I can get to this screen
    // } else {
    //   throw UnimplementedError("The Indexer doesn't work yet.");
    // }
    db = BoDatabase.connect(DatabaseConnection.fromExecutor(NativeDatabase(File(dbPath))));
    sendProgressReport.send(const IndexerProgressReport(state: IndexerState.STARTING, max: 0));
    await db.transaction<void>(() async {
      // == STARTING PHASE == //
      if (preclean) {
        throw UnimplementedError("Pre-clean is not currently supported");
        // await db.delete();
        // await albumStore.drop(db);
        // await artistStore.drop(db);
      }
      List<File> validFiles = [];
      final List<String> _dbfolders = List.castFrom<dynamic, String>(config.libraries);
      for (final f in _dbfolders) {
        if (!await Directory(f).exists()) {
          log.warning("Directory does not exist. Marking all contained tracks as unavailable.", error: f);
          await (
            db.update(db.trackTable)
            ..where((tbl) => tbl.uri.like(Uri.file(f).toString()+"%"))
          ).write(const TrackTableCompanion(
            available: Value(false)
          ));
          continue; //we're in a for loop. so go to the next thing (or break if you're at the end)
        } else {
          // Mark these as available again
          await (
            db.update(db.trackTable)
            ..where((tbl) => tbl.uri.like(Uri.file(f).toString()+"%"))
          ).write(const TrackTableCompanion(
            available: Value(true)
          ));
        }
        await for (final d in Directory(f).list(recursive: true)) {
          if (d is! File) continue;
          if (MimeTypeResolver().lookup(d.uri.pathSegments.last)?.startsWith("audio/") != true) continue;
          validFiles.add(d);
          sendProgressReport.send(IndexerProgressReport(
            state: IndexerState.STARTING,
            max: validFiles.length,
            currentFilename: f
          ));
        }
      }
      sendProgressReport.send(IndexerProgressReport(
        state: IndexerState.SCANNING,
        max: validFiles.length,
        value: 0
      ));

      // == GET THE METADATA == //
      // The plan for this is to read the metadata,
      // including covers and lyrics, for each file.
      // This includes checking adjacent files under
      // .lrc or .mse extensions, or `cover.png` for
      // cover art.
      // It'll check for MSEs first, but if it can't
      // find the file it'll then check for tags in
      // the file, then the file's context (filename
      // and parent dir names).
      // The metadata will be partial as it will be
      // stored as JSON in the database, which drops
      // some values, such as artist and album, data
      // for the cover itself, and album tracklists.
      for (final file in validFiles) {
        sendProgressReport.send(IndexerProgressReport(
          state: IndexerState.SCANNING,
          max: validFiles.length,
          value: validFiles.indexOf(file),
          currentFilename: file.uri.pathSegments.last
        ));
        log.verbose("Reading metadata from ${file.uri.pathSegments.last}", error: file.uri.toString());
        // final _matches = await songStore.find(db, finder: Finder(filter: Filter.custom(
        //   // Find this file in the database.
        //   (record) => record.value.uri == file.absolute.uri.toString()
        // )));
        if (!force) {
          final _matches = await (
            db.select(db.trackTable)
            ..where((tbl) => tbl.uri.equalsValue(file.absolute.uri))
          ).get();
          // Skip processing files that have already been processed
          if (_matches.isNotEmpty) continue;
        }
        var metaBytes = <int>[], _class = "none";
        final _metaByteReader = file.openRead().listen(null);
        //double? targetLength;
        final c = Completer();
        _metaByteReader.onData((data) {
          metaBytes.addAll(data);
          if (_class == "none") {
            if (metaBytes.length >= 4 && String.fromCharCodes(metaBytes.getRange(0, 4)) == 'fLaC') {_class = "flac";}
            else if (metaBytes.length >= 3 && listEquals(metaBytes.getRange(0, 3).toList(), [73, 68, 51])) {_class = "id3";}
          }
           /* if (metaBytes.length >= 10*1000000 /* 10MB */) {
            _metaByteReader.cancel();
            /* Really I have no idea why you'd need more than 10MB of TAGS in a file...
              If there is a case I might be able to bump it */
            metaBytes = metaBytes.take(10*1000000).toList();
            c.complete();
            /* Trust me though, I did try to figure out when the id3 tags ended
              so I could get ONLY the tags.
              I don't want to rely on id3 being only in mp3 form, and I wanted
              to reduce the amount of data looked at to only the necessary data,
              so that the library could scan faster.
            */
          } */
          if (_class == "flac") {
            _metaByteReader.cancel();
            c.complete();
            metaBytes.clear();
            // the FLAC metadata reader reads the file itself
            // so gathering the bytes for it is not important
          } else if (_class == "id3") {
            _metaByteReader.cancel();
            c.complete();
            metaBytes.clear();
            /* try {
              // Determine the length of the id3 segment
              //targetLength ??= (i32.parse(metaBytes.sublist(6,10).join(""), radix: 16)).roundToDouble()+10;
              // if (metaBytes.length >= targetLength!) {
              //   _metaByteReader.cancel();
              //   c.complete();
              // }
            } catch(e) {
              log.child("MetaTyper").error(e);
              // Clear&close the byte-reader, set to no metadata type, and move on.
              _metaByteReader.cancel();
              c.complete();
              metaBytes.clear();
              _class = "none";
              return;
            } */
          }
          if (metaBytes.length > 20 && _class == "none") {
            c.complete();
            _metaByteReader.cancel();
            metaBytes.clear();
          }
        });
        _metaByteReader.onDone(() {c.complete();});
        _metaByteReader.onError((_) {_metaByteReader.cancel().then((_)=>c.complete());});
        await Future.any([c.future, _metaByteReader.asFuture()]);

        //final _mseFile = File(file.path.replaceFirst(fileExtensionRegex, ".mse"));
        // final _mse = (await _mseFile.exists()) ? await parseMseFile(_mseFile.openRead()) : null;
        final TrackMetadata? _id3 = (/* _mse == null && */ _class == "id3" || _class == "flac") ? await loadID3Metadata(file, cacheDir: cacheDir, logger: log) : null;
        final TrackMetadata? _ctxmeta = (/* _mse == null && */ _id3 == null) ? inferMetadataFromContext(file.absolute.uri)
        .copyWith(coverUri: (await inferCoverFile(file))?.absolute.uri) : null;
        final _id = nanoid(13);
        TrackMetadata record = (/*_mse ??*/ _id3 ?? _ctxmeta ?? TrackMetadata.empty()).copyWith(
          uri: file.absolute.uri
        ).copyWith(id: _id);

        // If one artist field is not set but the other is,
        // make them match.
        // This should leave it as is if they're both already set.
        if (record.albumArtistName != null && record.artistName == null) {
          record = record.copyWith(
            artistName: record.albumArtistName
          );
        }
        if (record.artistName != null && record.albumArtistName == null) {
          record = record.copyWith(
            albumArtistName: record.artistName
          );
        }

        final artist = await registerArtistMetadata(record);
        if (artist != null) record = record.copyWith(trackArtistId: artist.id);

        if (record.artistName != record.albumArtistName) {
          final albumArtist = await registerArtistMetadata(record, true);
          if ((albumArtist ?? artist) != null) record = record.copyWith(albumArtistId: (albumArtist ?? artist)?.id);
        } else {
          record = record.copyWith(albumArtistId: record.trackArtistId);
        }

        final album = await registerAlbumMetadata(record);
        if (album != null) record = record.copyWith(albumId: album.id);

        //await tr_rec.put(db, record.toJson());
        await db.into(db.trackTable).insertOnConflictUpdate(record);
      }

      if (newArtists.isNotEmpty) {
        for (final artist in newArtists) {
          sendProgressReport.send(IndexerProgressReport(
            state: IndexerState.ANALYZING,
            max: newArtists.length,
            value: newArtists.indexOf(artist),
            currentFilename: artist
          ));
          final albumCount = (await (
            db.selectOnly(db.albumTable)
            ..addColumns([db.albumTable.artistName])
            ..where(db.albumTable.artistName.equals(artist))
          ).get()).length;
          final trackCount = (await (
            db.selectOnly(db.trackTable)
            ..addColumns([db.trackTable.artistName])
            ..where(db.trackTable.artistName.equals(artist))
          ).get()).length;
          await (
            db.artistTable.update()
            ..where((tbl) => tbl.name.equals(artist))
          ).write(ArtistTableCompanion(
            trackCount: Value(trackCount),
            albumCount: Value(albumCount)
          ));
        }
      }
      if (newAlbums.isNotEmpty) {
        for (final album in newAlbums) {
          sendProgressReport.send(IndexerProgressReport(
            state: IndexerState.ANALYZING,
            max: newAlbums.length,
            value: newAlbums.indexOf(album),
            currentFilename: album
          ));
          final _album = album.split(" - ");
          //await songStore.find(db, finder: Finder(filter: Filter.matches('albumName', _record.name))); //just re-something-whatever this???
          // final trackCount = await songStore.find(db, finder: Finder(filter: Filter.and([
          //   Filter.equals('artistName', _record.artistName),
          //   Filter.equals('albumName', _record.name)
          // ])));
          final trackCount = (await (
            db.select(db.trackTable)
            ..where((tbl) => tbl.artistName.equals(_album[0]) & tbl.albumName.equals(_album[1]))
          ).get());
          //print(await songStore.find(db, finder: Finder()));
          if (trackCount.isNotEmpty) {
            trackCount.sort((a, b) => (a.year)?.compareTo(b.year??0)??0);
            final year = trackCount.last.year;
            await (
              db.albumTable.update()
              ..where((tbl) => tbl.name.equals(_album[1]) & tbl.artistName.equals(_album[0]))
            ).write(AlbumTableCompanion(
              trackCount: Value(trackCount.length),
              year: Value(year)
            ));
          }
        }
      }

      sendProgressReport.send(const IndexerProgressReport(
        state: IndexerState.FINISHING,
        max: 0,
        value: 0
      ));
    });

    late final Response ct;
    try {
      if (apiKeys.discordAppId.exists() || apiKeys.lastfmApiKey.exists() || apiKeys.spotifyClientId.exists()) {
        // If there's no API keys, there's nothing to look up, so no point in trying.
        ct = await Dio().get("http://detectportal.firefox.com/success.txt", options: Options(validateStatus: (status) => true));
      } else {
        ct = Response(requestOptions: RequestOptions(path: ""), statusCode: 0);
      }
    } on DioError {
      ct = Response(requestOptions: RequestOptions(path: ""), statusCode: 0);
    }
    if ((config.spotifyIntegration || config.lastFmIntegration) && ct.statusCode == 200) {
      const smlx = {"small": 1, "medium": 2, "large": 3, "extralarge": 4, "mega": 5, "": 6};
      await db.transaction<void>(() async {
        if (apiKeys.lastfmApiKey != null && config.lastFmIntegration) {
          final lastfm = LastFMUnauthorized(apiKeys.lastfmApiKey!, null, "Bodacious/0.5.0 <https://github.com/bleonard252/bodacious>");

          final _albums = await (db.albumTable.selectOnly()
            ..addColumns([db.albumTable.name, db.albumTable.artistName, db.albumTable.coverUri, db.albumTable.coverUriRemote])
            ..where(db.albumTable.coverUri.isNull() | db.albumTable.coverUriRemote.isNull())
          ).get();
          for (final __album in _albums) {
            final album = __album.read(db.albumTable.name)!;
            final artist = __album.read(db.albumTable.artistName)!;
            final cover_ = __album.read(db.albumTable.coverUri);
            sendProgressReport.send(IndexerProgressReport(
              state: IndexerState.FETCHING,
              currentFilename: "Album: "+album.toString(),
              max: int.parse(_albums.length.toString()),
              value: int.parse(_albums.indexOf(__album).toString())
            ));
            late final XmlDocument _album;
            try {
              _album = await lastfm.read("album.getInfo", {
                "artist": artist, "album": album
              });
            } on LastFMError {continue;}
            final _images = _album.rootElement.firstElementChild?.children.where((p0) => p0 is XmlElement && p0.qualifiedName.toLowerCase() == "image").toList() ?? [];
            if (_images.isEmpty) continue;
            _images.sort((a, b) => smlx[a.getAttribute("size")]?.compareTo(smlx[b.getAttribute("size")] ?? 0) ?? 0);
            final _cover = _images.last.innerText;
            var output = const AlbumTableCompanion();
            if (_cover.isNotEmpty && cover_ == null) {
              final _dir = cacheDir+"/album_covers";
              await Directory(_dir).create();
              final coverFile = File(_dir+"/"+base64Encode(utf8.encode(artist))+"."+base64Encode(utf8.encode(album))+"_lastfm.jpg");
              await Dio().download(_cover, coverFile.absolute.uri.toFilePath());
              output = output.copyWith(
                coverUri: Value(coverFile.absolute.uri),
                coverSource: const Value("lastfm"),
              );
            }
            output.copyWith(coverUriRemote: Value(Uri.parse(_cover)));
            await (db.albumTable.update()
              ..where((tbl) => tbl.name.equals(artist))
            ).write(output);
          }
        }
        if (apiKeys.spotifyClientId != null && apiKeys.spotifySecret != null && config.spotifyIntegration) {
          final spcred = SpotifyApiCredentials(apiKeys.spotifyClientId, apiKeys.spotifySecret);
          final spotify = SpotifyApi(spcred);

          final _artists = await (db.artistTable.selectOnly()
            ..addColumns([db.artistTable.name, db.artistTable.coverUri])
            ..where(db.artistTable.coverUri.isNull())
          ).get();
          for (final __artist in _artists) {
            final artist = __artist.read(db.artistTable.name)!;
            final cover_ = __artist.read(db.artistTable.coverUri);
            sendProgressReport.send(IndexerProgressReport(
              state: IndexerState.FETCHING,
              currentFilename: "Artist: "+artist,
              max: _artists.length,
              value: _artists.indexOf(__artist)
            ));
            final _result = await spotify.search.get(artist, types: [SearchType.artist]).first();
            final Artist? _artist = _result.first.items?.firstWhere((element) => ratio(element.name.toLowerCase(), artist.toLowerCase()) >= 85, orElse: () => null);
            if (_artist == null) continue;
            final _cover = _artist.images?.first.url;
            final _spid = _artist.id;
            
            // Write the album cover to disk
            final _dir = cacheDir+"/album_covers";
            await Directory(_dir).create();
            late final File coverFile;
            if (_cover != null) {
              coverFile = File(_dir+"/"+base64Encode(utf8.encode(artist))+"_spotify.jpg");
              await Dio().download(_cover, coverFile.absolute.uri.toFilePath());
            }
            await (db.artistTable.update()
              ..where((tbl) => tbl.name.equals(artist))
            ).write((_cover != null) ? ArtistTableCompanion(
              coverUri: cover_ == null ? Value(coverFile.absolute.uri) : const Value.absent(),
              coverUriRemote: Value(Uri.parse(_cover)),
              coverSource: const Value("spotify"),
              spotifyId: Value(_spid)
            ) : ArtistTableCompanion(spotifyId: Value(_spid)));
          }

          final _albums = await (db.albumTable.selectOnly()
            ..addColumns([db.albumTable.name, db.albumTable.artistName, db.albumTable.coverUri, db.albumTable.coverUriRemote])
            ..where(db.albumTable.coverUri.isNull() | db.albumTable.coverUriRemote.isNull())
          ).get();
          for (final __album in _albums) {
            final album = __album.read(db.albumTable.name)!;
            final artist = __album.read(db.albumTable.artistName)!;
            final cover_ = __album.read(db.albumTable.coverUri);
            sendProgressReport.send(IndexerProgressReport(
              state: IndexerState.FETCHING,
              currentFilename: "Album: "+album,
              max: _albums.length,
              value: _albums.indexOf(__album)
            ));
            final _result = await spotify.search.get(album+" artist:"+artist, types: [SearchType.album]).first();
            final AlbumSimple? _album = _result.first.items?.firstWhere((element) => ratio(element.name.toLowerCase(), album.toLowerCase()) >= 85, orElse: () => null);
            if (_album == null) continue;
            final _cover = _album.images?.first.url;
            final _spid = _album.id;
            
            // Write the album cover to disk
            final _dir = cacheDir+"/album_covers";
            await Directory(_dir).create();
            late final File coverFile;
            var output = AlbumTableCompanion(spotifyId: Value(_spid));
            if (_cover != null && cover_ == null) {
              coverFile = File(_dir+"/"+base64Encode(utf8.encode(artist))+"."+base64Encode(utf8.encode(album))+"_spotify.jpg");
              await Dio().download(_cover, coverFile.absolute.uri.toFilePath());
              output = output.copyWith(
                coverUri: Value(coverFile.absolute.uri),
                coverSource: const Value("spotify"),
              );
            }
            if (_cover != null && __album.read(db.albumTable.coverUriRemote) == null) {
              output = output.copyWith(
                coverUriRemote: Value(Uri.parse(_cover)),
              );
            }
            await (db.albumTable.update()
              ..where((tbl) => tbl.name.equals(album) & tbl.artistName.equals(artist))
            ).write(output);
          }
        }
      });
    }

    sendProgressReport.send(const IndexerProgressReport(
      state: IndexerState.FINISHED,
      max: 1,
      value: 1
    ));
  }

  Future<AlbumMetadata?> registerAlbumMetadata(TrackMetadata track) async {
    if (track.albumArtistName == null || track.albumName == null) return null;
    final record = await db.tryGetAlbum(track.albumName!, by: track.albumArtistName!);
    if (newAlbums.contains(track.albumArtistName!+" - "+track.albumName!) || (record != null && !force)) return record;
    newAlbums.add(track.albumArtistName!+" - "+track.albumName!);
    final id = nanoid(12);
    var _record = AlbumMetadata(
      artistName: track.albumArtistName!,
      name: track.albumName!,
      coverUri: track.coverUri,
      artistId: track.albumArtistId,
      id: id
    );
    await db.albumTable.insert().insertOnConflictUpdate(_record);
    return _record;
  }

  Future<ArtistMetadata?> registerArtistMetadata(TrackMetadata track, [bool albumArtist = false]) async {
    if (albumArtist && track.albumArtistName == null) return null;
    if (!albumArtist && track.artistName == null) return null;
    //final record = artistStore.record(track.artistName!);
    final record = await db.tryGetArtist(albumArtist ? track.albumArtistName! : track.artistName!);
    if (newArtists.contains(track.artistName!) || (record != null && !force)) return record;
    newArtists.add(track.artistName!);
    final id = nanoid(10);
    ArtistMetadata _record = ArtistMetadata(
      name: track.artistName!,
      id: id
    );
    await db.artistTable.insert().insertOnConflictUpdate(_record);
    return _record;
  }

}

class IndexerProgressReport {
  final int value;
  final int max;
  final String? currentFilename;
  final IndexerState state;
  const IndexerProgressReport({
    this.value = 0,
    this.max = 0,
    this.currentFilename,
    required this.state
  }) : assert(value <= max, "Invalid [value]");
}
enum IndexerState {
  /// Performing the initial filesystem scan.
  STARTING,
  /// Importing metadata from the files.
  SCANNING,
  /// Fetching data about artists, albums, and some
  /// tracks from the Internet.
  FETCHING,
  /// Determining data about newly added artists and albums,
  /// such as calculating track count and total duration.
  ANALYZING,
  /// Cleaning up metadata for removed library entries
  /// (or missing files in certain circumstances).
  CLEANING,
  /// The indexing is almost complete.
  FINISHING,
  /// The indexer stopped early and did not finish.
  STOPPED,
  /// The indexer has finished and exited.
  FINISHED
}


extension on String? {
  bool exists() {
    return this?.isNotEmpty ?? false;
  }
}