import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:bodacious/src/library/cache_dir.dart';
import 'package:bodacious/src/library/init_db.dart';
import 'package:bodacious/src/metadata/id3.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart' show WidgetsFlutterBinding;
import 'package:integer/integer.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

import '../../models/track_data.dart';
import '../metadata/infer.dart';

abstract class TheIndexer {
  // Isolate main logic
  static final ReceivePort progressReceiver = ReceivePort("The Indexer's Progress Receiver");
  static dynamic _progress;
  static get progress => _progress ??=
  progressReceiver.asBroadcastStream(
    onCancel: (controller) {
      controller.pause();
    },
    onListen: (controller) async {
      if (controller.isPaused) {
        controller.resume();
      }
    },
  );

  //static late final Isolate indexerIsolate;
  
  /// Don't try to touch the isolate before this aight
  static Future<void> spawn() async {
    final _dbPath = await () async {
      late final String dbPath;
      try {
        dbPath = (await getLibraryDirectory()).absolute.path+"/_boLibrary";
      } catch(_) {
        try {
          dbPath = (await getApplicationSupportDirectory()).absolute.path+"/_boLibrary";
        } catch(_) {
          dbPath = (await getApplicationDocumentsDirectory()).absolute.path+"/_boLibrary";
        }
      }
      return dbPath;
    }();
    final _cacheDir = await getCacheDirectory();
    await compute<Map, dynamic>((message) {
      return _IndexerIsolate(dbPath: message["dbDir"], cacheDir: message["cacheDir"])(message["sendPort"]);
    }, {"sendPort": progressReceiver.sendPort, "dbDir": _dbPath, "cacheDir": _cacheDir});
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
    required this.dbPath,
    required this.cacheDir
  });

  late final Database db;
  // These are copied straight from the static metadata thing, just for safe keeping.
  final configStore = StoreRef<String, dynamic>.main();
  final artistStore = StoreRef<String, dynamic>("artists");
  final albumStore = StoreRef<String, dynamic>("albums");
  final songStore = StoreRef<String, dynamic>("songs");

  final List<FutureOr Function(DatabaseClient db)> _dbList = [];

  /// This makes this class function as a function.
  /// And gee I wonder why I did that.
  Future<void> call(SendPort sendProgressReport) async {
    if (kDebugMode) {
      print("This is not complete and may appear to hang");
      //sendProgressReport.send(const IndexerProgressReport(state: IndexerState.STARTING, max));
      //await Future.delayed(const Duration(seconds: 5)); // just so I can get to this screen
    } else {
      throw UnimplementedError("The Indexer doesn't work yet.");
    }
    db = await loadDatabase(boLibraryPath: dbPath);
    sendProgressReport.send(const IndexerProgressReport(state: IndexerState.STARTING, max: 0));
    // == STARTING PHASE == //
    StoreRef("songs").drop(db);
    List<File> validFiles = [];
    final List<String> _dbfolders = List.castFrom<dynamic, String>((await configStore.record("libraries").get(db))?.toList() as List<dynamic>? ?? []);
    for (final f in _dbfolders) {
      if (!await Directory(f).exists()) {
        if (kDebugMode) {print("INDEXER ERROR: `"+f+"` does not exist!");}
        continue; //we're in a for loop. so go to the next thing (or break if you're at the end)
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
      final _matches = await songStore.find(db, finder: Finder(filter: Filter.custom(
        // Find this file in the database.
        (record) => record.value.uri == file.absolute.uri
      )));
      // Skip processing files that have already been processed
      if (_matches.isNotEmpty) continue;
      var metaBytes = <int>[], _class = "none";
      final _metaByteReader = file.openRead().listen(null);
      double? targetLength;
      final c = Completer();
      _metaByteReader.onData((data) {
        metaBytes.addAll(data);
        if (_class == "none") {
          if (metaBytes.length >= 4 && String.fromCharCodes(metaBytes.getRange(0, 4)) == 'fLaC') {_class = "flac";}
          else if (metaBytes.length >= 3 && listEquals(metaBytes.getRange(0, 3).toList(), [73, 68, 51])) {_class = "id3";}
        }
        if (metaBytes.length >= 10*1000000 /* 10MB */) {
          _metaByteReader.cancel();
          /* Really I have no idea why you'd need more than 10MB of TAGS in a file... */
          /* If there is a case I might be able to bump it */
          metaBytes = metaBytes.take(10*1000000).toList();
          c.complete();
        }
        if (_class == "flac") {
          _metaByteReader.cancel();
          // the FLAC metadata reader reads the file itself
          // so gathering the bytes for it is not important
        } else if (_class == "id3" && metaBytes.length > 10) {
          // Determine the length of the id3 segment
          try {
            //targetLength ??= (i32.parse(metaBytes.sublist(6,10).join(""), radix: 16)).roundToDouble()+10;
            // if (metaBytes.length >= targetLength!) {
            //   _metaByteReader.cancel();
            //   c.complete();
            // }
          } catch(e) {
            if (kDebugMode) {print(e);}
            _metaByteReader.cancel();
            c.complete();
            metaBytes.clear();
            _class = "none";
            return;
          }
        }
        if (metaBytes.length > 20 && _class == "none") {
          c.complete();
          _metaByteReader.cancel();
          metaBytes.clear();
        }
      });
      _metaByteReader.onDone(() {c.complete();});
      _metaByteReader.onError((_) {c.complete();});
      await Future.any([c.future, _metaByteReader.asFuture()]);

      final _mseFile = File(file.path.replaceFirst(fileExtensionRegex, ".mse"));
      // final _mse = (await _mseFile.exists()) ? await parseMseFile(_mseFile.openRead()) : null;
      final TrackMetadata? _id3 = (/* _mse == null && */ _class == "id3" || _class == "flac") ? await loadID3FromBytes(metaBytes, file, cacheDir: cacheDir) : null;
      final TrackMetadata? _ctxmeta = (/* _mse == null && */ _id3 == null) ? inferMetadataFromContext(file.absolute.uri)
      .copyWith(coverUri: (await inferCoverFile(file))?.absolute.uri) : null;
      final TrackMetadata record = (/*_mse ??*/ _id3 ?? _ctxmeta ?? const TrackMetadata()).copyWith(
        uri: file.absolute.uri
      );
      final tr_rec = songStore.record(record.artistName?.isEmpty != false || record.title?.isEmpty != false
        ? file.uri.pathSegments.last
        : record.artistName! +" - "+ record.title!
      );
      //if (!await tr_rec.exists(db))
      await tr_rec.put(db, record.toJson());
      // TODO: create artist & album metadata if it isn't there
    }
    sendProgressReport.send(const IndexerProgressReport(
      state: IndexerState.FINISHING,
      max: 0,
      value: 0
    ));
    await db.close();
    sendProgressReport.send(IndexerProgressReport(
      state: IndexerState.FINISHED,
      max: validFiles.length,
      value: validFiles.length
    ));
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