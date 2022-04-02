import 'package:bodacious/drift/track_data.dart';
import 'package:bodacious/models/artist_data.dart';
import 'package:drift/drift.dart';

@UseRowClass(ArtistMetadata)
class ArtistTable extends Table {
  @override
  get primaryKey => {name};
  TextColumn get name => text()();
  TextColumn get coverUri => text().map(UriConverter()).nullable()();
  IntColumn get trackCount => integer().nullable()();
}