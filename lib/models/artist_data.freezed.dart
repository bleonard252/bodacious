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
  /// The database ID of the artist.
  /// It is 7-20 characters long but is generally 10 characters long.
  /// These IDs are unique but not ordered.
  String get id => throw _privateConstructorUsedError;

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
      _$ArtistMetadataCopyWithImpl<$Res, ArtistMetadata>;
  @useResult
  $Res call(
      {String id,
      String name,
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
class _$ArtistMetadataCopyWithImpl<$Res, $Val extends ArtistMetadata>
    implements $ArtistMetadataCopyWith<$Res> {
  _$ArtistMetadataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
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
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
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
      albumCount: freezed == albumCount
          ? _value.albumCount
          : albumCount // ignore: cast_nullable_to_non_nullable
              as int?,
      trackCount: freezed == trackCount
          ? _value.trackCount
          : trackCount // ignore: cast_nullable_to_non_nullable
              as int?,
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
abstract class _$$_ArtistMetadataCopyWith<$Res>
    implements $ArtistMetadataCopyWith<$Res> {
  factory _$$_ArtistMetadataCopyWith(
          _$_ArtistMetadata value, $Res Function(_$_ArtistMetadata) then) =
      __$$_ArtistMetadataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
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
class __$$_ArtistMetadataCopyWithImpl<$Res>
    extends _$ArtistMetadataCopyWithImpl<$Res, _$_ArtistMetadata>
    implements _$$_ArtistMetadataCopyWith<$Res> {
  __$$_ArtistMetadataCopyWithImpl(
      _$_ArtistMetadata _value, $Res Function(_$_ArtistMetadata) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
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
    return _then(_$_ArtistMetadata(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
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
      albumCount: freezed == albumCount
          ? _value.albumCount
          : albumCount // ignore: cast_nullable_to_non_nullable
              as int?,
      trackCount: freezed == trackCount
          ? _value.trackCount
          : trackCount // ignore: cast_nullable_to_non_nullable
              as int?,
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
class _$_ArtistMetadata extends _ArtistMetadata with DiagnosticableTreeMixin {
  const _$_ArtistMetadata(
      {this.id = "",
      required this.name,
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

  /// The database ID of the artist.
  /// It is 7-20 characters long but is generally 10 characters long.
  /// These IDs are unique but not ordered.
  @override
  @JsonKey()
  final String id;

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
    return 'ArtistMetadata(id: $id, name: $name, coverUri: $coverUri, coverUriRemote: $coverUriRemote, coverSource: $coverSource, description: $description, descriptionSource: $descriptionSource, albumCount: $albumCount, trackCount: $trackCount, spotifyId: $spotifyId, metadataSource: $metadataSource)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ArtistMetadata'))
      ..add(DiagnosticsProperty('id', id))
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
            other is _$_ArtistMetadata &&
            (identical(other.id, id) || other.id == id) &&
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
            (identical(other.albumCount, albumCount) ||
                other.albumCount == albumCount) &&
            (identical(other.trackCount, trackCount) ||
                other.trackCount == trackCount) &&
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
      name,
      coverUri,
      coverUriRemote,
      coverSource,
      description,
      descriptionSource,
      albumCount,
      trackCount,
      spotifyId,
      metadataSource);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ArtistMetadataCopyWith<_$_ArtistMetadata> get copyWith =>
      __$$_ArtistMetadataCopyWithImpl<_$_ArtistMetadata>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ArtistMetadataToJson(
      this,
    );
  }
}

abstract class _ArtistMetadata extends ArtistMetadata {
  const factory _ArtistMetadata(
      {final String id,
      required final String name,
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

  /// The database ID of the artist.
  /// It is 7-20 characters long but is generally 10 characters long.
  /// These IDs are unique but not ordered.
  String get id;
  @override

  /// The artist's name.
  String get name;
  @override

  /// The URI to the artist icon.
  Uri? get coverUri;
  @override

  /// A remote URI to the cover, such as from Spotify.
  /// Generally the URL used to download the cover from [coverSource].
  /// This is used with Discord RPC.
  Uri? get coverUriRemote;
  @override

  /// Can be "spotify", "metadata", "neighbor", "mse", "lastfm", "genius", or other sources.
  String? get coverSource;
  @override

  /// A biography for the artist.
  String? get description;
  @override

  /// Where the biography came from.
  String? get descriptionSource;
  @override

  /// The total number of albums by this artist (or albums present in the library).
  int? get albumCount;
  @override

  /// The total number of tracks by this artist (or tracks present in the library).
  int? get trackCount;
  @override
  String? get spotifyId;
  @override
  String? get metadataSource;
  @override
  @JsonKey(ignore: true)
  _$$_ArtistMetadataCopyWith<_$_ArtistMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}
