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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AlbumMetadata _$AlbumMetadataFromJson(Map<String, dynamic> json) {
  return _AlbumMetadata.fromJson(json);
}

/// @nodoc
class _$AlbumMetadataTearOff {
  const _$AlbumMetadataTearOff();

  _AlbumMetadata call(
      {required String artistName,
      required String name,
      Uri? coverUri,
      int? trackCount,
      int? year,
      DateTime? releaseDate}) {
    return _AlbumMetadata(
      artistName: artistName,
      name: name,
      coverUri: coverUri,
      trackCount: trackCount,
      year: year,
      releaseDate: releaseDate,
    );
  }

  AlbumMetadata fromJson(Map<String, Object?> json) {
    return AlbumMetadata.fromJson(json);
  }
}

/// @nodoc
const $AlbumMetadata = _$AlbumMetadataTearOff();

/// @nodoc
mixin _$AlbumMetadata {
  /// The artist's name, used to group this album and make it unique.
  String get artistName => throw _privateConstructorUsedError;

  /// The album's name.
  String get name => throw _privateConstructorUsedError;

  /// The URI to the album cover.
  Uri? get coverUri => throw _privateConstructorUsedError;

  /// The total number of tracks on this album (or tracks present in the library).
  int? get trackCount => throw _privateConstructorUsedError;

  /// The year the album was released. Prefer to show [releaseDate] wherever given.
  int? get year => throw _privateConstructorUsedError;

  /// The release date of this album.
  DateTime? get releaseDate => throw _privateConstructorUsedError;

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
      int? trackCount,
      int? year,
      DateTime? releaseDate});
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
    Object? trackCount = freezed,
    Object? year = freezed,
    Object? releaseDate = freezed,
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
      int? trackCount,
      int? year,
      DateTime? releaseDate});
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
    Object? trackCount = freezed,
    Object? year = freezed,
    Object? releaseDate = freezed,
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AlbumMetadata with DiagnosticableTreeMixin implements _AlbumMetadata {
  const _$_AlbumMetadata(
      {required this.artistName,
      required this.name,
      this.coverUri,
      this.trackCount,
      this.year,
      this.releaseDate});

  factory _$_AlbumMetadata.fromJson(Map<String, dynamic> json) =>
      _$$_AlbumMetadataFromJson(json);

  @override

  /// The artist's name, used to group this album and make it unique.
  final String artistName;
  @override

  /// The album's name.
  final String name;
  @override

  /// The URI to the album cover.
  final Uri? coverUri;
  @override

  /// The total number of tracks on this album (or tracks present in the library).
  final int? trackCount;
  @override

  /// The year the album was released. Prefer to show [releaseDate] wherever given.
  final int? year;
  @override

  /// The release date of this album.
  final DateTime? releaseDate;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AlbumMetadata(artistName: $artistName, name: $name, coverUri: $coverUri, trackCount: $trackCount, year: $year, releaseDate: $releaseDate)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AlbumMetadata'))
      ..add(DiagnosticsProperty('artistName', artistName))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('coverUri', coverUri))
      ..add(DiagnosticsProperty('trackCount', trackCount))
      ..add(DiagnosticsProperty('year', year))
      ..add(DiagnosticsProperty('releaseDate', releaseDate));
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
                .equals(other.trackCount, trackCount) &&
            const DeepCollectionEquality().equals(other.year, year) &&
            const DeepCollectionEquality()
                .equals(other.releaseDate, releaseDate));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(artistName),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(coverUri),
      const DeepCollectionEquality().hash(trackCount),
      const DeepCollectionEquality().hash(year),
      const DeepCollectionEquality().hash(releaseDate));

  @JsonKey(ignore: true)
  @override
  _$AlbumMetadataCopyWith<_AlbumMetadata> get copyWith =>
      __$AlbumMetadataCopyWithImpl<_AlbumMetadata>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AlbumMetadataToJson(this);
  }
}

abstract class _AlbumMetadata implements AlbumMetadata {
  const factory _AlbumMetadata(
      {required String artistName,
      required String name,
      Uri? coverUri,
      int? trackCount,
      int? year,
      DateTime? releaseDate}) = _$_AlbumMetadata;

  factory _AlbumMetadata.fromJson(Map<String, dynamic> json) =
      _$_AlbumMetadata.fromJson;

  @override

  /// The artist's name, used to group this album and make it unique.
  String get artistName;
  @override

  /// The album's name.
  String get name;
  @override

  /// The URI to the album cover.
  Uri? get coverUri;
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
  @JsonKey(ignore: true)
  _$AlbumMetadataCopyWith<_AlbumMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}
