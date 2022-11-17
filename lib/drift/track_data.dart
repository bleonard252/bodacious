import 'package:bodacious/drift/album_data.dart';
import 'package:bodacious/models/track_data.dart';
import 'package:drift/drift.dart';
import 'package:nanoid/non_secure.dart';

import 'artist_data.dart';

@UseRowClass(TrackMetadata)
class TrackTable extends Table {
  @override
  get primaryKey => {id};
  TextColumn get id => text().withLength(max: 20, min: 7).clientDefault(() => nanoid(13))();
  TextColumn get title => text().nullable()();
  TextColumn get artistName => text().nullable()();
  TextColumn get trackArtistId => text().nullable().references(ArtistTable, #id)();
  TextColumn get albumArtistName => text().nullable()();
  TextColumn get albumArtistId => text().nullable().references(ArtistTable, #id)();
  TextColumn get albumName => text().nullable()();
  TextColumn get albumId => text().nullable().references(AlbumTable, #id)();
  IntColumn get trackNo => integer().withDefault(const Constant(0))();
  IntColumn get discNo => integer().withDefault(const Constant(0))();
  TextColumn get description => text().nullable()();
  TextColumn get descriptionSource => text().nullable()();
  TextColumn get uri => text().map(UriConverter())();
  TextColumn get coverUri => text().map(UriConverter()).nullable()();
  TextColumn get coverUriRemote => text().map(UriConverter()).nullable()();
  TextColumn get coverSource => text().nullable()();
  IntColumn get duration => integer().map(DurationConverter()).nullable()();
  IntColumn get year => integer().nullable()();
  DateTimeColumn get releaseDate => dateTime().nullable()();
  BoolColumn get available => boolean().withDefault(const Constant(true))();
  TextColumn get spotifyId => text().nullable()();
  TextColumn get source => text().nullable()();
  TextColumn get metadataSource => text().nullable()();
}
class UriConverter extends TypeConverter<Uri, String> {
  @override
  Uri fromSql(String fromDb) {
    return Uri.parse(fromDb);
  }

  @override
  String toSql(Uri value) {
    return value.toString();
  }
}
class DurationConverter extends TypeConverter<Duration, int> {
  @override
  Duration fromSql(int fromDb) {
    return Duration(milliseconds: fromDb);
  }

  @override
  int toSql(Duration value) {
    return value.inMilliseconds;
  }
}