// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'artist_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ArtistMetadata _$ArtistMetadataFromJson(Map<String, dynamic> json) {
  return _ArtistMetadata.fromJson(json);
}

/// @nodoc
class _$ArtistMetadataTearOff {
  const _$ArtistMetadataTearOff();

  _ArtistMetadata call(
      {required String name, Uri? coverUri, int? albumCount, int? trackCount}) {
    return _ArtistMetadata(
      name: name,
      coverUri: coverUri,
      albumCount: albumCount,
      trackCount: trackCount,
    );
  }

  ArtistMetadata fromJson(Map<String, Object?> json) {
    return ArtistMetadata.fromJson(json);
  }
}

/// @nodoc
const $ArtistMetadata = _$ArtistMetadataTearOff();

/// @nodoc
mixin _$ArtistMetadata {
  /// The artist's name.
  String get name => throw _privateConstructorUsedError;

  /// The URI to the artist icon.
  Uri? get coverUri => throw _privateConstructorUsedError;

  /// The total number of albums by this artist (or albums present in the library).
  int? get albumCount => throw _privateConstructorUsedError;

  /// The total number of tracks by this artist (or tracks present in the library).
  int? get trackCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ArtistMetadataCopyWith<ArtistMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArtistMetadataCopyWith<$Res> {
  factory $ArtistMetadataCopyWith(
          ArtistMetadata value, $Res Function(ArtistMetadata) then) =
      _$ArtistMetadataCopyWithImpl<$Res>;
  $Res call({String name, Uri? coverUri, int? albumCount, int? trackCount});
}

/// @nodoc
class _$ArtistMetadataCopyWithImpl<$Res>
    implements $ArtistMetadataCopyWith<$Res> {
  _$ArtistMetadataCopyWithImpl(this._value, this._then);

  final ArtistMetadata _value;
  // ignore: unused_field
  final $Res Function(ArtistMetadata) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? coverUri = freezed,
    Object? albumCount = freezed,
    Object? trackCount = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      coverUri: coverUri == freezed
          ? _value.coverUri
          : coverUri // ignore: cast_nullable_to_non_nullable
              as Uri?,
      albumCount: albumCount == freezed
          ? _value.albumCount
          : albumCount // ignore: cast_nullable_to_non_nullable
              as int?,
      trackCount: trackCount == freezed
          ? _value.trackCount
          : trackCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
abstract class _$ArtistMetadataCopyWith<$Res>
    implements $ArtistMetadataCopyWith<$Res> {
  factory _$ArtistMetadataCopyWith(
          _ArtistMetadata value, $Res Function(_ArtistMetadata) then) =
      __$ArtistMetadataCopyWithImpl<$Res>;
  @override
  $Res call({String name, Uri? coverUri, int? albumCount, int? trackCount});
}

/// @nodoc
class __$ArtistMetadataCopyWithImpl<$Res>
    extends _$ArtistMetadataCopyWithImpl<$Res>
    implements _$ArtistMetadataCopyWith<$Res> {
  __$ArtistMetadataCopyWithImpl(
      _ArtistMetadata _value, $Res Function(_ArtistMetadata) _then)
      : super(_value, (v) => _then(v as _ArtistMetadata));

  @override
  _ArtistMetadata get _value => super._value as _ArtistMetadata;

  @override
  $Res call({
    Object? name = freezed,
    Object? coverUri = freezed,
    Object? albumCount = freezed,
    Object? trackCount = freezed,
  }) {
    return _then(_ArtistMetadata(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      coverUri: coverUri == freezed
          ? _value.coverUri
          : coverUri // ignore: cast_nullable_to_non_nullable
              as Uri?,
      albumCount: albumCount == freezed
          ? _value.albumCount
          : albumCount // ignore: cast_nullable_to_non_nullable
              as int?,
      trackCount: trackCount == freezed
          ? _value.trackCount
          : trackCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ArtistMetadata extends _ArtistMetadata with DiagnosticableTreeMixin {
  const _$_ArtistMetadata(
      {required this.name, this.coverUri, this.albumCount, this.trackCount})
      : super._();

  factory _$_ArtistMetadata.fromJson(Map<String, dynamic> json) =>
      _$$_ArtistMetadataFromJson(json);

  @override

  /// The artist's name.
  final String name;
  @override

  /// The URI to the artist icon.
  final Uri? coverUri;
  @override

  /// The total number of albums by this artist (or albums present in the library).
  final int? albumCount;
  @override

  /// The total number of tracks by this artist (or tracks present in the library).
  final int? trackCount;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ArtistMetadata(name: $name, coverUri: $coverUri, albumCount: $albumCount, trackCount: $trackCount)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ArtistMetadata'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('coverUri', coverUri))
      ..add(DiagnosticsProperty('albumCount', albumCount))
      ..add(DiagnosticsProperty('trackCount', trackCount));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ArtistMetadata &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.coverUri, coverUri) &&
            const DeepCollectionEquality()
                .equals(other.albumCount, albumCount) &&
            const DeepCollectionEquality()
                .equals(other.trackCount, trackCount));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(coverUri),
      const DeepCollectionEquality().hash(albumCount),
      const DeepCollectionEquality().hash(trackCount));

  @JsonKey(ignore: true)
  @override
  _$ArtistMetadataCopyWith<_ArtistMetadata> get copyWith =>
      __$ArtistMetadataCopyWithImpl<_ArtistMetadata>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ArtistMetadataToJson(this);
  }
}

abstract class _ArtistMetadata extends ArtistMetadata {
  const factory _ArtistMetadata(
      {required String name,
      Uri? coverUri,
      int? albumCount,
      int? trackCount}) = _$_ArtistMetadata;
  const _ArtistMetadata._() : super._();

  factory _ArtistMetadata.fromJson(Map<String, dynamic> json) =
      _$_ArtistMetadata.fromJson;

  @override

  /// The artist's name.
  String get name;
  @override

  /// The URI to the artist icon.
  Uri? get coverUri;
  @override

  /// The total number of albums by this artist (or albums present in the library).
  int? get albumCount;
  @override

  /// The total number of tracks by this artist (or tracks present in the library).
  int? get trackCount;
  @override
  @JsonKey(ignore: true)
  _$ArtistMetadataCopyWith<_ArtistMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}
