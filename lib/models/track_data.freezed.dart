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

/// @nodoc
class _$TrackMetadataTearOff {
  const _$TrackMetadataTearOff();

  _TrackMetadata call(
      {String? title,
      String? artistName,
      String? albumName,
      dynamic coverData}) {
    return _TrackMetadata(
      title: title,
      artistName: artistName,
      albumName: albumName,
      coverData: coverData,
    );
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

  /// Not really sure what this will be yet but it'll somehow hold the data for the cover
  /// but it won't be stored in the database (loaded from tags or a file)
  dynamic get coverData => throw _privateConstructorUsedError;

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
      dynamic coverData});
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
    Object? coverData = freezed,
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
      coverData: coverData == freezed
          ? _value.coverData
          : coverData // ignore: cast_nullable_to_non_nullable
              as dynamic,
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
      dynamic coverData});
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
    Object? coverData = freezed,
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
      coverData: coverData == freezed
          ? _value.coverData
          : coverData // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$_TrackMetadata extends _TrackMetadata with DiagnosticableTreeMixin {
  const _$_TrackMetadata(
      {this.title, this.artistName, this.albumName, this.coverData})
      : super._();

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

  /// Not really sure what this will be yet but it'll somehow hold the data for the cover
  /// but it won't be stored in the database (loaded from tags or a file)
  final dynamic coverData;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TrackMetadata(title: $title, artistName: $artistName, albumName: $albumName, coverData: $coverData)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TrackMetadata'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('artistName', artistName))
      ..add(DiagnosticsProperty('albumName', albumName))
      ..add(DiagnosticsProperty('coverData', coverData));
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
            const DeepCollectionEquality().equals(other.coverData, coverData));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(artistName),
      const DeepCollectionEquality().hash(albumName),
      const DeepCollectionEquality().hash(coverData));

  @JsonKey(ignore: true)
  @override
  _$TrackMetadataCopyWith<_TrackMetadata> get copyWith =>
      __$TrackMetadataCopyWithImpl<_TrackMetadata>(this, _$identity);
}

abstract class _TrackMetadata extends TrackMetadata {
  const factory _TrackMetadata(
      {String? title,
      String? artistName,
      String? albumName,
      dynamic coverData}) = _$_TrackMetadata;
  const _TrackMetadata._() : super._();

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

  /// Not really sure what this will be yet but it'll somehow hold the data for the cover
  /// but it won't be stored in the database (loaded from tags or a file)
  dynamic get coverData;
  @override
  @JsonKey(ignore: true)
  _$TrackMetadataCopyWith<_TrackMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}
