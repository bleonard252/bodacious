import 'package:bodacious/drift/track_data.dart';
import 'package:bodacious/models/artist_data.dart';
import 'package:drift/drift.dart';
import 'package:nanoid/non_secure.dart';

@UseRowClass(ArtistMetadata)
class ArtistTable extends Table {
  @override
  get primaryKey => {id};
  TextColumn get id => text().withLength(max: 20, min: 7).clientDefault(() => nanoid(10))();
  TextColumn get name => text()();
  TextColumn get coverUri => text().map(UriConverter()).nullable()();
  TextColumn get coverUriRemote => text().map(UriConverter()).nullable()();
  TextColumn get coverSource => text().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get descriptionSource => text().nullable()();
  IntColumn get trackCount => integer().nullable()();
  IntColumn get albumCount => integer().nullable()();
  TextColumn get spotifyId => text().nullable()();
  TextColumn get metadataSource => text().nullable()();
}