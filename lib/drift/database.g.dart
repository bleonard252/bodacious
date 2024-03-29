// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// DriftDatabaseGenerator
// **************************************************************************

// ignore_for_file: type=lint
class ArtistTableCompanion extends UpdateCompanion<ArtistMetadata> {
  final Value<String> id;
  final Value<String> name;
  final Value<Uri?> coverUri;
  final Value<Uri?> coverUriRemote;
  final Value<String?> coverSource;
  final Value<String?> description;
  final Value<String?> descriptionSource;
  final Value<int?> trackCount;
  final Value<int?> albumCount;
  final Value<String?> spotifyId;
  final Value<String?> metadataSource;
  const ArtistTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.coverUri = const Value.absent(),
    this.coverUriRemote = const Value.absent(),
    this.coverSource = const Value.absent(),
    this.description = const Value.absent(),
    this.descriptionSource = const Value.absent(),
    this.trackCount = const Value.absent(),
    this.albumCount = const Value.absent(),
    this.spotifyId = const Value.absent(),
    this.metadataSource = const Value.absent(),
  });
  ArtistTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.coverUri = const Value.absent(),
    this.coverUriRemote = const Value.absent(),
    this.coverSource = const Value.absent(),
    this.description = const Value.absent(),
    this.descriptionSource = const Value.absent(),
    this.trackCount = const Value.absent(),
    this.albumCount = const Value.absent(),
    this.spotifyId = const Value.absent(),
    this.metadataSource = const Value.absent(),
  }) : name = Value(name);
  static Insertable<ArtistMetadata> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? coverUri,
    Expression<String>? coverUriRemote,
    Expression<String>? coverSource,
    Expression<String>? description,
    Expression<String>? descriptionSource,
    Expression<int>? trackCount,
    Expression<int>? albumCount,
    Expression<String>? spotifyId,
    Expression<String>? metadataSource,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (coverUri != null) 'cover_uri': coverUri,
      if (coverUriRemote != null) 'cover_uri_remote': coverUriRemote,
      if (coverSource != null) 'cover_source': coverSource,
      if (description != null) 'description': description,
      if (descriptionSource != null) 'description_source': descriptionSource,
      if (trackCount != null) 'track_count': trackCount,
      if (albumCount != null) 'album_count': albumCount,
      if (spotifyId != null) 'spotify_id': spotifyId,
      if (metadataSource != null) 'metadata_source': metadataSource,
    });
  }

  ArtistTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<Uri?>? coverUri,
      Value<Uri?>? coverUriRemote,
      Value<String?>? coverSource,
      Value<String?>? description,
      Value<String?>? descriptionSource,
      Value<int?>? trackCount,
      Value<int?>? albumCount,
      Value<String?>? spotifyId,
      Value<String?>? metadataSource}) {
    return ArtistTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      coverUri: coverUri ?? this.coverUri,
      coverUriRemote: coverUriRemote ?? this.coverUriRemote,
      coverSource: coverSource ?? this.coverSource,
      description: description ?? this.description,
      descriptionSource: descriptionSource ?? this.descriptionSource,
      trackCount: trackCount ?? this.trackCount,
      albumCount: albumCount ?? this.albumCount,
      spotifyId: spotifyId ?? this.spotifyId,
      metadataSource: metadataSource ?? this.metadataSource,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (coverUri.present) {
      final converter = $ArtistTableTable.$converter0n;
      map['cover_uri'] = Variable<String>(converter.toSql(coverUri.value));
    }
    if (coverUriRemote.present) {
      final converter = $ArtistTableTable.$converter1n;
      map['cover_uri_remote'] =
          Variable<String>(converter.toSql(coverUriRemote.value));
    }
    if (coverSource.present) {
      map['cover_source'] = Variable<String>(coverSource.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (descriptionSource.present) {
      map['description_source'] = Variable<String>(descriptionSource.value);
    }
    if (trackCount.present) {
      map['track_count'] = Variable<int>(trackCount.value);
    }
    if (albumCount.present) {
      map['album_count'] = Variable<int>(albumCount.value);
    }
    if (spotifyId.present) {
      map['spotify_id'] = Variable<String>(spotifyId.value);
    }
    if (metadataSource.present) {
      map['metadata_source'] = Variable<String>(metadataSource.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ArtistTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('coverUri: $coverUri, ')
          ..write('coverUriRemote: $coverUriRemote, ')
          ..write('coverSource: $coverSource, ')
          ..write('description: $description, ')
          ..write('descriptionSource: $descriptionSource, ')
          ..write('trackCount: $trackCount, ')
          ..write('albumCount: $albumCount, ')
          ..write('spotifyId: $spotifyId, ')
          ..write('metadataSource: $metadataSource')
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
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 7, maxTextLength: 20),
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => nanoid(10));
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _coverUriMeta = const VerificationMeta('coverUri');
  @override
  late final GeneratedColumnWithTypeConverter<Uri?, String> coverUri =
      GeneratedColumn<String>('cover_uri', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<Uri?>($ArtistTableTable.$converter0n);
  final VerificationMeta _coverUriRemoteMeta =
      const VerificationMeta('coverUriRemote');
  @override
  late final GeneratedColumnWithTypeConverter<Uri?, String> coverUriRemote =
      GeneratedColumn<String>('cover_uri_remote', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<Uri?>($ArtistTableTable.$converter1n);
  final VerificationMeta _coverSourceMeta =
      const VerificationMeta('coverSource');
  @override
  late final GeneratedColumn<String> coverSource = GeneratedColumn<String>(
      'cover_source', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _descriptionSourceMeta =
      const VerificationMeta('descriptionSource');
  @override
  late final GeneratedColumn<String> descriptionSource =
      GeneratedColumn<String>('description_source', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _trackCountMeta = const VerificationMeta('trackCount');
  @override
  late final GeneratedColumn<int> trackCount = GeneratedColumn<int>(
      'track_count', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  final VerificationMeta _albumCountMeta = const VerificationMeta('albumCount');
  @override
  late final GeneratedColumn<int> albumCount = GeneratedColumn<int>(
      'album_count', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  final VerificationMeta _spotifyIdMeta = const VerificationMeta('spotifyId');
  @override
  late final GeneratedColumn<String> spotifyId = GeneratedColumn<String>(
      'spotify_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _metadataSourceMeta =
      const VerificationMeta('metadataSource');
  @override
  late final GeneratedColumn<String> metadataSource = GeneratedColumn<String>(
      'metadata_source', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        coverUri,
        coverUriRemote,
        coverSource,
        description,
        descriptionSource,
        trackCount,
        albumCount,
        spotifyId,
        metadataSource
      ];
  @override
  String get aliasedName => _alias ?? 'artist_table';
  @override
  String get actualTableName => 'artist_table';
  @override
  VerificationContext validateIntegrity(Insertable<ArtistMetadata> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    context.handle(_coverUriMeta, const VerificationResult.success());
    context.handle(_coverUriRemoteMeta, const VerificationResult.success());
    if (data.containsKey('cover_source')) {
      context.handle(
          _coverSourceMeta,
          coverSource.isAcceptableOrUnknown(
              data['cover_source']!, _coverSourceMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('description_source')) {
      context.handle(
          _descriptionSourceMeta,
          descriptionSource.isAcceptableOrUnknown(
              data['description_source']!, _descriptionSourceMeta));
    }
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
    if (data.containsKey('spotify_id')) {
      context.handle(_spotifyIdMeta,
          spotifyId.isAcceptableOrUnknown(data['spotify_id']!, _spotifyIdMeta));
    }
    if (data.containsKey('metadata_source')) {
      context.handle(
          _metadataSourceMeta,
          metadataSource.isAcceptableOrUnknown(
              data['metadata_source']!, _metadataSourceMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ArtistMetadata map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ArtistMetadata(
      id: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      coverUri: $ArtistTableTable.$converter0n.fromSql(attachedDatabase
          .options.types
          .read(DriftSqlType.string, data['${effectivePrefix}cover_uri'])),
      coverUriRemote: $ArtistTableTable.$converter1n.fromSql(
          attachedDatabase.options.types.read(
              DriftSqlType.string, data['${effectivePrefix}cover_uri_remote'])),
      coverSource: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}cover_source']),
      description: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      descriptionSource: attachedDatabase.options.types.read(
          DriftSqlType.string, data['${effectivePrefix}description_source']),
      albumCount: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}album_count']),
      trackCount: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}track_count']),
      spotifyId: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}spotify_id']),
      metadataSource: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}metadata_source']),
    );
  }

  @override
  $ArtistTableTable createAlias(String alias) {
    return $ArtistTableTable(attachedDatabase, alias);
  }

  static TypeConverter<Uri, String> $converter0 = UriConverter();
  static TypeConverter<Uri, String> $converter1 = UriConverter();
  static TypeConverter<Uri?, String?> $converter0n =
      NullAwareTypeConverter.wrap($converter0);
  static TypeConverter<Uri?, String?> $converter1n =
      NullAwareTypeConverter.wrap($converter1);
}

class AlbumTableCompanion extends UpdateCompanion<AlbumMetadata> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> artistName;
  final Value<String?> artistId;
  final Value<Uri?> coverUri;
  final Value<Uri?> coverUriRemote;
  final Value<String?> coverSource;
  final Value<String?> description;
  final Value<String?> descriptionSource;
  final Value<int?> trackCount;
  final Value<int?> year;
  final Value<DateTime?> releaseDate;
  final Value<String?> spotifyId;
  final Value<String?> metadataSource;
  const AlbumTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.artistName = const Value.absent(),
    this.artistId = const Value.absent(),
    this.coverUri = const Value.absent(),
    this.coverUriRemote = const Value.absent(),
    this.coverSource = const Value.absent(),
    this.description = const Value.absent(),
    this.descriptionSource = const Value.absent(),
    this.trackCount = const Value.absent(),
    this.year = const Value.absent(),
    this.releaseDate = const Value.absent(),
    this.spotifyId = const Value.absent(),
    this.metadataSource = const Value.absent(),
  });
  AlbumTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String artistName,
    this.artistId = const Value.absent(),
    this.coverUri = const Value.absent(),
    this.coverUriRemote = const Value.absent(),
    this.coverSource = const Value.absent(),
    this.description = const Value.absent(),
    this.descriptionSource = const Value.absent(),
    this.trackCount = const Value.absent(),
    this.year = const Value.absent(),
    this.releaseDate = const Value.absent(),
    this.spotifyId = const Value.absent(),
    this.metadataSource = const Value.absent(),
  })  : name = Value(name),
        artistName = Value(artistName);
  static Insertable<AlbumMetadata> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? artistName,
    Expression<String>? artistId,
    Expression<String>? coverUri,
    Expression<String>? coverUriRemote,
    Expression<String>? coverSource,
    Expression<String>? description,
    Expression<String>? descriptionSource,
    Expression<int>? trackCount,
    Expression<int>? year,
    Expression<DateTime>? releaseDate,
    Expression<String>? spotifyId,
    Expression<String>? metadataSource,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (artistName != null) 'artist_name': artistName,
      if (artistId != null) 'artist_id': artistId,
      if (coverUri != null) 'cover_uri': coverUri,
      if (coverUriRemote != null) 'cover_uri_remote': coverUriRemote,
      if (coverSource != null) 'cover_source': coverSource,
      if (description != null) 'description': description,
      if (descriptionSource != null) 'description_source': descriptionSource,
      if (trackCount != null) 'track_count': trackCount,
      if (year != null) 'year': year,
      if (releaseDate != null) 'release_date': releaseDate,
      if (spotifyId != null) 'spotify_id': spotifyId,
      if (metadataSource != null) 'metadata_source': metadataSource,
    });
  }

  AlbumTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? artistName,
      Value<String?>? artistId,
      Value<Uri?>? coverUri,
      Value<Uri?>? coverUriRemote,
      Value<String?>? coverSource,
      Value<String?>? description,
      Value<String?>? descriptionSource,
      Value<int?>? trackCount,
      Value<int?>? year,
      Value<DateTime?>? releaseDate,
      Value<String?>? spotifyId,
      Value<String?>? metadataSource}) {
    return AlbumTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      artistName: artistName ?? this.artistName,
      artistId: artistId ?? this.artistId,
      coverUri: coverUri ?? this.coverUri,
      coverUriRemote: coverUriRemote ?? this.coverUriRemote,
      coverSource: coverSource ?? this.coverSource,
      description: description ?? this.description,
      descriptionSource: descriptionSource ?? this.descriptionSource,
      trackCount: trackCount ?? this.trackCount,
      year: year ?? this.year,
      releaseDate: releaseDate ?? this.releaseDate,
      spotifyId: spotifyId ?? this.spotifyId,
      metadataSource: metadataSource ?? this.metadataSource,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (artistName.present) {
      map['artist_name'] = Variable<String>(artistName.value);
    }
    if (artistId.present) {
      map['artist_id'] = Variable<String>(artistId.value);
    }
    if (coverUri.present) {
      final converter = $AlbumTableTable.$converter0n;
      map['cover_uri'] = Variable<String>(converter.toSql(coverUri.value));
    }
    if (coverUriRemote.present) {
      final converter = $AlbumTableTable.$converter1n;
      map['cover_uri_remote'] =
          Variable<String>(converter.toSql(coverUriRemote.value));
    }
    if (coverSource.present) {
      map['cover_source'] = Variable<String>(coverSource.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (descriptionSource.present) {
      map['description_source'] = Variable<String>(descriptionSource.value);
    }
    if (trackCount.present) {
      map['track_count'] = Variable<int>(trackCount.value);
    }
    if (year.present) {
      map['year'] = Variable<int>(year.value);
    }
    if (releaseDate.present) {
      map['release_date'] = Variable<DateTime>(releaseDate.value);
    }
    if (spotifyId.present) {
      map['spotify_id'] = Variable<String>(spotifyId.value);
    }
    if (metadataSource.present) {
      map['metadata_source'] = Variable<String>(metadataSource.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AlbumTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('artistName: $artistName, ')
          ..write('artistId: $artistId, ')
          ..write('coverUri: $coverUri, ')
          ..write('coverUriRemote: $coverUriRemote, ')
          ..write('coverSource: $coverSource, ')
          ..write('description: $description, ')
          ..write('descriptionSource: $descriptionSource, ')
          ..write('trackCount: $trackCount, ')
          ..write('year: $year, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('spotifyId: $spotifyId, ')
          ..write('metadataSource: $metadataSource')
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
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 7, maxTextLength: 20),
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => nanoid(12));
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _artistNameMeta = const VerificationMeta('artistName');
  @override
  late final GeneratedColumn<String> artistName = GeneratedColumn<String>(
      'artist_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _artistIdMeta = const VerificationMeta('artistId');
  @override
  late final GeneratedColumn<String> artistId = GeneratedColumn<String>(
      'artist_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: 'REFERENCES "artist_table" ("id")');
  final VerificationMeta _coverUriMeta = const VerificationMeta('coverUri');
  @override
  late final GeneratedColumnWithTypeConverter<Uri?, String> coverUri =
      GeneratedColumn<String>('cover_uri', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<Uri?>($AlbumTableTable.$converter0n);
  final VerificationMeta _coverUriRemoteMeta =
      const VerificationMeta('coverUriRemote');
  @override
  late final GeneratedColumnWithTypeConverter<Uri?, String> coverUriRemote =
      GeneratedColumn<String>('cover_uri_remote', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<Uri?>($AlbumTableTable.$converter1n);
  final VerificationMeta _coverSourceMeta =
      const VerificationMeta('coverSource');
  @override
  late final GeneratedColumn<String> coverSource = GeneratedColumn<String>(
      'cover_source', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _descriptionSourceMeta =
      const VerificationMeta('descriptionSource');
  @override
  late final GeneratedColumn<String> descriptionSource =
      GeneratedColumn<String>('description_source', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _trackCountMeta = const VerificationMeta('trackCount');
  @override
  late final GeneratedColumn<int> trackCount = GeneratedColumn<int>(
      'track_count', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  final VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int> year = GeneratedColumn<int>(
      'year', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  final VerificationMeta _releaseDateMeta =
      const VerificationMeta('releaseDate');
  @override
  late final GeneratedColumn<DateTime> releaseDate = GeneratedColumn<DateTime>(
      'release_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  final VerificationMeta _spotifyIdMeta = const VerificationMeta('spotifyId');
  @override
  late final GeneratedColumn<String> spotifyId = GeneratedColumn<String>(
      'spotify_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _metadataSourceMeta =
      const VerificationMeta('metadataSource');
  @override
  late final GeneratedColumn<String> metadataSource = GeneratedColumn<String>(
      'metadata_source', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        artistName,
        artistId,
        coverUri,
        coverUriRemote,
        coverSource,
        description,
        descriptionSource,
        trackCount,
        year,
        releaseDate,
        spotifyId,
        metadataSource
      ];
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
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
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
    if (data.containsKey('artist_id')) {
      context.handle(_artistIdMeta,
          artistId.isAcceptableOrUnknown(data['artist_id']!, _artistIdMeta));
    }
    context.handle(_coverUriMeta, const VerificationResult.success());
    context.handle(_coverUriRemoteMeta, const VerificationResult.success());
    if (data.containsKey('cover_source')) {
      context.handle(
          _coverSourceMeta,
          coverSource.isAcceptableOrUnknown(
              data['cover_source']!, _coverSourceMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('description_source')) {
      context.handle(
          _descriptionSourceMeta,
          descriptionSource.isAcceptableOrUnknown(
              data['description_source']!, _descriptionSourceMeta));
    }
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
    if (data.containsKey('spotify_id')) {
      context.handle(_spotifyIdMeta,
          spotifyId.isAcceptableOrUnknown(data['spotify_id']!, _spotifyIdMeta));
    }
    if (data.containsKey('metadata_source')) {
      context.handle(
          _metadataSourceMeta,
          metadataSource.isAcceptableOrUnknown(
              data['metadata_source']!, _metadataSourceMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AlbumMetadata map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AlbumMetadata(
      id: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      artistName: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}artist_name'])!,
      artistId: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}artist_id']),
      name: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      coverUri: $AlbumTableTable.$converter0n.fromSql(attachedDatabase
          .options.types
          .read(DriftSqlType.string, data['${effectivePrefix}cover_uri'])),
      coverUriRemote: $AlbumTableTable.$converter1n.fromSql(
          attachedDatabase.options.types.read(
              DriftSqlType.string, data['${effectivePrefix}cover_uri_remote'])),
      coverSource: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}cover_source']),
      description: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      descriptionSource: attachedDatabase.options.types.read(
          DriftSqlType.string, data['${effectivePrefix}description_source']),
      trackCount: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}track_count']),
      year: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}year']),
      releaseDate: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}release_date']),
      spotifyId: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}spotify_id']),
      metadataSource: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}metadata_source']),
    );
  }

  @override
  $AlbumTableTable createAlias(String alias) {
    return $AlbumTableTable(attachedDatabase, alias);
  }

  static TypeConverter<Uri, String> $converter0 = UriConverter();
  static TypeConverter<Uri, String> $converter1 = UriConverter();
  static TypeConverter<Uri?, String?> $converter0n =
      NullAwareTypeConverter.wrap($converter0);
  static TypeConverter<Uri?, String?> $converter1n =
      NullAwareTypeConverter.wrap($converter1);
}

class TrackTableCompanion extends UpdateCompanion<TrackMetadata> {
  final Value<String> id;
  final Value<String?> title;
  final Value<String?> artistName;
  final Value<String?> trackArtistId;
  final Value<String?> albumArtistName;
  final Value<String?> albumArtistId;
  final Value<String?> albumName;
  final Value<String?> albumId;
  final Value<int> trackNo;
  final Value<int> discNo;
  final Value<String?> description;
  final Value<String?> descriptionSource;
  final Value<Uri> uri;
  final Value<Uri?> coverUri;
  final Value<Uri?> coverUriRemote;
  final Value<String?> coverSource;
  final Value<Duration?> duration;
  final Value<int?> year;
  final Value<DateTime?> releaseDate;
  final Value<bool> available;
  final Value<String?> spotifyId;
  final Value<String?> source;
  final Value<String?> metadataSource;
  const TrackTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.artistName = const Value.absent(),
    this.trackArtistId = const Value.absent(),
    this.albumArtistName = const Value.absent(),
    this.albumArtistId = const Value.absent(),
    this.albumName = const Value.absent(),
    this.albumId = const Value.absent(),
    this.trackNo = const Value.absent(),
    this.discNo = const Value.absent(),
    this.description = const Value.absent(),
    this.descriptionSource = const Value.absent(),
    this.uri = const Value.absent(),
    this.coverUri = const Value.absent(),
    this.coverUriRemote = const Value.absent(),
    this.coverSource = const Value.absent(),
    this.duration = const Value.absent(),
    this.year = const Value.absent(),
    this.releaseDate = const Value.absent(),
    this.available = const Value.absent(),
    this.spotifyId = const Value.absent(),
    this.source = const Value.absent(),
    this.metadataSource = const Value.absent(),
  });
  TrackTableCompanion.insert({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.artistName = const Value.absent(),
    this.trackArtistId = const Value.absent(),
    this.albumArtistName = const Value.absent(),
    this.albumArtistId = const Value.absent(),
    this.albumName = const Value.absent(),
    this.albumId = const Value.absent(),
    this.trackNo = const Value.absent(),
    this.discNo = const Value.absent(),
    this.description = const Value.absent(),
    this.descriptionSource = const Value.absent(),
    required Uri uri,
    this.coverUri = const Value.absent(),
    this.coverUriRemote = const Value.absent(),
    this.coverSource = const Value.absent(),
    this.duration = const Value.absent(),
    this.year = const Value.absent(),
    this.releaseDate = const Value.absent(),
    this.available = const Value.absent(),
    this.spotifyId = const Value.absent(),
    this.source = const Value.absent(),
    this.metadataSource = const Value.absent(),
  }) : uri = Value(uri);
  static Insertable<TrackMetadata> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? artistName,
    Expression<String>? trackArtistId,
    Expression<String>? albumArtistName,
    Expression<String>? albumArtistId,
    Expression<String>? albumName,
    Expression<String>? albumId,
    Expression<int>? trackNo,
    Expression<int>? discNo,
    Expression<String>? description,
    Expression<String>? descriptionSource,
    Expression<String>? uri,
    Expression<String>? coverUri,
    Expression<String>? coverUriRemote,
    Expression<String>? coverSource,
    Expression<int>? duration,
    Expression<int>? year,
    Expression<DateTime>? releaseDate,
    Expression<bool>? available,
    Expression<String>? spotifyId,
    Expression<String>? source,
    Expression<String>? metadataSource,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (artistName != null) 'artist_name': artistName,
      if (trackArtistId != null) 'track_artist_id': trackArtistId,
      if (albumArtistName != null) 'album_artist_name': albumArtistName,
      if (albumArtistId != null) 'album_artist_id': albumArtistId,
      if (albumName != null) 'album_name': albumName,
      if (albumId != null) 'album_id': albumId,
      if (trackNo != null) 'track_no': trackNo,
      if (discNo != null) 'disc_no': discNo,
      if (description != null) 'description': description,
      if (descriptionSource != null) 'description_source': descriptionSource,
      if (uri != null) 'uri': uri,
      if (coverUri != null) 'cover_uri': coverUri,
      if (coverUriRemote != null) 'cover_uri_remote': coverUriRemote,
      if (coverSource != null) 'cover_source': coverSource,
      if (duration != null) 'duration': duration,
      if (year != null) 'year': year,
      if (releaseDate != null) 'release_date': releaseDate,
      if (available != null) 'available': available,
      if (spotifyId != null) 'spotify_id': spotifyId,
      if (source != null) 'source': source,
      if (metadataSource != null) 'metadata_source': metadataSource,
    });
  }

  TrackTableCompanion copyWith(
      {Value<String>? id,
      Value<String?>? title,
      Value<String?>? artistName,
      Value<String?>? trackArtistId,
      Value<String?>? albumArtistName,
      Value<String?>? albumArtistId,
      Value<String?>? albumName,
      Value<String?>? albumId,
      Value<int>? trackNo,
      Value<int>? discNo,
      Value<String?>? description,
      Value<String?>? descriptionSource,
      Value<Uri>? uri,
      Value<Uri?>? coverUri,
      Value<Uri?>? coverUriRemote,
      Value<String?>? coverSource,
      Value<Duration?>? duration,
      Value<int?>? year,
      Value<DateTime?>? releaseDate,
      Value<bool>? available,
      Value<String?>? spotifyId,
      Value<String?>? source,
      Value<String?>? metadataSource}) {
    return TrackTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      artistName: artistName ?? this.artistName,
      trackArtistId: trackArtistId ?? this.trackArtistId,
      albumArtistName: albumArtistName ?? this.albumArtistName,
      albumArtistId: albumArtistId ?? this.albumArtistId,
      albumName: albumName ?? this.albumName,
      albumId: albumId ?? this.albumId,
      trackNo: trackNo ?? this.trackNo,
      discNo: discNo ?? this.discNo,
      description: description ?? this.description,
      descriptionSource: descriptionSource ?? this.descriptionSource,
      uri: uri ?? this.uri,
      coverUri: coverUri ?? this.coverUri,
      coverUriRemote: coverUriRemote ?? this.coverUriRemote,
      coverSource: coverSource ?? this.coverSource,
      duration: duration ?? this.duration,
      year: year ?? this.year,
      releaseDate: releaseDate ?? this.releaseDate,
      available: available ?? this.available,
      spotifyId: spotifyId ?? this.spotifyId,
      source: source ?? this.source,
      metadataSource: metadataSource ?? this.metadataSource,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (artistName.present) {
      map['artist_name'] = Variable<String>(artistName.value);
    }
    if (trackArtistId.present) {
      map['track_artist_id'] = Variable<String>(trackArtistId.value);
    }
    if (albumArtistName.present) {
      map['album_artist_name'] = Variable<String>(albumArtistName.value);
    }
    if (albumArtistId.present) {
      map['album_artist_id'] = Variable<String>(albumArtistId.value);
    }
    if (albumName.present) {
      map['album_name'] = Variable<String>(albumName.value);
    }
    if (albumId.present) {
      map['album_id'] = Variable<String>(albumId.value);
    }
    if (trackNo.present) {
      map['track_no'] = Variable<int>(trackNo.value);
    }
    if (discNo.present) {
      map['disc_no'] = Variable<int>(discNo.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (descriptionSource.present) {
      map['description_source'] = Variable<String>(descriptionSource.value);
    }
    if (uri.present) {
      final converter = $TrackTableTable.$converter0;
      map['uri'] = Variable<String>(converter.toSql(uri.value));
    }
    if (coverUri.present) {
      final converter = $TrackTableTable.$converter1n;
      map['cover_uri'] = Variable<String>(converter.toSql(coverUri.value));
    }
    if (coverUriRemote.present) {
      final converter = $TrackTableTable.$converter2n;
      map['cover_uri_remote'] =
          Variable<String>(converter.toSql(coverUriRemote.value));
    }
    if (coverSource.present) {
      map['cover_source'] = Variable<String>(coverSource.value);
    }
    if (duration.present) {
      final converter = $TrackTableTable.$converter3n;
      map['duration'] = Variable<int>(converter.toSql(duration.value));
    }
    if (year.present) {
      map['year'] = Variable<int>(year.value);
    }
    if (releaseDate.present) {
      map['release_date'] = Variable<DateTime>(releaseDate.value);
    }
    if (available.present) {
      map['available'] = Variable<bool>(available.value);
    }
    if (spotifyId.present) {
      map['spotify_id'] = Variable<String>(spotifyId.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (metadataSource.present) {
      map['metadata_source'] = Variable<String>(metadataSource.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrackTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('artistName: $artistName, ')
          ..write('trackArtistId: $trackArtistId, ')
          ..write('albumArtistName: $albumArtistName, ')
          ..write('albumArtistId: $albumArtistId, ')
          ..write('albumName: $albumName, ')
          ..write('albumId: $albumId, ')
          ..write('trackNo: $trackNo, ')
          ..write('discNo: $discNo, ')
          ..write('description: $description, ')
          ..write('descriptionSource: $descriptionSource, ')
          ..write('uri: $uri, ')
          ..write('coverUri: $coverUri, ')
          ..write('coverUriRemote: $coverUriRemote, ')
          ..write('coverSource: $coverSource, ')
          ..write('duration: $duration, ')
          ..write('year: $year, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('available: $available, ')
          ..write('spotifyId: $spotifyId, ')
          ..write('source: $source, ')
          ..write('metadataSource: $metadataSource')
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
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 7, maxTextLength: 20),
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => nanoid(13));
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _artistNameMeta = const VerificationMeta('artistName');
  @override
  late final GeneratedColumn<String> artistName = GeneratedColumn<String>(
      'artist_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _trackArtistIdMeta =
      const VerificationMeta('trackArtistId');
  @override
  late final GeneratedColumn<String> trackArtistId = GeneratedColumn<String>(
      'track_artist_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: 'REFERENCES "artist_table" ("id")');
  final VerificationMeta _albumArtistNameMeta =
      const VerificationMeta('albumArtistName');
  @override
  late final GeneratedColumn<String> albumArtistName = GeneratedColumn<String>(
      'album_artist_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _albumArtistIdMeta =
      const VerificationMeta('albumArtistId');
  @override
  late final GeneratedColumn<String> albumArtistId = GeneratedColumn<String>(
      'album_artist_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: 'REFERENCES "artist_table" ("id")');
  final VerificationMeta _albumNameMeta = const VerificationMeta('albumName');
  @override
  late final GeneratedColumn<String> albumName = GeneratedColumn<String>(
      'album_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _albumIdMeta = const VerificationMeta('albumId');
  @override
  late final GeneratedColumn<String> albumId = GeneratedColumn<String>(
      'album_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: 'REFERENCES "album_table" ("id")');
  final VerificationMeta _trackNoMeta = const VerificationMeta('trackNo');
  @override
  late final GeneratedColumn<int> trackNo = GeneratedColumn<int>(
      'track_no', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  final VerificationMeta _discNoMeta = const VerificationMeta('discNo');
  @override
  late final GeneratedColumn<int> discNo = GeneratedColumn<int>(
      'disc_no', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _descriptionSourceMeta =
      const VerificationMeta('descriptionSource');
  @override
  late final GeneratedColumn<String> descriptionSource =
      GeneratedColumn<String>('description_source', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _uriMeta = const VerificationMeta('uri');
  @override
  late final GeneratedColumnWithTypeConverter<Uri, String> uri =
      GeneratedColumn<String>('uri', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<Uri>($TrackTableTable.$converter0);
  final VerificationMeta _coverUriMeta = const VerificationMeta('coverUri');
  @override
  late final GeneratedColumnWithTypeConverter<Uri?, String> coverUri =
      GeneratedColumn<String>('cover_uri', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<Uri?>($TrackTableTable.$converter1n);
  final VerificationMeta _coverUriRemoteMeta =
      const VerificationMeta('coverUriRemote');
  @override
  late final GeneratedColumnWithTypeConverter<Uri?, String> coverUriRemote =
      GeneratedColumn<String>('cover_uri_remote', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<Uri?>($TrackTableTable.$converter2n);
  final VerificationMeta _coverSourceMeta =
      const VerificationMeta('coverSource');
  @override
  late final GeneratedColumn<String> coverSource = GeneratedColumn<String>(
      'cover_source', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _durationMeta = const VerificationMeta('duration');
  @override
  late final GeneratedColumnWithTypeConverter<Duration?, int> duration =
      GeneratedColumn<int>('duration', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<Duration?>($TrackTableTable.$converter3n);
  final VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int> year = GeneratedColumn<int>(
      'year', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  final VerificationMeta _releaseDateMeta =
      const VerificationMeta('releaseDate');
  @override
  late final GeneratedColumn<DateTime> releaseDate = GeneratedColumn<DateTime>(
      'release_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  final VerificationMeta _availableMeta = const VerificationMeta('available');
  @override
  late final GeneratedColumn<bool> available = GeneratedColumn<bool>(
      'available', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK ("available" IN (0, 1))',
      defaultValue: const Constant(true));
  final VerificationMeta _spotifyIdMeta = const VerificationMeta('spotifyId');
  @override
  late final GeneratedColumn<String> spotifyId = GeneratedColumn<String>(
      'spotify_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
      'source', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _metadataSourceMeta =
      const VerificationMeta('metadataSource');
  @override
  late final GeneratedColumn<String> metadataSource = GeneratedColumn<String>(
      'metadata_source', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        artistName,
        trackArtistId,
        albumArtistName,
        albumArtistId,
        albumName,
        albumId,
        trackNo,
        discNo,
        description,
        descriptionSource,
        uri,
        coverUri,
        coverUriRemote,
        coverSource,
        duration,
        year,
        releaseDate,
        available,
        spotifyId,
        source,
        metadataSource
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
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
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
    if (data.containsKey('track_artist_id')) {
      context.handle(
          _trackArtistIdMeta,
          trackArtistId.isAcceptableOrUnknown(
              data['track_artist_id']!, _trackArtistIdMeta));
    }
    if (data.containsKey('album_artist_name')) {
      context.handle(
          _albumArtistNameMeta,
          albumArtistName.isAcceptableOrUnknown(
              data['album_artist_name']!, _albumArtistNameMeta));
    }
    if (data.containsKey('album_artist_id')) {
      context.handle(
          _albumArtistIdMeta,
          albumArtistId.isAcceptableOrUnknown(
              data['album_artist_id']!, _albumArtistIdMeta));
    }
    if (data.containsKey('album_name')) {
      context.handle(_albumNameMeta,
          albumName.isAcceptableOrUnknown(data['album_name']!, _albumNameMeta));
    }
    if (data.containsKey('album_id')) {
      context.handle(_albumIdMeta,
          albumId.isAcceptableOrUnknown(data['album_id']!, _albumIdMeta));
    }
    if (data.containsKey('track_no')) {
      context.handle(_trackNoMeta,
          trackNo.isAcceptableOrUnknown(data['track_no']!, _trackNoMeta));
    }
    if (data.containsKey('disc_no')) {
      context.handle(_discNoMeta,
          discNo.isAcceptableOrUnknown(data['disc_no']!, _discNoMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('description_source')) {
      context.handle(
          _descriptionSourceMeta,
          descriptionSource.isAcceptableOrUnknown(
              data['description_source']!, _descriptionSourceMeta));
    }
    context.handle(_uriMeta, const VerificationResult.success());
    context.handle(_coverUriMeta, const VerificationResult.success());
    context.handle(_coverUriRemoteMeta, const VerificationResult.success());
    if (data.containsKey('cover_source')) {
      context.handle(
          _coverSourceMeta,
          coverSource.isAcceptableOrUnknown(
              data['cover_source']!, _coverSourceMeta));
    }
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
    if (data.containsKey('spotify_id')) {
      context.handle(_spotifyIdMeta,
          spotifyId.isAcceptableOrUnknown(data['spotify_id']!, _spotifyIdMeta));
    }
    if (data.containsKey('source')) {
      context.handle(_sourceMeta,
          source.isAcceptableOrUnknown(data['source']!, _sourceMeta));
    }
    if (data.containsKey('metadata_source')) {
      context.handle(
          _metadataSourceMeta,
          metadataSource.isAcceptableOrUnknown(
              data['metadata_source']!, _metadataSourceMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TrackMetadata map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TrackMetadata(
      id: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}title']),
      artistName: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}artist_name']),
      albumArtistName: attachedDatabase.options.types.read(
          DriftSqlType.string, data['${effectivePrefix}album_artist_name']),
      albumArtistId: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}album_artist_id']),
      trackArtistId: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}track_artist_id']),
      albumName: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}album_name']),
      albumId: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}album_id']),
      trackNo: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}track_no'])!,
      discNo: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}disc_no'])!,
      description: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      descriptionSource: attachedDatabase.options.types.read(
          DriftSqlType.string, data['${effectivePrefix}description_source']),
      uri: $TrackTableTable.$converter0.fromSql(attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}uri'])!),
      coverUri: $TrackTableTable.$converter1n.fromSql(attachedDatabase
          .options.types
          .read(DriftSqlType.string, data['${effectivePrefix}cover_uri'])),
      coverUriRemote: $TrackTableTable.$converter2n.fromSql(
          attachedDatabase.options.types.read(
              DriftSqlType.string, data['${effectivePrefix}cover_uri_remote'])),
      coverSource: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}cover_source']),
      duration: $TrackTableTable.$converter3n.fromSql(attachedDatabase
          .options.types
          .read(DriftSqlType.int, data['${effectivePrefix}duration'])),
      year: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}year']),
      releaseDate: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}release_date']),
      available: attachedDatabase.options.types
          .read(DriftSqlType.bool, data['${effectivePrefix}available'])!,
      spotifyId: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}spotify_id']),
      source: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}source']),
      metadataSource: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}metadata_source']),
    );
  }

  @override
  $TrackTableTable createAlias(String alias) {
    return $TrackTableTable(attachedDatabase, alias);
  }

  static TypeConverter<Uri, String> $converter0 = UriConverter();
  static TypeConverter<Uri, String> $converter1 = UriConverter();
  static TypeConverter<Uri, String> $converter2 = UriConverter();
  static TypeConverter<Duration, int> $converter3 = DurationConverter();
  static TypeConverter<Uri?, String?> $converter1n =
      NullAwareTypeConverter.wrap($converter1);
  static TypeConverter<Uri?, String?> $converter2n =
      NullAwareTypeConverter.wrap($converter2);
  static TypeConverter<Duration?, int?> $converter3n =
      NullAwareTypeConverter.wrap($converter3);
}

class PlaylistTableCompanion extends UpdateCompanion<PlaylistMetadata> {
  final Value<String> id;
  final Value<String> name;
  final Value<Uri?> coverUri;
  final Value<String?> coverSource;
  final Value<String?> description;
  final Value<int?> trackCount;
  final Value<DateTime> createdAt;
  final Value<int?> index;
  const PlaylistTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.coverUri = const Value.absent(),
    this.coverSource = const Value.absent(),
    this.description = const Value.absent(),
    this.trackCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.index = const Value.absent(),
  });
  PlaylistTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.coverUri = const Value.absent(),
    this.coverSource = const Value.absent(),
    this.description = const Value.absent(),
    this.trackCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.index = const Value.absent(),
  }) : name = Value(name);
  static Insertable<PlaylistMetadata> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? coverUri,
    Expression<String>? coverSource,
    Expression<String>? description,
    Expression<int>? trackCount,
    Expression<DateTime>? createdAt,
    Expression<int>? index,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (coverUri != null) 'cover_uri': coverUri,
      if (coverSource != null) 'cover_source': coverSource,
      if (description != null) 'description': description,
      if (trackCount != null) 'track_count': trackCount,
      if (createdAt != null) 'created_at': createdAt,
      if (index != null) 'index': index,
    });
  }

  PlaylistTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<Uri?>? coverUri,
      Value<String?>? coverSource,
      Value<String?>? description,
      Value<int?>? trackCount,
      Value<DateTime>? createdAt,
      Value<int?>? index}) {
    return PlaylistTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      coverUri: coverUri ?? this.coverUri,
      coverSource: coverSource ?? this.coverSource,
      description: description ?? this.description,
      trackCount: trackCount ?? this.trackCount,
      createdAt: createdAt ?? this.createdAt,
      index: index ?? this.index,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (coverUri.present) {
      final converter = $PlaylistTableTable.$converter0n;
      map['cover_uri'] = Variable<String>(converter.toSql(coverUri.value));
    }
    if (coverSource.present) {
      map['cover_source'] = Variable<String>(coverSource.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (trackCount.present) {
      map['track_count'] = Variable<int>(trackCount.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (index.present) {
      map['index'] = Variable<int>(index.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlaylistTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('coverUri: $coverUri, ')
          ..write('coverSource: $coverSource, ')
          ..write('description: $description, ')
          ..write('trackCount: $trackCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('index: $index')
          ..write(')'))
        .toString();
  }
}

class $PlaylistTableTable extends PlaylistTable
    with TableInfo<$PlaylistTableTable, PlaylistMetadata> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlaylistTableTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 7, maxTextLength: 20),
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => nanoid(8));
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _coverUriMeta = const VerificationMeta('coverUri');
  @override
  late final GeneratedColumnWithTypeConverter<Uri?, String> coverUri =
      GeneratedColumn<String>('cover_uri', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<Uri?>($PlaylistTableTable.$converter0n);
  final VerificationMeta _coverSourceMeta =
      const VerificationMeta('coverSource');
  @override
  late final GeneratedColumn<String> coverSource = GeneratedColumn<String>(
      'cover_source', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _trackCountMeta = const VerificationMeta('trackCount');
  @override
  late final GeneratedColumn<int> trackCount = GeneratedColumn<int>(
      'track_count', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  final VerificationMeta _indexMeta = const VerificationMeta('index');
  @override
  late final GeneratedColumn<int> index = GeneratedColumn<int>(
      'index', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        coverUri,
        coverSource,
        description,
        trackCount,
        createdAt,
        index
      ];
  @override
  String get aliasedName => _alias ?? 'playlist_table';
  @override
  String get actualTableName => 'playlist_table';
  @override
  VerificationContext validateIntegrity(Insertable<PlaylistMetadata> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    context.handle(_coverUriMeta, const VerificationResult.success());
    if (data.containsKey('cover_source')) {
      context.handle(
          _coverSourceMeta,
          coverSource.isAcceptableOrUnknown(
              data['cover_source']!, _coverSourceMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('track_count')) {
      context.handle(
          _trackCountMeta,
          trackCount.isAcceptableOrUnknown(
              data['track_count']!, _trackCountMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('index')) {
      context.handle(
          _indexMeta, index.isAcceptableOrUnknown(data['index']!, _indexMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlaylistMetadata map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlaylistMetadata(
      id: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      coverUri: $PlaylistTableTable.$converter0n.fromSql(attachedDatabase
          .options.types
          .read(DriftSqlType.string, data['${effectivePrefix}cover_uri'])),
      coverSource: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}cover_source']),
      description: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      trackCount: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}track_count']),
      createdAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      index: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}index']),
    );
  }

  @override
  $PlaylistTableTable createAlias(String alias) {
    return $PlaylistTableTable(attachedDatabase, alias);
  }

  static TypeConverter<Uri, String> $converter0 = UriConverter();
  static TypeConverter<Uri?, String?> $converter0n =
      NullAwareTypeConverter.wrap($converter0);
}

class PlaylistEntry extends DataClass implements Insertable<PlaylistEntry> {
  final String id;
  final String playlist;
  final String track;
  final DateTime added;
  final int? index;
  const PlaylistEntry(
      {required this.id,
      required this.playlist,
      required this.track,
      required this.added,
      this.index});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['playlist'] = Variable<String>(playlist);
    map['track'] = Variable<String>(track);
    map['added'] = Variable<DateTime>(added);
    if (!nullToAbsent || index != null) {
      map['index'] = Variable<int>(index);
    }
    return map;
  }

  PlaylistEntriesCompanion toCompanion(bool nullToAbsent) {
    return PlaylistEntriesCompanion(
      id: Value(id),
      playlist: Value(playlist),
      track: Value(track),
      added: Value(added),
      index:
          index == null && nullToAbsent ? const Value.absent() : Value(index),
    );
  }

  factory PlaylistEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlaylistEntry(
      id: serializer.fromJson<String>(json['id']),
      playlist: serializer.fromJson<String>(json['playlist']),
      track: serializer.fromJson<String>(json['track']),
      added: serializer.fromJson<DateTime>(json['added']),
      index: serializer.fromJson<int?>(json['index']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'playlist': serializer.toJson<String>(playlist),
      'track': serializer.toJson<String>(track),
      'added': serializer.toJson<DateTime>(added),
      'index': serializer.toJson<int?>(index),
    };
  }

  PlaylistEntry copyWith(
          {String? id,
          String? playlist,
          String? track,
          DateTime? added,
          Value<int?> index = const Value.absent()}) =>
      PlaylistEntry(
        id: id ?? this.id,
        playlist: playlist ?? this.playlist,
        track: track ?? this.track,
        added: added ?? this.added,
        index: index.present ? index.value : this.index,
      );
  @override
  String toString() {
    return (StringBuffer('PlaylistEntry(')
          ..write('id: $id, ')
          ..write('playlist: $playlist, ')
          ..write('track: $track, ')
          ..write('added: $added, ')
          ..write('index: $index')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, playlist, track, added, index);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlaylistEntry &&
          other.id == this.id &&
          other.playlist == this.playlist &&
          other.track == this.track &&
          other.added == this.added &&
          other.index == this.index);
}

class PlaylistEntriesCompanion extends UpdateCompanion<PlaylistEntry> {
  final Value<String> id;
  final Value<String> playlist;
  final Value<String> track;
  final Value<DateTime> added;
  final Value<int?> index;
  const PlaylistEntriesCompanion({
    this.id = const Value.absent(),
    this.playlist = const Value.absent(),
    this.track = const Value.absent(),
    this.added = const Value.absent(),
    this.index = const Value.absent(),
  });
  PlaylistEntriesCompanion.insert({
    this.id = const Value.absent(),
    required String playlist,
    required String track,
    this.added = const Value.absent(),
    this.index = const Value.absent(),
  })  : playlist = Value(playlist),
        track = Value(track);
  static Insertable<PlaylistEntry> custom({
    Expression<String>? id,
    Expression<String>? playlist,
    Expression<String>? track,
    Expression<DateTime>? added,
    Expression<int>? index,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (playlist != null) 'playlist': playlist,
      if (track != null) 'track': track,
      if (added != null) 'added': added,
      if (index != null) 'index': index,
    });
  }

  PlaylistEntriesCompanion copyWith(
      {Value<String>? id,
      Value<String>? playlist,
      Value<String>? track,
      Value<DateTime>? added,
      Value<int?>? index}) {
    return PlaylistEntriesCompanion(
      id: id ?? this.id,
      playlist: playlist ?? this.playlist,
      track: track ?? this.track,
      added: added ?? this.added,
      index: index ?? this.index,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (playlist.present) {
      map['playlist'] = Variable<String>(playlist.value);
    }
    if (track.present) {
      map['track'] = Variable<String>(track.value);
    }
    if (added.present) {
      map['added'] = Variable<DateTime>(added.value);
    }
    if (index.present) {
      map['index'] = Variable<int>(index.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlaylistEntriesCompanion(')
          ..write('id: $id, ')
          ..write('playlist: $playlist, ')
          ..write('track: $track, ')
          ..write('added: $added, ')
          ..write('index: $index')
          ..write(')'))
        .toString();
  }
}

class $PlaylistEntriesTable extends PlaylistEntries
    with TableInfo<$PlaylistEntriesTable, PlaylistEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlaylistEntriesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 7, maxTextLength: 20),
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => nanoid(14));
  final VerificationMeta _playlistMeta = const VerificationMeta('playlist');
  @override
  late final GeneratedColumn<String> playlist = GeneratedColumn<String>(
      'playlist', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES "playlist_table" ("id")');
  final VerificationMeta _trackMeta = const VerificationMeta('track');
  @override
  late final GeneratedColumn<String> track = GeneratedColumn<String>(
      'track', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES "track_table" ("id")');
  final VerificationMeta _addedMeta = const VerificationMeta('added');
  @override
  late final GeneratedColumn<DateTime> added = GeneratedColumn<DateTime>(
      'added', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  final VerificationMeta _indexMeta = const VerificationMeta('index');
  @override
  late final GeneratedColumn<int> index = GeneratedColumn<int>(
      'index', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [id, playlist, track, added, index];
  @override
  String get aliasedName => _alias ?? 'playlist_entries';
  @override
  String get actualTableName => 'playlist_entries';
  @override
  VerificationContext validateIntegrity(Insertable<PlaylistEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('playlist')) {
      context.handle(_playlistMeta,
          playlist.isAcceptableOrUnknown(data['playlist']!, _playlistMeta));
    } else if (isInserting) {
      context.missing(_playlistMeta);
    }
    if (data.containsKey('track')) {
      context.handle(
          _trackMeta, track.isAcceptableOrUnknown(data['track']!, _trackMeta));
    } else if (isInserting) {
      context.missing(_trackMeta);
    }
    if (data.containsKey('added')) {
      context.handle(
          _addedMeta, added.isAcceptableOrUnknown(data['added']!, _addedMeta));
    }
    if (data.containsKey('index')) {
      context.handle(
          _indexMeta, index.isAcceptableOrUnknown(data['index']!, _indexMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlaylistEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlaylistEntry(
      id: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      playlist: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}playlist'])!,
      track: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}track'])!,
      added: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}added'])!,
      index: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}index']),
    );
  }

  @override
  $PlaylistEntriesTable createAlias(String alias) {
    return $PlaylistEntriesTable(attachedDatabase, alias);
  }
}

abstract class _$BoDatabase extends GeneratedDatabase {
  _$BoDatabase(QueryExecutor e) : super(e);
  _$BoDatabase.connect(DatabaseConnection c) : super.connect(c);
  late final $ArtistTableTable artistTable = $ArtistTableTable(this);
  late final $AlbumTableTable albumTable = $AlbumTableTable(this);
  late final $TrackTableTable trackTable = $TrackTableTable(this);
  late final $PlaylistTableTable playlistTable = $PlaylistTableTable(this);
  late final $PlaylistEntriesTable playlistEntries =
      $PlaylistEntriesTable(this);
  @override
  Iterable<TableInfo<Table, dynamic>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [artistTable, albumTable, trackTable, playlistTable, playlistEntries];
}
