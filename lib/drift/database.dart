import 'dart:io';

import 'package:bodacious/drift/album_data.dart';
import 'package:bodacious/drift/artist_data.dart';
import 'package:bodacious/drift/track_data.dart';
import 'package:bodacious/models/album_data.dart';
import 'package:bodacious/models/artist_data.dart';
import 'package:bodacious/models/track_data.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

@DriftDatabase(tables: [AlbumTable, ArtistTable, TrackTable])
class BoDatabase extends _$BoDatabase {
  // we tell the database where to store the data with this constructor
  BoDatabase() : super(_openConnection());

  BoDatabase.connect(DatabaseConnection connection) : super.connect(connection);

  // you should bump this number whenever you change or add a table definition
  @override
  int get schemaVersion => 2;

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

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (m, from, to) async {
      if (from > to) throw UnsupportedError("Downgrades are not supported");
      if (to == 2) m.addColumn(trackTable, trackTable.available);
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    late final String dbPath;
    try {
      dbPath = (await getLibraryDirectory()).absolute.path;
    } catch(_) {
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