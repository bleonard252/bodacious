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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ArtistMetadata _$ArtistMetadataFromJson(Map<String, dynamic> json) {
  return _ArtistMetadata.fromJson(json);
}

/// @nodoc
mixin _$ArtistMetadata {
  /// The artist's name.
  String get name => throw _privateConstructorUsedError;

  /// The URI to the artist icon.
  Uri? get coverUri => throw _privateConstructorUsedError;

  /// A remote URI to the cover, such as from Spotify.
  /// Generally the URL used to download the cover from [coverSource].
  /// This is used with Discord RPC.
  Uri? get coverUriRemote => throw _privateConstructorUsedError;

  /// Can be "spotify", "metadata", "neighbor", "mse", "lastfm", "genius", or other sources.
  String? get coverSource => throw _privateConstructorUsedError;

  /// A biography for the artist.
  String? get description => throw _privateConstructorUsedError;

  /// Where the biography came from.
  String? get descriptionSource => throw _privateConstructorUsedError;

  /// The total number of albums by this artist (or albums present in the library).
  int? get albumCount => throw _privateConstructorUsedError;

  /// The total number of tracks by this artist (or tracks present in the library).
  int? get trackCount => throw _privateConstructorUsedError;
  String? get spotifyId => throw _privateConstructorUsedError;
  String? get metadataSource => throw _privateConstructorUsedError;

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
  $Res call(
      {String name,
      Uri? coverUri,
      Uri? coverUriRemote,
      String? coverSource,
      String? description,
      String? descriptionSource,
      int? albumCount,
      int? trackCount,
      String? spotifyId,
      String? metadataSource});
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
    Object? coverUriRemote = freezed,
    Object? coverSource = freezed,
    Object? description = freezed,
    Object? descriptionSource = freezed,
    Object? albumCount = freezed,
    Object? trackCount = freezed,
    Object? spotifyId = freezed,
    Object? metadataSource = freezed,
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
      albumCount: albumCount == freezed
          ? _value.albumCount
          : albumCount // ignore: cast_nullable_to_non_nullable
              as int?,
      trackCount: trackCount == freezed
          ? _value.trackCount
          : trackCount // ignore: cast_nullable_to_non_nullable
              as int?,
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
abstract class _$ArtistMetadataCopyWith<$Res>
    implements $ArtistMetadataCopyWith<$Res> {
  factory _$ArtistMetadataCopyWith(
          _ArtistMetadata value, $Res Function(_ArtistMetadata) then) =
      __$ArtistMetadataCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      Uri? coverUri,
      Uri? coverUriRemote,
      String? coverSource,
      String? description,
      String? descriptionSource,
      int? albumCount,
      int? trackCount,
      String? spotifyId,
      String? metadataSource});
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
    Object? coverUriRemote = freezed,
    Object? coverSource = freezed,
    Object? description = freezed,
    Object? descriptionSource = freezed,
    Object? albumCount = freezed,
    Object? trackCount = freezed,
    Object? spotifyId = freezed,
    Object? metadataSource = freezed,
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
      albumCount: albumCount == freezed
          ? _value.albumCount
          : albumCount // ignore: cast_nullable_to_non_nullable
              as int?,
      trackCount: trackCount == freezed
          ? _value.trackCount
          : trackCount // ignore: cast_nullable_to_non_nullable
              as int?,
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
class _$_ArtistMetadata extends _ArtistMetadata with DiagnosticableTreeMixin {
  const _$_ArtistMetadata(
      {required this.name,
      this.coverUri,
      this.coverUriRemote,
      this.coverSource,
      this.description,
      this.descriptionSource,
      this.albumCount,
      this.trackCount,
      this.spotifyId,
      this.metadataSource})
      : super._();

  factory _$_ArtistMetadata.fromJson(Map<String, dynamic> json) =>
      _$$_ArtistMetadataFromJson(json);

  /// The artist's name.
  @override
  final String name;

  /// The URI to the artist icon.
  @override
  final Uri? coverUri;

  /// A remote URI to the cover, such as from Spotify.
  /// Generally the URL used to download the cover from [coverSource].
  /// This is used with Discord RPC.
  @override
  final Uri? coverUriRemote;

  /// Can be "spotify", "metadata", "neighbor", "mse", "lastfm", "genius", or other sources.
  @override
  final String? coverSource;

  /// A biography for the artist.
  @override
  final String? description;

  /// Where the biography came from.
  @override
  final String? descriptionSource;

  /// The total number of albums by this artist (or albums present in the library).
  @override
  final int? albumCount;

  /// The total number of tracks by this artist (or tracks present in the library).
  @override
  final int? trackCount;
  @override
  final String? spotifyId;
  @override
  final String? metadataSource;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ArtistMetadata(name: $name, coverUri: $coverUri, coverUriRemote: $coverUriRemote, coverSource: $coverSource, description: $description, descriptionSource: $descriptionSource, albumCount: $albumCount, trackCount: $trackCount, spotifyId: $spotifyId, metadataSource: $metadataSource)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ArtistMetadata'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('coverUri', coverUri))
      ..add(DiagnosticsProperty('coverUriRemote', coverUriRemote))
      ..add(DiagnosticsProperty('coverSource', coverSource))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('descriptionSource', descriptionSource))
      ..add(DiagnosticsProperty('albumCount', albumCount))
      ..add(DiagnosticsProperty('trackCount', trackCount))
      ..add(DiagnosticsProperty('spotifyId', spotifyId))
      ..add(DiagnosticsProperty('metadataSource', metadataSource));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ArtistMetadata &&
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
                .equals(other.albumCount, albumCount) &&
            const DeepCollectionEquality()
                .equals(other.trackCount, trackCount) &&
            const DeepCollectionEquality().equals(other.spotifyId, spotifyId) &&
            const DeepCollectionEquality()
                .equals(other.metadataSource, metadataSource));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(coverUri),
      const DeepCollectionEquality().hash(coverUriRemote),
      const DeepCollectionEquality().hash(coverSource),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(descriptionSource),
      const DeepCollectionEquality().hash(albumCount),
      const DeepCollectionEquality().hash(trackCount),
      const DeepCollectionEquality().hash(spotifyId),
      const DeepCollectionEquality().hash(metadataSource));

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
      {required final String name,
      final Uri? coverUri,
      final Uri? coverUriRemote,
      final String? coverSource,
      final String? description,
      final String? descriptionSource,
      final int? albumCount,
      final int? trackCount,
      final String? spotifyId,
      final String? metadataSource}) = _$_ArtistMetadata;
  const _ArtistMetadata._() : super._();

  factory _ArtistMetadata.fromJson(Map<String, dynamic> json) =
      _$_ArtistMetadata.fromJson;

  @override

  /// The artist's name.
  String get name => throw _privateConstructorUsedError;
  @override

  /// The URI to the artist icon.
  Uri? get coverUri => throw _privateConstructorUsedError;
  @override

  /// A remote URI to the cover, such as from Spotify.
  /// Generally the URL used to download the cover from [coverSource].
  /// This is used with Discord RPC.
  Uri? get coverUriRemote => throw _privateConstructorUsedError;
  @override

  /// Can be "spotify", "metadata", "neighbor", "mse", "lastfm", "genius", or other sources.
  String? get coverSource => throw _privateConstructorUsedError;
  @override

  /// A biography for the artist.
  String? get description => throw _privateConstructorUsedError;
  @override

  /// Where the biography came from.
  String? get descriptionSource => throw _privateConstructorUsedError;
  @override

  /// The total number of albums by this artist (or albums present in the library).
  int? get albumCount => throw _privateConstructorUsedError;
  @override

  /// The total number of tracks by this artist (or tracks present in the library).
  int? get trackCount => throw _privateConstructorUsedError;
  @override
  String? get spotifyId => throw _privateConstructorUsedError;
  @override
  String? get metadataSource => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ArtistMetadataCopyWith<_ArtistMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}
