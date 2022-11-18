import 'package:bodacious/drift/database.dart';
import 'package:bodacious/drift/track_data.dart';
import 'package:bodacious/models/playlist_data.dart';
import 'package:drift/drift.dart';
import 'package:nanoid/non_secure.dart';

@UseRowClass(PlaylistMetadata)
class PlaylistTable extends Table {
  @override
  get primaryKey => {id};
  TextColumn get id => text().withLength(max: 20, min: 7).clientDefault(() => nanoid(8))();
  TextColumn get name => text()();
  TextColumn get coverUri => text().map(UriConverter()).nullable()();
  TextColumn get coverSource => text().nullable()();
  TextColumn get description => text().nullable()();
  IntColumn get trackCount => integer().nullable()();
  DateTimeColumn get createdAt => dateTime().clientDefault(() => DateTime.now())();
  IntColumn get index => integer().nullable().withDefault(const Constant(0))();
}

@DataClassName('PlaylistEntry')
class PlaylistEntries extends Table {
  @override
  get primaryKey => {id};
  TextColumn get id => text().withLength(max: 20, min: 7).clientDefault(() => nanoid(14))();
  TextColumn get playlist => text().references(PlaylistTable, #id)();
  TextColumn get track => text().references(TrackTable, #id)();
  DateTimeColumn get added => dateTime().clientDefault(() => DateTime.now())();
  IntColumn get index => integer().nullable().withDefault(const Constant(0))();
}