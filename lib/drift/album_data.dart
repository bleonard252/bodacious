import 'package:bodacious/drift/track_data.dart';
import 'package:bodacious/models/album_data.dart';
import 'package:drift/drift.dart';

@UseRowClass(AlbumMetadata)
class AlbumTable extends Table {
  @override
  get primaryKey => {name, artistName}; 
  TextColumn get name => text()();
  TextColumn get artistName => text()();
  TextColumn get coverUri => text().map(UriConverter()).nullable()();
  IntColumn get trackCount => integer().nullable()();
  IntColumn get year => integer().nullable()();
  DateTimeColumn get releaseDate => dateTime().nullable()();
}