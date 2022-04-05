// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class AlbumTableCompanion extends UpdateCompanion<AlbumMetadata> {
  final Value<String> name;
  final Value<String> artistName;
  final Value<Uri?> coverUri;
  final Value<int?> trackCount;
  final Value<int?> year;
  final Value<DateTime?> releaseDate;
  const AlbumTableCompanion({
    this.name = const Value.absent(),
    this.artistName = const Value.absent(),
    this.coverUri = const Value.absent(),
    this.trackCount = const Value.absent(),
    this.year = const Value.absent(),
    this.releaseDate = const Value.absent(),
  });
  AlbumTableCompanion.insert({
    required String name,
    required String artistName,
    this.coverUri = const Value.absent(),
    this.trackCount = const Value.absent(),
    this.year = const Value.absent(),
    this.releaseDate = const Value.absent(),
  })  : name = Value(name),
        artistName = Value(artistName);
  static Insertable<AlbumMetadata> custom({
    Expression<String>? name,
    Expression<String>? artistName,
    Expression<Uri?>? coverUri,
    Expression<int?>? trackCount,
    Expression<int?>? year,
    Expression<DateTime?>? releaseDate,
  }) {
    return RawValuesInsertable({
      if (name != null) 'name': name,
      if (artistName != null) 'artist_name': artistName,
      if (coverUri != null) 'cover_uri': coverUri,
      if (trackCount != null) 'track_count': trackCount,
      if (year != null) 'year': year,
      if (releaseDate != null) 'release_date': releaseDate,
    });
  }

  AlbumTableCompanion copyWith(
      {Value<String>? name,
      Value<String>? artistName,
      Value<Uri?>? coverUri,
      Value<int?>? trackCount,
      Value<int?>? year,
      Value<DateTime?>? releaseDate}) {
    return AlbumTableCompanion(
      name: name ?? this.name,
      artistName: artistName ?? this.artistName,
      coverUri: coverUri ?? this.coverUri,
      trackCount: trackCount ?? this.trackCount,
      year: year ?? this.year,
      releaseDate: releaseDate ?? this.releaseDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (artistName.present) {
      map['artist_name'] = Variable<String>(artistName.value);
    }
    if (coverUri.present) {
      final converter = $AlbumTableTable.$converter0;
      map['cover_uri'] = Variable<String?>(converter.mapToSql(coverUri.value));
    }
    if (trackCount.present) {
      map['track_count'] = Variable<int?>(trackCount.value);
    }
    if (year.present) {
      map['year'] = Variable<int?>(year.value);
    }
    if (releaseDate.present) {
      map['release_date'] = Variable<DateTime?>(releaseDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AlbumTableCompanion(')
          ..write('name: $name, ')
          ..write('artistName: $artistName, ')
          ..write('coverUri: $coverUri, ')
          ..write('trackCount: $trackCount, ')
          ..write('year: $year, ')
          ..write('releaseDate: $releaseDate')
          ..write(')'))
        .toString();
  }
}

class $AlbumTableTable extends AlbumTable
    with TableInfo<$AlbumTableTable, AlbumMetadata> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AlbumTableTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta __idMeta = const VerificationMeta('_id');
  @override
  late final GeneratedColumn<String?> _id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      generatedAs:
          GeneratedAs(artistName + const Constant(" - ") + name, false));
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _artistNameMeta = const VerificationMeta('artistName');
  @override
  late final GeneratedColumn<String?> artistName = GeneratedColumn<String?>(
      'artist_name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _coverUriMeta = const VerificationMeta('coverUri');
  @override
  late final GeneratedColumnWithTypeConverter<Uri, String?> coverUri =
      GeneratedColumn<String?>('cover_uri', aliasedName, true,
              type: const StringType(), requiredDuringInsert: false)
          .withConverter<Uri>($AlbumTableTable.$converter0);
  final VerificationMeta _trackCountMeta = const VerificationMeta('trackCount');
  @override
  late final GeneratedColumn<int?> trackCount = GeneratedColumn<int?>(
      'track_count', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int?> year = GeneratedColumn<int?>(
      'year', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _releaseDateMeta =
      const VerificationMeta('releaseDate');
  @override
  late final GeneratedColumn<DateTime?> releaseDate =
      GeneratedColumn<DateTime?>('release_date', aliasedName, true,
          type: const IntType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [_id, name, artistName, coverUri, trackCount, year, releaseDate];
  @override
  String get aliasedName => _alias ?? 'album_table';
  @override
  String get actualTableName => 'album_table';
  @override
  VerificationContext validateIntegrity(Insertable<AlbumMetadata> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(
          __idMeta, _id.isAcceptableOrUnknown(data['id']!, __idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('artist_name')) {
      context.handle(
          _artistNameMeta,
          artistName.isAcceptableOrUnknown(
              data['artist_name']!, _artistNameMeta));
    } else if (isInserting) {
      context.missing(_artistNameMeta);
    }
    context.handle(_coverUriMeta, const VerificationResult.success());
    if (data.containsKey('track_count')) {
      context.handle(
          _trackCountMeta,
          trackCount.isAcceptableOrUnknown(
              data['track_count']!, _trackCountMeta));
    }
    if (data.containsKey('year')) {
      context.handle(
          _yearMeta, year.isAcceptableOrUnknown(data['year']!, _yearMeta));
    }
    if (data.containsKey('release_date')) {
      context.handle(
          _releaseDateMeta,
          releaseDate.isAcceptableOrUnknown(
              data['release_date']!, _releaseDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {_id};
  @override
  AlbumMetadata map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AlbumMetadata(
      artistName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}artist_name'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      coverUri: $AlbumTableTable.$converter0.mapToDart(const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}cover_uri'])),
      trackCount: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}track_count']),
      year: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}year']),
      releaseDate: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}release_date']),
    );
  }

  @override
  $AlbumTableTable createAlias(String alias) {
    return $AlbumTableTable(attachedDatabase, alias);
  }

  static TypeConverter<Uri, String> $converter0 = UriConverter();
}

class ArtistTableCompanion extends UpdateCompanion<ArtistMetadata> {
  final Value<String> name;
  final Value<Uri?> coverUri;
  final Value<int?> trackCount;
  final Value<int?> albumCount;
  const ArtistTableCompanion({
    this.name = const Value.absent(),
    this.coverUri = const Value.absent(),
    this.trackCount = const Value.absent(),
    this.albumCount = const Value.absent(),
  });
  ArtistTableCompanion.insert({
    required String name,
    this.coverUri = const Value.absent(),
    this.trackCount = const Value.absent(),
    this.albumCount = const Value.absent(),
  }) : name = Value(name);
  static Insertable<ArtistMetadata> custom({
    Expression<String>? name,
    Expression<Uri?>? coverUri,
    Expression<int?>? trackCount,
    Expression<int?>? albumCount,
  }) {
    return RawValuesInsertable({
      if (name != null) 'name': name,
      if (coverUri != null) 'cover_uri': coverUri,
      if (trackCount != null) 'track_count': trackCount,
      if (albumCount != null) 'album_count': albumCount,
    });
  }

  ArtistTableCompanion copyWith(
      {Value<String>? name,
      Value<Uri?>? coverUri,
      Value<int?>? trackCount,
      Value<int?>? albumCount}) {
    return ArtistTableCompanion(
      name: name ?? this.name,
      coverUri: coverUri ?? this.coverUri,
      trackCount: trackCount ?? this.trackCount,
      albumCount: albumCount ?? this.albumCount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (coverUri.present) {
      final converter = $ArtistTableTable.$converter0;
      map['cover_uri'] = Variable<String?>(converter.mapToSql(coverUri.value));
    }
    if (trackCount.present) {
      map['track_count'] = Variable<int?>(trackCount.value);
    }
    if (albumCount.present) {
      map['album_count'] = Variable<int?>(albumCount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ArtistTableCompanion(')
          ..write('name: $name, ')
          ..write('coverUri: $coverUri, ')
          ..write('trackCount: $trackCount, ')
          ..write('albumCount: $albumCount')
          ..write(')'))
        .toString();
  }
}

class $ArtistTableTable extends ArtistTable
    with TableInfo<$ArtistTableTable, ArtistMetadata> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ArtistTableTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _coverUriMeta = const VerificationMeta('coverUri');
  @override
  late final GeneratedColumnWithTypeConverter<Uri, String?> coverUri =
      GeneratedColumn<String?>('cover_uri', aliasedName, true,
              type: const StringType(), requiredDuringInsert: false)
          .withConverter<Uri>($ArtistTableTable.$converter0);
  final VerificationMeta _trackCountMeta = const VerificationMeta('trackCount');
  @override
  late final GeneratedColumn<int?> trackCount = GeneratedColumn<int?>(
      'track_count', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _albumCountMeta = const VerificationMeta('albumCount');
  @override
  late final GeneratedColumn<int?> albumCount = GeneratedColumn<int?>(
      'album_count', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [name, coverUri, trackCount, albumCount];
  @override
  String get aliasedName => _alias ?? 'artist_table';
  @override
  String get actualTableName => 'artist_table';
  @override
  VerificationContext validateIntegrity(Insertable<ArtistMetadata> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    context.handle(_coverUriMeta, const VerificationResult.success());
    if (data.containsKey('track_count')) {
      context.handle(
          _trackCountMeta,
          trackCount.isAcceptableOrUnknown(
              data['track_count']!, _trackCountMeta));
    }
    if (data.containsKey('album_count')) {
      context.handle(
          _albumCountMeta,
          albumCount.isAcceptableOrUnknown(
              data['album_count']!, _albumCountMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {name};
  @override
  ArtistMetadata map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ArtistMetadata(
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      coverUri: $ArtistTableTable.$converter0.mapToDart(const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}cover_uri'])),
      albumCount: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}album_count']),
      trackCount: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}track_count']),
    );
  }

  @override
  $ArtistTableTable createAlias(String alias) {
    return $ArtistTableTable(attachedDatabase, alias);
  }

  static TypeConverter<Uri, String> $converter0 = UriConverter();
}

class TrackTableCompanion extends UpdateCompanion<TrackMetadata> {
  final Value<String?> title;
  final Value<String?> artistName;
  final Value<String?> albumName;
  final Value<int> trackNo;
  final Value<int> discNo;
  final Value<Uri> uri;
  final Value<Uri?> coverUri;
  final Value<Duration?> duration;
  final Value<int?> year;
  final Value<DateTime?> releaseDate;
  final Value<bool> available;
  const TrackTableCompanion({
    this.title = const Value.absent(),
    this.artistName = const Value.absent(),
    this.albumName = const Value.absent(),
    this.trackNo = const Value.absent(),
    this.discNo = const Value.absent(),
    this.uri = const Value.absent(),
    this.coverUri = const Value.absent(),
    this.duration = const Value.absent(),
    this.year = const Value.absent(),
    this.releaseDate = const Value.absent(),
    this.available = const Value.absent(),
  });
  TrackTableCompanion.insert({
    this.title = const Value.absent(),
    this.artistName = const Value.absent(),
    this.albumName = const Value.absent(),
    this.trackNo = const Value.absent(),
    this.discNo = const Value.absent(),
    required Uri uri,
    this.coverUri = const Value.absent(),
    this.duration = const Value.absent(),
    this.year = const Value.absent(),
    this.releaseDate = const Value.absent(),
    this.available = const Value.absent(),
  }) : uri = Value(uri);
  static Insertable<TrackMetadata> custom({
    Expression<String?>? title,
    Expression<String?>? artistName,
    Expression<String?>? albumName,
    Expression<int>? trackNo,
    Expression<int>? discNo,
    Expression<Uri>? uri,
    Expression<Uri?>? coverUri,
    Expression<Duration?>? duration,
    Expression<int?>? year,
    Expression<DateTime?>? releaseDate,
    Expression<bool>? available,
  }) {
    return RawValuesInsertable({
      if (title != null) 'title': title,
      if (artistName != null) 'artist_name': artistName,
      if (albumName != null) 'album_name': albumName,
      if (trackNo != null) 'track_no': trackNo,
      if (discNo != null) 'disc_no': discNo,
      if (uri != null) 'uri': uri,
      if (coverUri != null) 'cover_uri': coverUri,
      if (duration != null) 'duration': duration,
      if (year != null) 'year': year,
      if (releaseDate != null) 'release_date': releaseDate,
      if (available != null) 'available': available,
    });
  }

  TrackTableCompanion copyWith(
      {Value<String?>? title,
      Value<String?>? artistName,
      Value<String?>? albumName,
      Value<int>? trackNo,
      Value<int>? discNo,
      Value<Uri>? uri,
      Value<Uri?>? coverUri,
      Value<Duration?>? duration,
      Value<int?>? year,
      Value<DateTime?>? releaseDate,
      Value<bool>? available}) {
    return TrackTableCompanion(
      title: title ?? this.title,
      artistName: artistName ?? this.artistName,
      albumName: albumName ?? this.albumName,
      trackNo: trackNo ?? this.trackNo,
      discNo: discNo ?? this.discNo,
      uri: uri ?? this.uri,
      coverUri: coverUri ?? this.coverUri,
      duration: duration ?? this.duration,
      year: year ?? this.year,
      releaseDate: releaseDate ?? this.releaseDate,
      available: available ?? this.available,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (title.present) {
      map['title'] = Variable<String?>(title.value);
    }
    if (artistName.present) {
      map['artist_name'] = Variable<String?>(artistName.value);
    }
    if (albumName.present) {
      map['album_name'] = Variable<String?>(albumName.value);
    }
    if (trackNo.present) {
      map['track_no'] = Variable<int>(trackNo.value);
    }
    if (discNo.present) {
      map['disc_no'] = Variable<int>(discNo.value);
    }
    if (uri.present) {
      final converter = $TrackTableTable.$converter0;
      map['uri'] = Variable<String>(converter.mapToSql(uri.value)!);
    }
    if (coverUri.present) {
      final converter = $TrackTableTable.$converter1;
      map['cover_uri'] = Variable<String?>(converter.mapToSql(coverUri.value));
    }
    if (duration.present) {
      final converter = $TrackTableTable.$converter2;
      map['duration'] = Variable<int?>(converter.mapToSql(duration.value));
    }
    if (year.present) {
      map['year'] = Variable<int?>(year.value);
    }
    if (releaseDate.present) {
      map['release_date'] = Variable<DateTime?>(releaseDate.value);
    }
    if (available.present) {
      map['available'] = Variable<bool>(available.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrackTableCompanion(')
          ..write('title: $title, ')
          ..write('artistName: $artistName, ')
          ..write('albumName: $albumName, ')
          ..write('trackNo: $trackNo, ')
          ..write('discNo: $discNo, ')
          ..write('uri: $uri, ')
          ..write('coverUri: $coverUri, ')
          ..write('duration: $duration, ')
          ..write('year: $year, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('available: $available')
          ..write(')'))
        .toString();
  }
}

class $TrackTableTable extends TrackTable
    with TableInfo<$TrackTableTable, TrackMetadata> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TrackTableTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _artistNameMeta = const VerificationMeta('artistName');
  @override
  late final GeneratedColumn<String?> artistName = GeneratedColumn<String?>(
      'artist_name', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _albumNameMeta = const VerificationMeta('albumName');
  @override
  late final GeneratedColumn<String?> albumName = GeneratedColumn<String?>(
      'album_name', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _trackNoMeta = const VerificationMeta('trackNo');
  @override
  late final GeneratedColumn<int?> trackNo = GeneratedColumn<int?>(
      'track_no', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  final VerificationMeta _discNoMeta = const VerificationMeta('discNo');
  @override
  late final GeneratedColumn<int?> discNo = GeneratedColumn<int?>(
      'disc_no', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  final VerificationMeta _uriMeta = const VerificationMeta('uri');
  @override
  late final GeneratedColumnWithTypeConverter<Uri, String?> uri =
      GeneratedColumn<String?>('uri', aliasedName, false,
              type: const StringType(), requiredDuringInsert: true)
          .withConverter<Uri>($TrackTableTable.$converter0);
  final VerificationMeta _coverUriMeta = const VerificationMeta('coverUri');
  @override
  late final GeneratedColumnWithTypeConverter<Uri, String?> coverUri =
      GeneratedColumn<String?>('cover_uri', aliasedName, true,
              type: const StringType(), requiredDuringInsert: false)
          .withConverter<Uri>($TrackTableTable.$converter1);
  final VerificationMeta _durationMeta = const VerificationMeta('duration');
  @override
  late final GeneratedColumnWithTypeConverter<Duration, int?> duration =
      GeneratedColumn<int?>('duration', aliasedName, true,
              type: const IntType(), requiredDuringInsert: false)
          .withConverter<Duration>($TrackTableTable.$converter2);
  final VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int?> year = GeneratedColumn<int?>(
      'year', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _releaseDateMeta =
      const VerificationMeta('releaseDate');
  @override
  late final GeneratedColumn<DateTime?> releaseDate =
      GeneratedColumn<DateTime?>('release_date', aliasedName, true,
          type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _availableMeta = const VerificationMeta('available');
  @override
  late final GeneratedColumn<bool?> available = GeneratedColumn<bool?>(
      'available', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (available IN (0, 1))',
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns => [
        title,
        artistName,
        albumName,
        trackNo,
        discNo,
        uri,
        coverUri,
        duration,
        year,
        releaseDate,
        available
      ];
  @override
  String get aliasedName => _alias ?? 'track_table';
  @override
  String get actualTableName => 'track_table';
  @override
  VerificationContext validateIntegrity(Insertable<TrackMetadata> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('artist_name')) {
      context.handle(
          _artistNameMeta,
          artistName.isAcceptableOrUnknown(
              data['artist_name']!, _artistNameMeta));
    }
    if (data.containsKey('album_name')) {
      context.handle(_albumNameMeta,
          albumName.isAcceptableOrUnknown(data['album_name']!, _albumNameMeta));
    }
    if (data.containsKey('track_no')) {
      context.handle(_trackNoMeta,
          trackNo.isAcceptableOrUnknown(data['track_no']!, _trackNoMeta));
    }
    if (data.containsKey('disc_no')) {
      context.handle(_discNoMeta,
          discNo.isAcceptableOrUnknown(data['disc_no']!, _discNoMeta));
    }
    context.handle(_uriMeta, const VerificationResult.success());
    context.handle(_coverUriMeta, const VerificationResult.success());
    context.handle(_durationMeta, const VerificationResult.success());
    if (data.containsKey('year')) {
      context.handle(
          _yearMeta, year.isAcceptableOrUnknown(data['year']!, _yearMeta));
    }
    if (data.containsKey('release_date')) {
      context.handle(
          _releaseDateMeta,
          releaseDate.isAcceptableOrUnknown(
              data['release_date']!, _releaseDateMeta));
    }
    if (data.containsKey('available')) {
      context.handle(_availableMeta,
          available.isAcceptableOrUnknown(data['available']!, _availableMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uri};
  @override
  TrackMetadata map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TrackMetadata(
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title']),
      artistName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}artist_name']),
      albumName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}album_name']),
      trackNo: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}track_no'])!,
      discNo: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}disc_no'])!,
      uri: $TrackTableTable.$converter0.mapToDart(const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}uri']))!,
      coverUri: $TrackTableTable.$converter1.mapToDart(const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}cover_uri'])),
      duration: $TrackTableTable.$converter2.mapToDart(const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}duration'])),
      year: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}year']),
      releaseDate: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}release_date']),
      available: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}available'])!,
    );
  }

  @override
  $TrackTableTable createAlias(String alias) {
    return $TrackTableTable(attachedDatabase, alias);
  }

  static TypeConverter<Uri, String> $converter0 = UriConverter();
  static TypeConverter<Uri, String> $converter1 = UriConverter();
  static TypeConverter<Duration, int> $converter2 = DurationConverter();
}

abstract class _$BoDatabase extends GeneratedDatabase {
  _$BoDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  _$BoDatabase.connect(DatabaseConnection c) : super.connect(c);
  late final $AlbumTableTable albumTable = $AlbumTableTable(this);
  late final $ArtistTableTable artistTable = $ArtistTableTable(this);
  late final $TrackTableTable trackTable = $TrackTableTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [albumTable, artistTable, trackTable];
}
