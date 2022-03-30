// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'track_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TrackMetadata _$TrackMetadataFromJson(Map<String, dynamic> json) {
  return _TrackMetadata.fromJson(json);
}

/// @nodoc
class _$TrackMetadataTearOff {
  const _$TrackMetadataTearOff();

  _TrackMetadata call(
      {String? title,
      String? artistName,
      String? albumName,
      int? trackNo,
      int discNo = 0,
      @JsonKey(ignore: true) ImageDescriptor? coverData,
      Uri? uri,
      @JsonKey(ignore: true) List<int>? coverBytes,
      Uri? coverUri}) {
    return _TrackMetadata(
      title: title,
      artistName: artistName,
      albumName: albumName,
      trackNo: trackNo,
      discNo: discNo,
      coverData: coverData,
      uri: uri,
      coverBytes: coverBytes,
      coverUri: coverUri,
    );
  }

  TrackMetadata fromJson(Map<String, Object?> json) {
    return TrackMetadata.fromJson(json);
  }
}

/// @nodoc
const $TrackMetadata = _$TrackMetadataTearOff();

/// @nodoc
mixin _$TrackMetadata {
  /// The song's title.
  String? get title => throw _privateConstructorUsedError;

  /// The artist's name. Also used to look up the artist in the database.
  String? get artistName => throw _privateConstructorUsedError;

  /// The album's name. Also used with [artistName] to look up the album in the database.
  String? get albumName => throw _privateConstructorUsedError;

  /// The position of the track on the named album.
  int? get trackNo => throw _privateConstructorUsedError;
  int get discNo => throw _privateConstructorUsedError;

  /// Holds the data for a cover image. **DO NOT** STORE THIS IN THE DATABASE!
//@Deprecated("Don't use this, just use coverBytes or coverFile instead!")
  @JsonKey(ignore: true)
  ImageDescriptor? get coverData => throw _privateConstructorUsedError;

  /// The URI to the track. Used by the library (database) to find the file
  /// when it's time to play it, and for fallback details.
  Uri? get uri => throw _privateConstructorUsedError;

  /// The raw bytes of the cover image. **DO NOT** STORE THIS IN THE DATABASE!
  @JsonKey(ignore: true)
  List<int>? get coverBytes => throw _privateConstructorUsedError;

  /// The URI to the cover.
  Uri? get coverUri => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TrackMetadataCopyWith<TrackMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrackMetadataCopyWith<$Res> {
  factory $TrackMetadataCopyWith(
          TrackMetadata value, $Res Function(TrackMetadata) then) =
      _$TrackMetadataCopyWithImpl<$Res>;
  $Res call(
      {String? title,
      String? artistName,
      String? albumName,
      int? trackNo,
      int discNo,
      @JsonKey(ignore: true) ImageDescriptor? coverData,
      Uri? uri,
      @JsonKey(ignore: true) List<int>? coverBytes,
      Uri? coverUri});
}

/// @nodoc
class _$TrackMetadataCopyWithImpl<$Res>
    implements $TrackMetadataCopyWith<$Res> {
  _$TrackMetadataCopyWithImpl(this._value, this._then);

  final TrackMetadata _value;
  // ignore: unused_field
  final $Res Function(TrackMetadata) _then;

  @override
  $Res call({
    Object? title = freezed,
    Object? artistName = freezed,
    Object? albumName = freezed,
    Object? trackNo = freezed,
    Object? discNo = freezed,
    Object? coverData = freezed,
    Object? uri = freezed,
    Object? coverBytes = freezed,
    Object? coverUri = freezed,
  }) {
    return _then(_value.copyWith(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      artistName: artistName == freezed
          ? _value.artistName
          : artistName // ignore: cast_nullable_to_non_nullable
              as String?,
      albumName: albumName == freezed
          ? _value.albumName
          : albumName // ignore: cast_nullable_to_non_nullable
              as String?,
      trackNo: trackNo == freezed
          ? _value.trackNo
          : trackNo // ignore: cast_nullable_to_non_nullable
              as int?,
      discNo: discNo == freezed
          ? _value.discNo
          : discNo // ignore: cast_nullable_to_non_nullable
              as int,
      coverData: coverData == freezed
          ? _value.coverData
          : coverData // ignore: cast_nullable_to_non_nullable
              as ImageDescriptor?,
      uri: uri == freezed
          ? _value.uri
          : uri // ignore: cast_nullable_to_non_nullable
              as Uri?,
      coverBytes: coverBytes == freezed
          ? _value.coverBytes
          : coverBytes // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      coverUri: coverUri == freezed
          ? _value.coverUri
          : coverUri // ignore: cast_nullable_to_non_nullable
              as Uri?,
    ));
  }
}

/// @nodoc
abstract class _$TrackMetadataCopyWith<$Res>
    implements $TrackMetadataCopyWith<$Res> {
  factory _$TrackMetadataCopyWith(
          _TrackMetadata value, $Res Function(_TrackMetadata) then) =
      __$TrackMetadataCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? title,
      String? artistName,
      String? albumName,
      int? trackNo,
      int discNo,
      @JsonKey(ignore: true) ImageDescriptor? coverData,
      Uri? uri,
      @JsonKey(ignore: true) List<int>? coverBytes,
      Uri? coverUri});
}

/// @nodoc
class __$TrackMetadataCopyWithImpl<$Res>
    extends _$TrackMetadataCopyWithImpl<$Res>
    implements _$TrackMetadataCopyWith<$Res> {
  __$TrackMetadataCopyWithImpl(
      _TrackMetadata _value, $Res Function(_TrackMetadata) _then)
      : super(_value, (v) => _then(v as _TrackMetadata));

  @override
  _TrackMetadata get _value => super._value as _TrackMetadata;

  @override
  $Res call({
    Object? title = freezed,
    Object? artistName = freezed,
    Object? albumName = freezed,
    Object? trackNo = freezed,
    Object? discNo = freezed,
    Object? coverData = freezed,
    Object? uri = freezed,
    Object? coverBytes = freezed,
    Object? coverUri = freezed,
  }) {
    return _then(_TrackMetadata(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      artistName: artistName == freezed
          ? _value.artistName
          : artistName // ignore: cast_nullable_to_non_nullable
              as String?,
      albumName: albumName == freezed
          ? _value.albumName
          : albumName // ignore: cast_nullable_to_non_nullable
              as String?,
      trackNo: trackNo == freezed
          ? _value.trackNo
          : trackNo // ignore: cast_nullable_to_non_nullable
              as int?,
      discNo: discNo == freezed
          ? _value.discNo
          : discNo // ignore: cast_nullable_to_non_nullable
              as int,
      coverData: coverData == freezed
          ? _value.coverData
          : coverData // ignore: cast_nullable_to_non_nullable
              as ImageDescriptor?,
      uri: uri == freezed
          ? _value.uri
          : uri // ignore: cast_nullable_to_non_nullable
              as Uri?,
      coverBytes: coverBytes == freezed
          ? _value.coverBytes
          : coverBytes // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      coverUri: coverUri == freezed
          ? _value.coverUri
          : coverUri // ignore: cast_nullable_to_non_nullable
              as Uri?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TrackMetadata extends _TrackMetadata with DiagnosticableTreeMixin {
  const _$_TrackMetadata(
      {this.title,
      this.artistName,
      this.albumName,
      this.trackNo,
      this.discNo = 0,
      @JsonKey(ignore: true) this.coverData,
      this.uri,
      @JsonKey(ignore: true) this.coverBytes,
      this.coverUri})
      : super._();

  factory _$_TrackMetadata.fromJson(Map<String, dynamic> json) =>
      _$$_TrackMetadataFromJson(json);

  @override

  /// The song's title.
  final String? title;
  @override

  /// The artist's name. Also used to look up the artist in the database.
  final String? artistName;
  @override

  /// The album's name. Also used with [artistName] to look up the album in the database.
  final String? albumName;
  @override

  /// The position of the track on the named album.
  final int? trackNo;
  @JsonKey()
  @override
  final int discNo;
  @override

  /// Holds the data for a cover image. **DO NOT** STORE THIS IN THE DATABASE!
//@Deprecated("Don't use this, just use coverBytes or coverFile instead!")
  @JsonKey(ignore: true)
  final ImageDescriptor? coverData;
  @override

  /// The URI to the track. Used by the library (database) to find the file
  /// when it's time to play it, and for fallback details.
  final Uri? uri;
  @override

  /// The raw bytes of the cover image. **DO NOT** STORE THIS IN THE DATABASE!
  @JsonKey(ignore: true)
  final List<int>? coverBytes;
  @override

  /// The URI to the cover.
  final Uri? coverUri;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TrackMetadata(title: $title, artistName: $artistName, albumName: $albumName, trackNo: $trackNo, discNo: $discNo, coverData: $coverData, uri: $uri, coverBytes: $coverBytes, coverUri: $coverUri)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TrackMetadata'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('artistName', artistName))
      ..add(DiagnosticsProperty('albumName', albumName))
      ..add(DiagnosticsProperty('trackNo', trackNo))
      ..add(DiagnosticsProperty('discNo', discNo))
      ..add(DiagnosticsProperty('coverData', coverData))
      ..add(DiagnosticsProperty('uri', uri))
      ..add(DiagnosticsProperty('coverBytes', coverBytes))
      ..add(DiagnosticsProperty('coverUri', coverUri));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TrackMetadata &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality()
                .equals(other.artistName, artistName) &&
            const DeepCollectionEquality().equals(other.albumName, albumName) &&
            const DeepCollectionEquality().equals(other.trackNo, trackNo) &&
            const DeepCollectionEquality().equals(other.discNo, discNo) &&
            const DeepCollectionEquality().equals(other.coverData, coverData) &&
            const DeepCollectionEquality().equals(other.uri, uri) &&
            const DeepCollectionEquality()
                .equals(other.coverBytes, coverBytes) &&
            const DeepCollectionEquality().equals(other.coverUri, coverUri));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(artistName),
      const DeepCollectionEquality().hash(albumName),
      const DeepCollectionEquality().hash(trackNo),
      const DeepCollectionEquality().hash(discNo),
      const DeepCollectionEquality().hash(coverData),
      const DeepCollectionEquality().hash(uri),
      const DeepCollectionEquality().hash(coverBytes),
      const DeepCollectionEquality().hash(coverUri));

  @JsonKey(ignore: true)
  @override
  _$TrackMetadataCopyWith<_TrackMetadata> get copyWith =>
      __$TrackMetadataCopyWithImpl<_TrackMetadata>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TrackMetadataToJson(this);
  }
}

abstract class _TrackMetadata extends TrackMetadata {
  const factory _TrackMetadata(
      {String? title,
      String? artistName,
      String? albumName,
      int? trackNo,
      int discNo,
      @JsonKey(ignore: true) ImageDescriptor? coverData,
      Uri? uri,
      @JsonKey(ignore: true) List<int>? coverBytes,
      Uri? coverUri}) = _$_TrackMetadata;
  const _TrackMetadata._() : super._();

  factory _TrackMetadata.fromJson(Map<String, dynamic> json) =
      _$_TrackMetadata.fromJson;

  @override

  /// The song's title.
  String? get title;
  @override

  /// The artist's name. Also used to look up the artist in the database.
  String? get artistName;
  @override

  /// The album's name. Also used with [artistName] to look up the album in the database.
  String? get albumName;
  @override

  /// The position of the track on the named album.
  int? get trackNo;
  @override
  int get discNo;
  @override

  /// Holds the data for a cover image. **DO NOT** STORE THIS IN THE DATABASE!
//@Deprecated("Don't use this, just use coverBytes or coverFile instead!")
  @JsonKey(ignore: true)
  ImageDescriptor? get coverData;
  @override

  /// The URI to the track. Used by the library (database) to find the file
  /// when it's time to play it, and for fallback details.
  Uri? get uri;
  @override

  /// The raw bytes of the cover image. **DO NOT** STORE THIS IN THE DATABASE!
  @JsonKey(ignore: true)
  List<int>? get coverBytes;
  @override

  /// The URI to the cover.
  Uri? get coverUri;
  @override
  @JsonKey(ignore: true)
  _$TrackMetadataCopyWith<_TrackMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}
