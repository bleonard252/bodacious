import 'package:bodacious/drift/track_data.dart';
import 'package:bodacious/models/album_data.dart';
import 'package:drift/drift.dart';

@UseRowClass(AlbumMetadata)
class AlbumTable extends Table {
  @override
  get primaryKey => {artistName, name};
  TextColumn get name => text()();
  TextColumn get artistName => text()();
  TextColumn get coverUri => text().map(UriConverter()).nullable()();
  TextColumn get coverUriRemote => text().map(UriConverter()).nullable()();
  TextColumn get coverSource => text().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get descriptionSource => text().nullable()();
  IntColumn get trackCount => integer().nullable()();
  IntColumn get year => integer().nullable()();
  DateTimeColumn get releaseDate => dateTime().nullable()();
  TextColumn get spotifyId => text().nullable()();
  TextColumn get metadataSource => text().nullable()();
}