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
      _$PlaylistMetadataCopyWithImpl<$Res>;
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
class _$PlaylistMetadataCopyWithImpl<$Res>
    implements $PlaylistMetadataCopyWith<$Res> {
  _$PlaylistMetadataCopyWithImpl(this._value, this._then);

  final PlaylistMetadata _value;
  // ignore: unused_field
  final $Res Function(PlaylistMetadata) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? coverUri = freezed,
    Object? description = freezed,
    Object? uri = freezed,
    Object? trackList = freezed,
    Object? document = freezed,
    Object? createdAt = freezed,
    Object? index = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      coverUri: coverUri == freezed
          ? _value.coverUri
          : coverUri // ignore: cast_nullable_to_non_nullable
              as Uri?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      uri: uri == freezed
          ? _value.uri
          : uri // ignore: cast_nullable_to_non_nullable
              as Uri,
      trackList: trackList == freezed
          ? _value.trackList
          : trackList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      document: document == freezed
          ? _value.document
          : document // ignore: cast_nullable_to_non_nullable
              as XmlDocument?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      index: index == freezed
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
abstract class _$$_PlaylistMetadataCopyWith<$Res>
    implements $PlaylistMetadataCopyWith<$Res> {
  factory _$$_PlaylistMetadataCopyWith(
          _$_PlaylistMetadata value, $Res Function(_$_PlaylistMetadata) then) =
      __$$_PlaylistMetadataCopyWithImpl<$Res>;
  @override
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
    extends _$PlaylistMetadataCopyWithImpl<$Res>
    implements _$$_PlaylistMetadataCopyWith<$Res> {
  __$$_PlaylistMetadataCopyWithImpl(
      _$_PlaylistMetadata _value, $Res Function(_$_PlaylistMetadata) _then)
      : super(_value, (v) => _then(v as _$_PlaylistMetadata));

  @override
  _$_PlaylistMetadata get _value => super._value as _$_PlaylistMetadata;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? coverUri = freezed,
    Object? description = freezed,
    Object? uri = freezed,
    Object? trackList = freezed,
    Object? document = freezed,
    Object? createdAt = freezed,
    Object? index = freezed,
  }) {
    return _then(_$_PlaylistMetadata(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      coverUri: coverUri == freezed
          ? _value.coverUri
          : coverUri // ignore: cast_nullable_to_non_nullable
              as Uri?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      uri: uri == freezed
          ? _value.uri
          : uri // ignore: cast_nullable_to_non_nullable
              as Uri,
      trackList: trackList == freezed
          ? _value._trackList
          : trackList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      document: document == freezed
          ? _value.document
          : document // ignore: cast_nullable_to_non_nullable
              as XmlDocument?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      index: index == freezed
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
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.coverUri, coverUri) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other.uri, uri) &&
            const DeepCollectionEquality()
                .equals(other._trackList, _trackList) &&
            const DeepCollectionEquality().equals(other.document, document) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.index, index));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(coverUri),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(uri),
      const DeepCollectionEquality().hash(_trackList),
      const DeepCollectionEquality().hash(document),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(index));

  @JsonKey(ignore: true)
  @override
  _$$_PlaylistMetadataCopyWith<_$_PlaylistMetadata> get copyWith =>
      __$$_PlaylistMetadataCopyWithImpl<_$_PlaylistMetadata>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PlaylistMetadataToJson(this);
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
  String get id => throw _privateConstructorUsedError;
  @override

  /// The user-defined name of this playlist.
  /// Defaults to the track, album, or artist used to create it.
  String get name => throw _privateConstructorUsedError;
  @override

  /// The URI to the cover. If not set, it defaults to:
  /// * no icon in the playlist view, AND
  /// * the first entry as the playlist icon in the list
  Uri? get coverUri => throw _privateConstructorUsedError;
  @override
  String? get description => throw _privateConstructorUsedError;
  @override

  /// The URI to the XSPF file for this playlist.
  Uri get uri => throw _privateConstructorUsedError;
  @override

  /// The URI of each track in the playlist, in order, as strings.
  /// Likely to be exactly how the <location/> contents appear.
  List<String> get trackList => throw _privateConstructorUsedError;
  @override

  /// Attach the XML document to the object to easily get additional metadata
  /// from the file itself.
  @JsonKey(ignore: true)
  XmlDocument? get document => throw _privateConstructorUsedError;
  @override

  /// The playlist's declared creation date.
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @override

  /// The index of the playlist in the Library menu.
  int? get index => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_PlaylistMetadataCopyWith<_$_PlaylistMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}
