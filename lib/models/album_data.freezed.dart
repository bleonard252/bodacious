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
  /// The artist's name, used to group this album and make it unique.
  String get artistName => throw _privateConstructorUsedError;

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
      _$AlbumMetadataCopyWithImpl<$Res>;
  $Res call(
      {String artistName,
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
class _$AlbumMetadataCopyWithImpl<$Res>
    implements $AlbumMetadataCopyWith<$Res> {
  _$AlbumMetadataCopyWithImpl(this._value, this._then);

  final AlbumMetadata _value;
  // ignore: unused_field
  final $Res Function(AlbumMetadata) _then;

  @override
  $Res call({
    Object? artistName = freezed,
    Object? name = freezed,
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
      artistName: artistName == freezed
          ? _value.artistName
          : artistName // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      coverUri: coverUri == freezed
          ? _value.coverUri
          : coverUri // ignore: cast_nullable_to_non_nullable
              as Uri?,
      coverUriRemote: coverUriRemote == freezed
          ? _value.coverUriRemote
          : coverUriRemote // ignore: cast_nullable_to_non_nullable
              as Uri?,
      coverSource: coverSource == freezed
          ? _value.coverSource
          : coverSource // ignore: cast_nullable_to_non_nullable
              as String?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      descriptionSource: descriptionSource == freezed
          ? _value.descriptionSource
          : descriptionSource // ignore: cast_nullable_to_non_nullable
              as String?,
      trackCount: trackCount == freezed
          ? _value.trackCount
          : trackCount // ignore: cast_nullable_to_non_nullable
              as int?,
      year: year == freezed
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int?,
      releaseDate: releaseDate == freezed
          ? _value.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      spotifyId: spotifyId == freezed
          ? _value.spotifyId
          : spotifyId // ignore: cast_nullable_to_non_nullable
              as String?,
      metadataSource: metadataSource == freezed
          ? _value.metadataSource
          : metadataSource // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$AlbumMetadataCopyWith<$Res>
    implements $AlbumMetadataCopyWith<$Res> {
  factory _$AlbumMetadataCopyWith(
          _AlbumMetadata value, $Res Function(_AlbumMetadata) then) =
      __$AlbumMetadataCopyWithImpl<$Res>;
  @override
  $Res call(
      {String artistName,
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
class __$AlbumMetadataCopyWithImpl<$Res>
    extends _$AlbumMetadataCopyWithImpl<$Res>
    implements _$AlbumMetadataCopyWith<$Res> {
  __$AlbumMetadataCopyWithImpl(
      _AlbumMetadata _value, $Res Function(_AlbumMetadata) _then)
      : super(_value, (v) => _then(v as _AlbumMetadata));

  @override
  _AlbumMetadata get _value => super._value as _AlbumMetadata;

  @override
  $Res call({
    Object? artistName = freezed,
    Object? name = freezed,
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
    return _then(_AlbumMetadata(
      artistName: artistName == freezed
          ? _value.artistName
          : artistName // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      coverUri: coverUri == freezed
          ? _value.coverUri
          : coverUri // ignore: cast_nullable_to_non_nullable
              as Uri?,
      coverUriRemote: coverUriRemote == freezed
          ? _value.coverUriRemote
          : coverUriRemote // ignore: cast_nullable_to_non_nullable
              as Uri?,
      coverSource: coverSource == freezed
          ? _value.coverSource
          : coverSource // ignore: cast_nullable_to_non_nullable
              as String?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      descriptionSource: descriptionSource == freezed
          ? _value.descriptionSource
          : descriptionSource // ignore: cast_nullable_to_non_nullable
              as String?,
      trackCount: trackCount == freezed
          ? _value.trackCount
          : trackCount // ignore: cast_nullable_to_non_nullable
              as int?,
      year: year == freezed
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int?,
      releaseDate: releaseDate == freezed
          ? _value.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      spotifyId: spotifyId == freezed
          ? _value.spotifyId
          : spotifyId // ignore: cast_nullable_to_non_nullable
              as String?,
      metadataSource: metadataSource == freezed
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
      {required this.artistName,
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

  /// The artist's name, used to group this album and make it unique.
  @override
  final String artistName;

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
    return 'AlbumMetadata(artistName: $artistName, name: $name, coverUri: $coverUri, coverUriRemote: $coverUriRemote, coverSource: $coverSource, description: $description, descriptionSource: $descriptionSource, trackCount: $trackCount, year: $year, releaseDate: $releaseDate, spotifyId: $spotifyId, metadataSource: $metadataSource)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AlbumMetadata'))
      ..add(DiagnosticsProperty('artistName', artistName))
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
            other is _AlbumMetadata &&
            const DeepCollectionEquality()
                .equals(other.artistName, artistName) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.coverUri, coverUri) &&
            const DeepCollectionEquality()
                .equals(other.coverUriRemote, coverUriRemote) &&
            const DeepCollectionEquality()
                .equals(other.coverSource, coverSource) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality()
                .equals(other.descriptionSource, descriptionSource) &&
            const DeepCollectionEquality()
                .equals(other.trackCount, trackCount) &&
            const DeepCollectionEquality().equals(other.year, year) &&
            const DeepCollectionEquality()
                .equals(other.releaseDate, releaseDate) &&
            const DeepCollectionEquality().equals(other.spotifyId, spotifyId) &&
            const DeepCollectionEquality()
                .equals(other.metadataSource, metadataSource));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(artistName),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(coverUri),
      const DeepCollectionEquality().hash(coverUriRemote),
      const DeepCollectionEquality().hash(coverSource),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(descriptionSource),
      const DeepCollectionEquality().hash(trackCount),
      const DeepCollectionEquality().hash(year),
      const DeepCollectionEquality().hash(releaseDate),
      const DeepCollectionEquality().hash(spotifyId),
      const DeepCollectionEquality().hash(metadataSource));

  @JsonKey(ignore: true)
  @override
  _$AlbumMetadataCopyWith<_AlbumMetadata> get copyWith =>
      __$AlbumMetadataCopyWithImpl<_AlbumMetadata>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AlbumMetadataToJson(this);
  }
}

abstract class _AlbumMetadata extends AlbumMetadata {
  const factory _AlbumMetadata(
      {required final String artistName,
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

  /// The artist's name, used to group this album and make it unique.
  String get artistName => throw _privateConstructorUsedError;
  @override

  /// The album's name.
  String get name => throw _privateConstructorUsedError;
  @override

  /// The URI to the album cover.
  Uri? get coverUri => throw _privateConstructorUsedError;
  @override
  Uri? get coverUriRemote => throw _privateConstructorUsedError;
  @override
  String? get coverSource => throw _privateConstructorUsedError;
  @override

  /// Extra details about the album.
  String? get description => throw _privateConstructorUsedError;
  @override

  /// Where the [description] came from.
  String? get descriptionSource => throw _privateConstructorUsedError;
  @override

  /// The total number of tracks on this album (or tracks present in the library).
  int? get trackCount => throw _privateConstructorUsedError;
  @override

  /// The year the album was released. Prefer to show [releaseDate] wherever given.
  int? get year => throw _privateConstructorUsedError;
  @override

  /// The release date of this album.
  DateTime? get releaseDate => throw _privateConstructorUsedError;
  @override
  String? get spotifyId => throw _privateConstructorUsedError;
  @override
  String? get metadataSource => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$AlbumMetadataCopyWith<_AlbumMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}
