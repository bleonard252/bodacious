// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'album_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AlbumMetadata _$AlbumMetadataFromJson(Map<String, dynamic> json) {
  return _AlbumMetadata.fromJson(json);
}

/// @nodoc
mixin _$AlbumMetadata {
  /// The database ID of the album.
  /// It is 7-20 characters long but is generally 12 characters long.
  /// These IDs are unique but not ordered.
  String get id => throw _privateConstructorUsedError;

  /// The artist's name, used to group this album and make it unique.
  String get artistName => throw _privateConstructorUsedError;
  String? get artistId => throw _privateConstructorUsedError;

  /// The album's name.
  String get name => throw _privateConstructorUsedError;

  /// The URI to the album cover.
  Uri? get coverUri => throw _privateConstructorUsedError;
  Uri? get coverUriRemote => throw _privateConstructorUsedError;
  String? get coverSource => throw _privateConstructorUsedError;

  /// Extra details about the album.
  String? get description => throw _privateConstructorUsedError;

  /// Where the [description] came from.
  String? get descriptionSource => throw _privateConstructorUsedError;

  /// The total number of tracks on this album (or tracks present in the library).
  int? get trackCount => throw _privateConstructorUsedError;

  /// The year the album was released. Prefer to show [releaseDate] wherever given.
  int? get year => throw _privateConstructorUsedError;

  /// The release date of this album.
  DateTime? get releaseDate => throw _privateConstructorUsedError;
  String? get spotifyId => throw _privateConstructorUsedError;
  String? get metadataSource => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AlbumMetadataCopyWith<AlbumMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlbumMetadataCopyWith<$Res> {
  factory $AlbumMetadataCopyWith(
          AlbumMetadata value, $Res Function(AlbumMetadata) then) =
      _$AlbumMetadataCopyWithImpl<$Res, AlbumMetadata>;
  @useResult
  $Res call(
      {String id,
      String artistName,
      String? artistId,
      String name,
      Uri? coverUri,
      Uri? coverUriRemote,
      String? coverSource,
      String? description,
      String? descriptionSource,
      int? trackCount,
      int? year,
      DateTime? releaseDate,
      String? spotifyId,
      String? metadataSource});
}

/// @nodoc
class _$AlbumMetadataCopyWithImpl<$Res, $Val extends AlbumMetadata>
    implements $AlbumMetadataCopyWith<$Res> {
  _$AlbumMetadataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? artistName = null,
    Object? artistId = freezed,
    Object? name = null,
    Object? coverUri = freezed,
    Object? coverUriRemote = freezed,
    Object? coverSource = freezed,
    Object? description = freezed,
    Object? descriptionSource = freezed,
    Object? trackCount = freezed,
    Object? year = freezed,
    Object? releaseDate = freezed,
    Object? spotifyId = freezed,
    Object? metadataSource = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      artistName: null == artistName
          ? _value.artistName
          : artistName // ignore: cast_nullable_to_non_nullable
              as String,
      artistId: freezed == artistId
          ? _value.artistId
          : artistId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      coverUri: freezed == coverUri
          ? _value.coverUri
          : coverUri // ignore: cast_nullable_to_non_nullable
              as Uri?,
      coverUriRemote: freezed == coverUriRemote
          ? _value.coverUriRemote
          : coverUriRemote // ignore: cast_nullable_to_non_nullable
              as Uri?,
      coverSource: freezed == coverSource
          ? _value.coverSource
          : coverSource // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      descriptionSource: freezed == descriptionSource
          ? _value.descriptionSource
          : descriptionSource // ignore: cast_nullable_to_non_nullable
              as String?,
      trackCount: freezed == trackCount
          ? _value.trackCount
          : trackCount // ignore: cast_nullable_to_non_nullable
              as int?,
      year: freezed == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int?,
      releaseDate: freezed == releaseDate
          ? _value.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      spotifyId: freezed == spotifyId
          ? _value.spotifyId
          : spotifyId // ignore: cast_nullable_to_non_nullable
              as String?,
      metadataSource: freezed == metadataSource
          ? _value.metadataSource
          : metadataSource // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AlbumMetadataCopyWith<$Res>
    implements $AlbumMetadataCopyWith<$Res> {
  factory _$$_AlbumMetadataCopyWith(
          _$_AlbumMetadata value, $Res Function(_$_AlbumMetadata) then) =
      __$$_AlbumMetadataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String artistName,
      String? artistId,
      String name,
      Uri? coverUri,
      Uri? coverUriRemote,
      String? coverSource,
      String? description,
      String? descriptionSource,
      int? trackCount,
      int? year,
      DateTime? releaseDate,
      String? spotifyId,
      String? metadataSource});
}

/// @nodoc
class __$$_AlbumMetadataCopyWithImpl<$Res>
    extends _$AlbumMetadataCopyWithImpl<$Res, _$_AlbumMetadata>
    implements _$$_AlbumMetadataCopyWith<$Res> {
  __$$_AlbumMetadataCopyWithImpl(
      _$_AlbumMetadata _value, $Res Function(_$_AlbumMetadata) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? artistName = null,
    Object? artistId = freezed,
    Object? name = null,
    Object? coverUri = freezed,
    Object? coverUriRemote = freezed,
    Object? coverSource = freezed,
    Object? description = freezed,
    Object? descriptionSource = freezed,
    Object? trackCount = freezed,
    Object? year = freezed,
    Object? releaseDate = freezed,
    Object? spotifyId = freezed,
    Object? metadataSource = freezed,
  }) {
    return _then(_$_AlbumMetadata(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      artistName: null == artistName
          ? _value.artistName
          : artistName // ignore: cast_nullable_to_non_nullable
              as String,
      artistId: freezed == artistId
          ? _value.artistId
          : artistId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      coverUri: freezed == coverUri
          ? _value.coverUri
          : coverUri // ignore: cast_nullable_to_non_nullable
              as Uri?,
      coverUriRemote: freezed == coverUriRemote
          ? _value.coverUriRemote
          : coverUriRemote // ignore: cast_nullable_to_non_nullable
              as Uri?,
      coverSource: freezed == coverSource
          ? _value.coverSource
          : coverSource // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      descriptionSource: freezed == descriptionSource
          ? _value.descriptionSource
          : descriptionSource // ignore: cast_nullable_to_non_nullable
              as String?,
      trackCount: freezed == trackCount
          ? _value.trackCount
          : trackCount // ignore: cast_nullable_to_non_nullable
              as int?,
      year: freezed == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int?,
      releaseDate: freezed == releaseDate
          ? _value.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      spotifyId: freezed == spotifyId
          ? _value.spotifyId
          : spotifyId // ignore: cast_nullable_to_non_nullable
              as String?,
      metadataSource: freezed == metadataSource
          ? _value.metadataSource
          : metadataSource // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AlbumMetadata extends _AlbumMetadata with DiagnosticableTreeMixin {
  const _$_AlbumMetadata(
      {this.id = "",
      required this.artistName,
      this.artistId,
      required this.name,
      this.coverUri,
      this.coverUriRemote,
      this.coverSource,
      this.description,
      this.descriptionSource,
      this.trackCount,
      this.year,
      this.releaseDate,
      this.spotifyId,
      this.metadataSource})
      : super._();

  factory _$_AlbumMetadata.fromJson(Map<String, dynamic> json) =>
      _$$_AlbumMetadataFromJson(json);

  /// The database ID of the album.
  /// It is 7-20 characters long but is generally 12 characters long.
  /// These IDs are unique but not ordered.
  @override
  @JsonKey()
  final String id;

  /// The artist's name, used to group this album and make it unique.
  @override
  final String artistName;
  @override
  final String? artistId;

  /// The album's name.
  @override
  final String name;

  /// The URI to the album cover.
  @override
  final Uri? coverUri;
  @override
  final Uri? coverUriRemote;
  @override
  final String? coverSource;

  /// Extra details about the album.
  @override
  final String? description;

  /// Where the [description] came from.
  @override
  final String? descriptionSource;

  /// The total number of tracks on this album (or tracks present in the library).
  @override
  final int? trackCount;

  /// The year the album was released. Prefer to show [releaseDate] wherever given.
  @override
  final int? year;

  /// The release date of this album.
  @override
  final DateTime? releaseDate;
  @override
  final String? spotifyId;
  @override
  final String? metadataSource;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AlbumMetadata(id: $id, artistName: $artistName, artistId: $artistId, name: $name, coverUri: $coverUri, coverUriRemote: $coverUriRemote, coverSource: $coverSource, description: $description, descriptionSource: $descriptionSource, trackCount: $trackCount, year: $year, releaseDate: $releaseDate, spotifyId: $spotifyId, metadataSource: $metadataSource)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AlbumMetadata'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('artistName', artistName))
      ..add(DiagnosticsProperty('artistId', artistId))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('coverUri', coverUri))
      ..add(DiagnosticsProperty('coverUriRemote', coverUriRemote))
      ..add(DiagnosticsProperty('coverSource', coverSource))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('descriptionSource', descriptionSource))
      ..add(DiagnosticsProperty('trackCount', trackCount))
      ..add(DiagnosticsProperty('year', year))
      ..add(DiagnosticsProperty('releaseDate', releaseDate))
      ..add(DiagnosticsProperty('spotifyId', spotifyId))
      ..add(DiagnosticsProperty('metadataSource', metadataSource));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AlbumMetadata &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.artistName, artistName) ||
                other.artistName == artistName) &&
            (identical(other.artistId, artistId) ||
                other.artistId == artistId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.coverUri, coverUri) ||
                other.coverUri == coverUri) &&
            (identical(other.coverUriRemote, coverUriRemote) ||
                other.coverUriRemote == coverUriRemote) &&
            (identical(other.coverSource, coverSource) ||
                other.coverSource == coverSource) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.descriptionSource, descriptionSource) ||
                other.descriptionSource == descriptionSource) &&
            (identical(other.trackCount, trackCount) ||
                other.trackCount == trackCount) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.releaseDate, releaseDate) ||
                other.releaseDate == releaseDate) &&
            (identical(other.spotifyId, spotifyId) ||
                other.spotifyId == spotifyId) &&
            (identical(other.metadataSource, metadataSource) ||
                other.metadataSource == metadataSource));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      artistName,
      artistId,
      name,
      coverUri,
      coverUriRemote,
      coverSource,
      description,
      descriptionSource,
      trackCount,
      year,
      releaseDate,
      spotifyId,
      metadataSource);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AlbumMetadataCopyWith<_$_AlbumMetadata> get copyWith =>
      __$$_AlbumMetadataCopyWithImpl<_$_AlbumMetadata>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AlbumMetadataToJson(
      this,
    );
  }
}

abstract class _AlbumMetadata extends AlbumMetadata {
  const factory _AlbumMetadata(
      {final String id,
      required final String artistName,
      final String? artistId,
      required final String name,
      final Uri? coverUri,
      final Uri? coverUriRemote,
      final String? coverSource,
      final String? description,
      final String? descriptionSource,
      final int? trackCount,
      final int? year,
      final DateTime? releaseDate,
      final String? spotifyId,
      final String? metadataSource}) = _$_AlbumMetadata;
  const _AlbumMetadata._() : super._();

  factory _AlbumMetadata.fromJson(Map<String, dynamic> json) =
      _$_AlbumMetadata.fromJson;

  @override

  /// The database ID of the album.
  /// It is 7-20 characters long but is generally 12 characters long.
  /// These IDs are unique but not ordered.
  String get id;
  @override

  /// The artist's name, used to group this album and make it unique.
  String get artistName;
  @override
  String? get artistId;
  @override

  /// The album's name.
  String get name;
  @override

  /// The URI to the album cover.
  Uri? get coverUri;
  @override
  Uri? get coverUriRemote;
  @override
  String? get coverSource;
  @override

  /// Extra details about the album.
  String? get description;
  @override

  /// Where the [description] came from.
  String? get descriptionSource;
  @override

  /// The total number of tracks on this album (or tracks present in the library).
  int? get trackCount;
  @override

  /// The year the album was released. Prefer to show [releaseDate] wherever given.
  int? get year;
  @override

  /// The release date of this album.
  DateTime? get releaseDate;
  @override
  String? get spotifyId;
  @override
  String? get metadataSource;
  @override
  @JsonKey(ignore: true)
  _$$_AlbumMetadataCopyWith<_$_AlbumMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}
