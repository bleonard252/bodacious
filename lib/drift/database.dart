import 'dart:io';

import 'package:bodacious/drift/album_data.dart';
import 'package:bodacious/drift/artist_data.dart';
import 'package:bodacious/drift/track_data.dart';
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
  int get schemaVersion => 1;
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