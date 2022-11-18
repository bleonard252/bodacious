// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'playlist_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PlaylistMetadata _$PlaylistMetadataFromJson(Map<String, dynamic> json) {
  return _PlaylistMetadata.fromJson(json);
}

/// @nodoc
mixin _$PlaylistMetadata {
  /// The database ID of the playlist.
  String get id => throw _privateConstructorUsedError;

  /// The user-defined name of this playlist.
  /// Defaults to the track, album, or artist used to create it.
  String get name => throw _privateConstructorUsedError;

  /// The URI to the cover. If not set, it defaults to:
  /// * no icon in the playlist view, AND
  /// * the first entry as the playlist icon in the list
  Uri? get coverUri => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  /// The URI to the XSPF file for this playlist.
  Uri get uri => throw _privateConstructorUsedError;

  /// The URI of each track in the playlist, in order, as strings.
  /// Likely to be exactly how the <location/> contents appear.
  List<String> get trackList => throw _privateConstructorUsedError;

  /// Attach the XML document to the object to easily get additional metadata
  /// from the file itself.
  @JsonKey(ignore: true)
  XmlDocument? get document => throw _privateConstructorUsedError;

  /// The playlist's declared creation date.
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// The index of the playlist in the Library menu.
  int? get index => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlaylistMetadataCopyWith<PlaylistMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlaylistMetadataCopyWith<$Res> {
  factory $PlaylistMetadataCopyWith(
          PlaylistMetadata value, $Res Function(PlaylistMetadata) then) =
      _$PlaylistMetadataCopyWithImpl<$Res, PlaylistMetadata>;
  @useResult
  $Res call(
      {String id,
      String name,
      Uri? coverUri,
      String? description,
      Uri uri,
      List<String> trackList,
      @JsonKey(ignore: true) XmlDocument? document,
      DateTime? createdAt,
      int? index});
}

/// @nodoc
class _$PlaylistMetadataCopyWithImpl<$Res, $Val extends PlaylistMetadata>
    implements $PlaylistMetadataCopyWith<$Res> {
  _$PlaylistMetadataCopyWithImpl(this._value, this._then);

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
    Object? description = freezed,
    Object? uri = null,
    Object? trackList = null,
    Object? document = freezed,
    Object? createdAt = freezed,
    Object? index = freezed,
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
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      uri: null == uri
          ? _value.uri
          : uri // ignore: cast_nullable_to_non_nullable
              as Uri,
      trackList: null == trackList
          ? _value.trackList
          : trackList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      document: freezed == document
          ? _value.document
          : document // ignore: cast_nullable_to_non_nullable
              as XmlDocument?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      index: freezed == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PlaylistMetadataCopyWith<$Res>
    implements $PlaylistMetadataCopyWith<$Res> {
  factory _$$_PlaylistMetadataCopyWith(
          _$_PlaylistMetadata value, $Res Function(_$_PlaylistMetadata) then) =
      __$$_PlaylistMetadataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      Uri? coverUri,
      String? description,
      Uri uri,
      List<String> trackList,
      @JsonKey(ignore: true) XmlDocument? document,
      DateTime? createdAt,
      int? index});
}

/// @nodoc
class __$$_PlaylistMetadataCopyWithImpl<$Res>
    extends _$PlaylistMetadataCopyWithImpl<$Res, _$_PlaylistMetadata>
    implements _$$_PlaylistMetadataCopyWith<$Res> {
  __$$_PlaylistMetadataCopyWithImpl(
      _$_PlaylistMetadata _value, $Res Function(_$_PlaylistMetadata) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? coverUri = freezed,
    Object? description = freezed,
    Object? uri = null,
    Object? trackList = null,
    Object? document = freezed,
    Object? createdAt = freezed,
    Object? index = freezed,
  }) {
    return _then(_$_PlaylistMetadata(
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
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      uri: null == uri
          ? _value.uri
          : uri // ignore: cast_nullable_to_non_nullable
              as Uri,
      trackList: null == trackList
          ? _value._trackList
          : trackList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      document: freezed == document
          ? _value.document
          : document // ignore: cast_nullable_to_non_nullable
              as XmlDocument?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      index: freezed == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PlaylistMetadata extends _PlaylistMetadata
    with DiagnosticableTreeMixin {
  const _$_PlaylistMetadata(
      {this.id = "",
      required this.name,
      this.coverUri,
      this.description,
      required this.uri,
      final List<String> trackList = const [],
      @JsonKey(ignore: true) this.document,
      this.createdAt,
      this.index})
      : _trackList = trackList,
        super._();

  factory _$_PlaylistMetadata.fromJson(Map<String, dynamic> json) =>
      _$$_PlaylistMetadataFromJson(json);

  /// The database ID of the playlist.
  @override
  @JsonKey()
  final String id;

  /// The user-defined name of this playlist.
  /// Defaults to the track, album, or artist used to create it.
  @override
  final String name;

  /// The URI to the cover. If not set, it defaults to:
  /// * no icon in the playlist view, AND
  /// * the first entry as the playlist icon in the list
  @override
  final Uri? coverUri;
  @override
  final String? description;

  /// The URI to the XSPF file for this playlist.
  @override
  final Uri uri;

  /// The URI of each track in the playlist, in order, as strings.
  /// Likely to be exactly how the <location/> contents appear.
  final List<String> _trackList;

  /// The URI of each track in the playlist, in order, as strings.
  /// Likely to be exactly how the <location/> contents appear.
  @override
  @JsonKey()
  List<String> get trackList {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_trackList);
  }

  /// Attach the XML document to the object to easily get additional metadata
  /// from the file itself.
  @override
  @JsonKey(ignore: true)
  final XmlDocument? document;

  /// The playlist's declared creation date.
  @override
  final DateTime? createdAt;

  /// The index of the playlist in the Library menu.
  @override
  final int? index;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PlaylistMetadata(id: $id, name: $name, coverUri: $coverUri, description: $description, uri: $uri, trackList: $trackList, document: $document, createdAt: $createdAt, index: $index)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PlaylistMetadata'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('coverUri', coverUri))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('uri', uri))
      ..add(DiagnosticsProperty('trackList', trackList))
      ..add(DiagnosticsProperty('document', document))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('index', index));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PlaylistMetadata &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.coverUri, coverUri) ||
                other.coverUri == coverUri) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.uri, uri) || other.uri == uri) &&
            const DeepCollectionEquality()
                .equals(other._trackList, _trackList) &&
            (identical(other.document, document) ||
                other.document == document) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.index, index) || other.index == index));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      coverUri,
      description,
      uri,
      const DeepCollectionEquality().hash(_trackList),
      document,
      createdAt,
      index);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PlaylistMetadataCopyWith<_$_PlaylistMetadata> get copyWith =>
      __$$_PlaylistMetadataCopyWithImpl<_$_PlaylistMetadata>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PlaylistMetadataToJson(
      this,
    );
  }
}

abstract class _PlaylistMetadata extends PlaylistMetadata {
  const factory _PlaylistMetadata(
      {final String id,
      required final String name,
      final Uri? coverUri,
      final String? description,
      required final Uri uri,
      final List<String> trackList,
      @JsonKey(ignore: true) final XmlDocument? document,
      final DateTime? createdAt,
      final int? index}) = _$_PlaylistMetadata;
  const _PlaylistMetadata._() : super._();

  factory _PlaylistMetadata.fromJson(Map<String, dynamic> json) =
      _$_PlaylistMetadata.fromJson;

  @override

  /// The database ID of the playlist.
  String get id;
  @override

  /// The user-defined name of this playlist.
  /// Defaults to the track, album, or artist used to create it.
  String get name;
  @override

  /// The URI to the cover. If not set, it defaults to:
  /// * no icon in the playlist view, AND
  /// * the first entry as the playlist icon in the list
  Uri? get coverUri;
  @override
  String? get description;
  @override

  /// The URI to the XSPF file for this playlist.
  Uri get uri;
  @override

  /// The URI of each track in the playlist, in order, as strings.
  /// Likely to be exactly how the <location/> contents appear.
  List<String> get trackList;
  @override

  /// Attach the XML document to the object to easily get additional metadata
  /// from the file itself.
  @JsonKey(ignore: true)
  XmlDocument? get document;
  @override

  /// The playlist's declared creation date.
  DateTime? get createdAt;
  @override

  /// The index of the playlist in the Library menu.
  int? get index;
  @override
  @JsonKey(ignore: true)
  _$$_PlaylistMetadataCopyWith<_$_PlaylistMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}
