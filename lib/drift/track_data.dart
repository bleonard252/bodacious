import 'package:bodacious/models/track_data.dart';
import 'package:drift/drift.dart';

@UseRowClass(TrackMetadata)
class TrackTable extends Table {
  @override
  get primaryKey => {uri};
  TextColumn get title => text().nullable()();
  TextColumn get artistName => text().nullable()();
  TextColumn get albumName => text().nullable()();
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
  Uri? mapToDart(String? fromDb) {
    if (fromDb != null) {
      return Uri.tryParse(fromDb);
    } else {
      return null;
    }
  }

  @override
  String? mapToSql(Uri? value) {
    return value?.toString();
  }
}
class DurationConverter extends TypeConverter<Duration, int> {
  @override
  Duration? mapToDart(int? fromDb) {
    if (fromDb != null) {
      return Duration(milliseconds: fromDb);
    } else {
      return null;
    }
  }

  @override
  int? mapToSql(Duration? value) {
    return value?.inMilliseconds;
  }
}