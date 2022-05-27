import 'dart:io';

import 'package:bodacious/drift/album_data.dart';
import 'package:bodacious/drift/artist_data.dart';
import 'package:bodacious/drift/track_data.dart';
import 'package:bodacious/models/album_data.dart';
import 'package:bodacious/models/artist_data.dart';
import 'package:bodacious/models/track_data.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:nanoid/non_secure.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

@DriftDatabase(tables: [AlbumTable, ArtistTable, TrackTable])
class BoDatabase extends _$BoDatabase {
  // we tell the database where to store the data with this constructor
  BoDatabase() : super(_openConnection());

  BoDatabase.fromExecutor(QueryExecutor e) : super(e);

  BoDatabase.connect(DatabaseConnection connection) : super.connect(connection);

  // you should bump this number whenever you change or add a table definition
  @override
  int get schemaVersion => 9;

  Future<TrackMetadata?> tryGetTrackFromUri(Uri uri) {
    return (
      select(trackTable)
      ..where((tbl) => tbl.uri.equalsValue(uri))
    ).getSingleOrNull();
  }
  Future<ArtistMetadata?> tryGetArtist(String artistName) {
    return (
      select(artistTable)
      ..where((tbl) => tbl.name.equals(artistName))
    ).getSingleOrNull();
  }
  Future<AlbumMetadata?> tryGetAlbum(String albumName, {required String by}) {
    return (
      select(albumTable)
      ..where((tbl) => tbl.name.equals(albumName) & tbl.artistName.equals(by))
    ).getSingleOrNull();
  }
  Future<List<TrackMetadata>> tryGetAlbumTracks(String albumName, {required String by}) {
    return (
      select(trackTable)
      ..where((tbl) => tbl.albumName.equals(albumName) & tbl.artistName.equals(by))
      ..orderBy([
        (tbl) => OrderingTerm.asc(tbl.discNo),
        (tbl) => OrderingTerm.asc(tbl.trackNo),
      ])
    ).get();
  }

  Future<String?> tryGetAlbumId(String albumName, {required String by}) {
    return (
      selectOnly(albumTable)
      ..addColumns([albumTable.name, albumTable.artistName, albumTable.id])
      ..where(albumTable.name.equals(albumName) & albumTable.artistName.equals(by))
    ).getSingleOrNull().then((v) => v?.readTableOrNull(albumTable)?.id);
  }
  Future<String?> tryGetArtistId(String artistName) {
    return (
      selectOnly(artistTable)
      ..addColumns([artistTable.name, artistTable.id])
      ..where(artistTable.name.equals(artistName))
    ).getSingleOrNull().then((v) => v?.readTableOrNull(artistTable)?.id);
  }

  @override
  MigrationStrategy get migration => MigrationStrategy(
    beforeOpen: (d) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
    onUpgrade: (m, from, to) async {
      if (from > to) throw UnsupportedError("Downgrades are not supported");
      if (to == 9) {
        // This is gonna hurt, at least for the cached stuff,
        // just a little bit.
        // Apparently the migrator doesn't support changing the
        // primary keys (we're gonna use proper IDs now).
        m.drop(albumTable);
        m.drop(trackTable);
        m.drop(artistTable);
      }
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    late String dbPath;
    try {
      dbPath = (await getLibraryDirectory()).absolute.path;
    } catch(_) {
      print(_);
      try {
        dbPath = (await getApplicationSupportDirectory()).absolute.path;
      } catch(_) {
        dbPath = (await getApplicationDocumentsDirectory()).absolute.path;
      }
    }
    final file = File(p.join(dbPath, '_boLibrary.sqlite'));
    return NativeDatabase(file);
  });
}

extension on TrackMetadata {
  Future<ArtistMetadata?> getArtist(BoDatabase db, [bool albumArtist = false]) {
    return (
      db.select(db.artistTable)
      ..where((tbl) => tbl.id.equals(albumArtist ? albumArtistId : trackArtistId))
    ).getSingleOrNull();
  }
  Future<AlbumMetadata?> getAlbum(BoDatabase db) {
    return (
      db.select(db.albumTable)
      ..where((tbl) => tbl.id.equals(albumId))
    ).getSingleOrNull();
  }
}