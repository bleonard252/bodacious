// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
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
    Expression<Uri?>? coverUri,
    Expression<Uri?>? coverUriRemote,
    Expression<String?>? coverSource,
    Expression<String?>? description,
    Expression<String?>? descriptionSource,
    Expression<int?>? trackCount,
    Expression<int?>? albumCount,
    Expression<String?>? spotifyId,
    Expression<String?>? metadataSource,
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
      final converter = $ArtistTableTable.$converter0;
      map['cover_uri'] = Variable<String?>(converter.mapToSql(coverUri.value));
    }
    if (coverUriRemote.present) {
      final converter = $ArtistTableTable.$converter1;
      map['cover_uri_remote'] =
          Variable<String?>(converter.mapToSql(coverUriRemote.value));
    }
    if (coverSource.present) {
      map['cover_source'] = Variable<String?>(coverSource.value);
    }
    if (description.present) {
      map['description'] = Variable<String?>(description.value);
    }
    if (descriptionSource.present) {
      map['description_source'] = Variable<String?>(descriptionSource.value);
    }
    if (trackCount.present) {
      map['track_count'] = Variable<int?>(trackCount.value);
    }
    if (albumCount.present) {
      map['album_count'] = Variable<int?>(albumCount.value);
    }
    if (spotifyId.present) {
      map['spotify_id'] = Variable<String?>(spotifyId.value);
    }
    if (metadataSource.present) {
      map['metadata_source'] = Variable<String?>(metadataSource.value);
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
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 7, maxTextLength: 20),
      type: const StringType(),
      requiredDuringInsert: false,
      clientDefault: () => nanoid(10));
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
  final VerificationMeta _coverUriRemoteMeta =
      const VerificationMeta('coverUriRemote');
  @override
  late final GeneratedColumnWithTypeConverter<Uri, String?> coverUriRemote =
      GeneratedColumn<String?>('cover_uri_remote', aliasedName, true,
              type: const StringType(), requiredDuringInsert: false)
          .withConverter<Uri>($ArtistTableTable.$converter1);
  final VerificationMeta _coverSourceMeta =
      const VerificationMeta('coverSource');
  @override
  late final GeneratedColumn<String?> coverSource = GeneratedColumn<String?>(
      'cover_source', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String?> description = GeneratedColumn<String?>(
      'description', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _descriptionSourceMeta =
      const VerificationMeta('descriptionSource');
  @override
  late final GeneratedColumn<String?> descriptionSource =
      GeneratedColumn<String?>('description_source', aliasedName, true,
          type: const StringType(), requiredDuringInsert: false);
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
  final VerificationMeta _spotifyIdMeta = const VerificationMeta('spotifyId');
  @override
  late final GeneratedColumn<String?> spotifyId = GeneratedColumn<String?>(
      'spotify_id', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _metadataSourceMeta =
      const VerificationMeta('metadataSource');
  @override
  late final GeneratedColumn<String?> metadataSource = GeneratedColumn<String?>(
      'metadata_source', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
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
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      coverUri: $ArtistTableTable.$converter0.mapToDart(const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}cover_uri'])),
      coverUriRemote: $ArtistTableTable.$converter1.mapToDart(const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}cover_uri_remote'])),
      coverSource: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}cover_source']),
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      descriptionSource: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}description_source']),
      albumCount: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}album_count']),
      trackCount: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}track_count']),
      spotifyId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}spotify_id']),
      metadataSource: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}metadata_source']),
    );
  }

  @override
  $ArtistTableTable createAlias(String alias) {
    return $ArtistTableTable(attachedDatabase, alias);
  }

  static TypeConverter<Uri, String> $converter0 = UriConverter();
  static TypeConverter<Uri, String> $converter1 = UriConverter();
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
    Expression<String?>? artistId,
    Expression<Uri?>? coverUri,
    Expression<Uri?>? coverUriRemote,
    Expression<String?>? coverSource,
    Expression<String?>? description,
    Expression<String?>? descriptionSource,
    Expression<int?>? trackCount,
    Expression<int?>? year,
    Expression<DateTime?>? releaseDate,
    Expression<String?>? spotifyId,
    Expression<String?>? metadataSource,
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
      map['artist_id'] = Variable<String?>(artistId.value);
    }
    if (coverUri.present) {
      final converter = $AlbumTableTable.$converter0;
      map['cover_uri'] = Variable<String?>(converter.mapToSql(coverUri.value));
    }
    if (coverUriRemote.present) {
      final converter = $AlbumTableTable.$converter1;
      map['cover_uri_remote'] =
          Variable<String?>(converter.mapToSql(coverUriRemote.value));
    }
    if (coverSource.present) {
      map['cover_source'] = Variable<String?>(coverSource.value);
    }
    if (description.present) {
      map['description'] = Variable<String?>(description.value);
    }
    if (descriptionSource.present) {
      map['description_source'] = Variable<String?>(descriptionSource.value);
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
    if (spotifyId.present) {
      map['spotify_id'] = Variable<String?>(spotifyId.value);
    }
    if (metadataSource.present) {
      map['metadata_source'] = Variable<String?>(metadataSource.value);
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
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 7, maxTextLength: 20),
      type: const StringType(),
      requiredDuringInsert: false,
      clientDefault: () => nanoid(12));
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
  final VerificationMeta _artistIdMeta = const VerificationMeta('artistId');
  @override
  late final GeneratedColumn<String?> artistId = GeneratedColumn<String?>(
      'artist_id', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultConstraints: 'REFERENCES artist_table (id)');
  final VerificationMeta _coverUriMeta = const VerificationMeta('coverUri');
  @override
  late final GeneratedColumnWithTypeConverter<Uri, String?> coverUri =
      GeneratedColumn<String?>('cover_uri', aliasedName, true,
              type: const StringType(), requiredDuringInsert: false)
          .withConverter<Uri>($AlbumTableTable.$converter0);
  final VerificationMeta _coverUriRemoteMeta =
      const VerificationMeta('coverUriRemote');
  @override
  late final GeneratedColumnWithTypeConverter<Uri, String?> coverUriRemote =
      GeneratedColumn<String?>('cover_uri_remote', aliasedName, true,
              type: const StringType(), requiredDuringInsert: false)
          .withConverter<Uri>($AlbumTableTable.$converter1);
  final VerificationMeta _coverSourceMeta =
      const VerificationMeta('coverSource');
  @override
  late final GeneratedColumn<String?> coverSource = GeneratedColumn<String?>(
      'cover_source', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String?> description = GeneratedColumn<String?>(
      'description', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _descriptionSourceMeta =
      const VerificationMeta('descriptionSource');
  @override
  late final GeneratedColumn<String?> descriptionSource =
      GeneratedColumn<String?>('description_source', aliasedName, true,
          type: const StringType(), requiredDuringInsert: false);
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
  final VerificationMeta _spotifyIdMeta = const VerificationMeta('spotifyId');
  @override
  late final GeneratedColumn<String?> spotifyId = GeneratedColumn<String?>(
      'spotify_id', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _metadataSourceMeta =
      const VerificationMeta('metadataSource');
  @override
  late final GeneratedColumn<String?> metadataSource = GeneratedColumn<String?>(
      'metadata_source', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
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
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      artistName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}artist_name'])!,
      artistId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}artist_id']),
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      coverUri: $AlbumTableTable.$converter0.mapToDart(const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}cover_uri'])),
      coverUriRemote: $AlbumTableTable.$converter1.mapToDart(const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}cover_uri_remote'])),
      coverSource: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}cover_source']),
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      descriptionSource: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}description_source']),
      trackCount: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}track_count']),
      year: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}year']),
      releaseDate: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}release_date']),
      spotifyId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}spotify_id']),
      metadataSource: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}metadata_source']),
    );
  }

  @override
  $AlbumTableTable createAlias(String alias) {
    return $AlbumTableTable(attachedDatabase, alias);
  }

  static TypeConverter<Uri, String> $converter0 = UriConverter();
  static TypeConverter<Uri, String> $converter1 = UriConverter();
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
    Expression<String?>? title,
    Expression<String?>? artistName,
    Expression<String?>? trackArtistId,
    Expression<String?>? albumArtistName,
    Expression<String?>? albumArtistId,
    Expression<String?>? albumName,
    Expression<String?>? albumId,
    Expression<int>? trackNo,
    Expression<int>? discNo,
    Expression<String?>? description,
    Expression<String?>? descriptionSource,
    Expression<Uri>? uri,
    Expression<Uri?>? coverUri,
    Expression<Uri?>? coverUriRemote,
    Expression<String?>? coverSource,
    Expression<Duration?>? duration,
    Expression<int?>? year,
    Expression<DateTime?>? releaseDate,
    Expression<bool>? available,
    Expression<String?>? spotifyId,
    Expression<String?>? source,
    Expression<String?>? metadataSource,
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
      map['title'] = Variable<String?>(title.value);
    }
    if (artistName.present) {
      map['artist_name'] = Variable<String?>(artistName.value);
    }
    if (trackArtistId.present) {
      map['track_artist_id'] = Variable<String?>(trackArtistId.value);
    }
    if (albumArtistName.present) {
      map['album_artist_name'] = Variable<String?>(albumArtistName.value);
    }
    if (albumArtistId.present) {
      map['album_artist_id'] = Variable<String?>(albumArtistId.value);
    }
    if (albumName.present) {
      map['album_name'] = Variable<String?>(albumName.value);
    }
    if (albumId.present) {
      map['album_id'] = Variable<String?>(albumId.value);
    }
    if (trackNo.present) {
      map['track_no'] = Variable<int>(trackNo.value);
    }
    if (discNo.present) {
      map['disc_no'] = Variable<int>(discNo.value);
    }
    if (description.present) {
      map['description'] = Variable<String?>(description.value);
    }
    if (descriptionSource.present) {
      map['description_source'] = Variable<String?>(descriptionSource.value);
    }
    if (uri.present) {
      final converter = $TrackTableTable.$converter0;
      map['uri'] = Variable<String>(converter.mapToSql(uri.value)!);
    }
    if (coverUri.present) {
      final converter = $TrackTableTable.$converter1;
      map['cover_uri'] = Variable<String?>(converter.mapToSql(coverUri.value));
    }
    if (coverUriRemote.present) {
      final converter = $TrackTableTable.$converter2;
      map['cover_uri_remote'] =
          Variable<String?>(converter.mapToSql(coverUriRemote.value));
    }
    if (coverSource.present) {
      map['cover_source'] = Variable<String?>(coverSource.value);
    }
    if (duration.present) {
      final converter = $TrackTableTable.$converter3;
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
    if (spotifyId.present) {
      map['spotify_id'] = Variable<String?>(spotifyId.value);
    }
    if (source.present) {
      map['source'] = Variable<String?>(source.value);
    }
    if (metadataSource.present) {
      map['metadata_source'] = Variable<String?>(metadataSource.value);
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
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 7, maxTextLength: 20),
      type: const StringType(),
      requiredDuringInsert: false,
      clientDefault: () => nanoid(13));
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
  final VerificationMeta _trackArtistIdMeta =
      const VerificationMeta('trackArtistId');
  @override
  late final GeneratedColumn<String?> trackArtistId = GeneratedColumn<String?>(
      'track_artist_id', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultConstraints: 'REFERENCES artist_table (id)');
  final VerificationMeta _albumArtistNameMeta =
      const VerificationMeta('albumArtistName');
  @override
  late final GeneratedColumn<String?> albumArtistName =
      GeneratedColumn<String?>('album_artist_name', aliasedName, true,
          type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _albumArtistIdMeta =
      const VerificationMeta('albumArtistId');
  @override
  late final GeneratedColumn<String?> albumArtistId = GeneratedColumn<String?>(
      'album_artist_id', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultConstraints: 'REFERENCES artist_table (id)');
  final VerificationMeta _albumNameMeta = const VerificationMeta('albumName');
  @override
  late final GeneratedColumn<String?> albumName = GeneratedColumn<String?>(
      'album_name', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _albumIdMeta = const VerificationMeta('albumId');
  @override
  late final GeneratedColumn<String?> albumId = GeneratedColumn<String?>(
      'album_id', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultConstraints: 'REFERENCES album_table (id)');
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
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String?> description = GeneratedColumn<String?>(
      'description', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _descriptionSourceMeta =
      const VerificationMeta('descriptionSource');
  @override
  late final GeneratedColumn<String?> descriptionSource =
      GeneratedColumn<String?>('description_source', aliasedName, true,
          type: const StringType(), requiredDuringInsert: false);
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
  final VerificationMeta _coverUriRemoteMeta =
      const VerificationMeta('coverUriRemote');
  @override
  late final GeneratedColumnWithTypeConverter<Uri, String?> coverUriRemote =
      GeneratedColumn<String?>('cover_uri_remote', aliasedName, true,
              type: const StringType(), requiredDuringInsert: false)
          .withConverter<Uri>($TrackTableTable.$converter2);
  final VerificationMeta _coverSourceMeta =
      const VerificationMeta('coverSource');
  @override
  late final GeneratedColumn<String?> coverSource = GeneratedColumn<String?>(
      'cover_source', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _durationMeta = const VerificationMeta('duration');
  @override
  late final GeneratedColumnWithTypeConverter<Duration, int?> duration =
      GeneratedColumn<int?>('duration', aliasedName, true,
              type: const IntType(), requiredDuringInsert: false)
          .withConverter<Duration>($TrackTableTable.$converter3);
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
  final VerificationMeta _spotifyIdMeta = const VerificationMeta('spotifyId');
  @override
  late final GeneratedColumn<String?> spotifyId = GeneratedColumn<String?>(
      'spotify_id', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String?> source = GeneratedColumn<String?>(
      'source', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _metadataSourceMeta =
      const VerificationMeta('metadataSource');
  @override
  late final GeneratedColumn<String?> metadataSource = GeneratedColumn<String?>(
      'metadata_source', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
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
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title']),
      artistName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}artist_name']),
      albumArtistName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}album_artist_name']),
      albumArtistId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}album_artist_id']),
      trackArtistId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}track_artist_id']),
      albumName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}album_name']),
      albumId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}album_id']),
      trackNo: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}track_no'])!,
      discNo: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}disc_no'])!,
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      descriptionSource: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}description_source']),
      uri: $TrackTableTable.$converter0.mapToDart(const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}uri']))!,
      coverUri: $TrackTableTable.$converter1.mapToDart(const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}cover_uri'])),
      coverUriRemote: $TrackTableTable.$converter2.mapToDart(const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}cover_uri_remote'])),
      coverSource: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}cover_source']),
      duration: $TrackTableTable.$converter3.mapToDart(const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}duration'])),
      year: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}year']),
      releaseDate: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}release_date']),
      available: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}available'])!,
      spotifyId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}spotify_id']),
      source: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}source']),
      metadataSource: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}metadata_source']),
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
}

abstract class _$BoDatabase extends GeneratedDatabase {
  _$BoDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  _$BoDatabase.connect(DatabaseConnection c) : super.connect(c);
  late final $ArtistTableTable artistTable = $ArtistTableTable(this);
  late final $AlbumTableTable albumTable = $AlbumTableTable(this);
  late final $TrackTableTable trackTable = $TrackTableTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [artistTable, albumTable, trackTable];
}
