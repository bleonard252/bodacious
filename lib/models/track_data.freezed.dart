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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TrackMetadata _$TrackMetadataFromJson(Map<String, dynamic> json) {
  return _TrackMetadata.fromJson(json);
}

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

  /// Extra details about a given track, such as its origins and meaning.
  String? get description => throw _privateConstructorUsedError;

  /// Where the [description] came from.
  String? get descriptionSource => throw _privateConstructorUsedError;

  /// Holds the data for a cover image. **DO NOT** STORE THIS IN THE DATABASE!
//@Deprecated("Don't use this, just use coverBytes or coverFile instead!")
  @JsonKey(ignore: true)
  ImageDescriptor? get coverData => throw _privateConstructorUsedError;

  /// The URI to the track. Used by the library (database) to find the file
  /// when it's time to play it, and for fallback details.
  Uri get uri => throw _privateConstructorUsedError;

  /// The raw bytes of the cover image. **DO NOT** STORE THIS IN THE DATABASE!
  @JsonKey(ignore: true)
  List<int>? get coverBytes => throw _privateConstructorUsedError;

  /// The URI to the cover.
  Uri? get coverUri => throw _privateConstructorUsedError;

  /// A remote URI to the cover, such as from Spotify.
  /// Generally the URL used to download the cover from [coverSource].
  /// This is used with Discord RPC.
  Uri? get coverUriRemote => throw _privateConstructorUsedError;

  /// Can be "album" in addition to album cover sources.
  /// "album" here indicates the cover is the same as the album's.
  String? get coverSource => throw _privateConstructorUsedError;

  /// The track's duration.
  Duration? get duration => throw _privateConstructorUsedError;

  /// The year the track was released. Prefer to show [releaseDate] wherever given.
  int? get year => throw _privateConstructorUsedError;

  /// The release date of this track.
  DateTime? get releaseDate => throw _privateConstructorUsedError;
  bool get available => throw _privateConstructorUsedError;
  String? get spotifyId => throw _privateConstructorUsedError;

  /// The source of the audio for this track.
  /// This indicates where the user got a particular file, i.e. if it is
  /// ripped or bought from Bandcamp or Amazon.
  /// This can also be "spotify" or "youtube" to indicate the audio should be
  /// sourced from those services respectively (but it doesn't work yet).
  String? get source => throw _privateConstructorUsedError;
  String? get metadataSource => throw _privateConstructorUsedError;

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
      String? description,
      String? descriptionSource,
      @JsonKey(ignore: true) ImageDescriptor? coverData,
      Uri uri,
      @JsonKey(ignore: true) List<int>? coverBytes,
      Uri? coverUri,
      Uri? coverUriRemote,
      String? coverSource,
      Duration? duration,
      int? year,
      DateTime? releaseDate,
      bool available,
      String? spotifyId,
      String? source,
      String? metadataSource});
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
    Object? description = freezed,
    Object? descriptionSource = freezed,
    Object? coverData = freezed,
    Object? uri = freezed,
    Object? coverBytes = freezed,
    Object? coverUri = freezed,
    Object? coverUriRemote = freezed,
    Object? coverSource = freezed,
    Object? duration = freezed,
    Object? year = freezed,
    Object? releaseDate = freezed,
    Object? available = freezed,
    Object? spotifyId = freezed,
    Object? source = freezed,
    Object? metadataSource = freezed,
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
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      descriptionSource: descriptionSource == freezed
          ? _value.descriptionSource
          : descriptionSource // ignore: cast_nullable_to_non_nullable
              as String?,
      coverData: coverData == freezed
          ? _value.coverData
          : coverData // ignore: cast_nullable_to_non_nullable
              as ImageDescriptor?,
      uri: uri == freezed
          ? _value.uri
          : uri // ignore: cast_nullable_to_non_nullable
              as Uri,
      coverBytes: coverBytes == freezed
          ? _value.coverBytes
          : coverBytes // ignore: cast_nullable_to_non_nullable
              as List<int>?,
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
      duration: duration == freezed
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration?,
      year: year == freezed
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int?,
      releaseDate: releaseDate == freezed
          ? _value.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      available: available == freezed
          ? _value.available
          : available // ignore: cast_nullable_to_non_nullable
              as bool,
      spotifyId: spotifyId == freezed
          ? _value.spotifyId
          : spotifyId // ignore: cast_nullable_to_non_nullable
              as String?,
      source: source == freezed
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String?,
      metadataSource: metadataSource == freezed
          ? _value.metadataSource
          : metadataSource // ignore: cast_nullable_to_non_nullable
              as String?,
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
      String? description,
      String? descriptionSource,
      @JsonKey(ignore: true) ImageDescriptor? coverData,
      Uri uri,
      @JsonKey(ignore: true) List<int>? coverBytes,
      Uri? coverUri,
      Uri? coverUriRemote,
      String? coverSource,
      Duration? duration,
      int? year,
      DateTime? releaseDate,
      bool available,
      String? spotifyId,
      String? source,
      String? metadataSource});
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
    Object? description = freezed,
    Object? descriptionSource = freezed,
    Object? coverData = freezed,
    Object? uri = freezed,
    Object? coverBytes = freezed,
    Object? coverUri = freezed,
    Object? coverUriRemote = freezed,
    Object? coverSource = freezed,
    Object? duration = freezed,
    Object? year = freezed,
    Object? releaseDate = freezed,
    Object? available = freezed,
    Object? spotifyId = freezed,
    Object? source = freezed,
    Object? metadataSource = freezed,
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
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      descriptionSource: descriptionSource == freezed
          ? _value.descriptionSource
          : descriptionSource // ignore: cast_nullable_to_non_nullable
              as String?,
      coverData: coverData == freezed
          ? _value.coverData
          : coverData // ignore: cast_nullable_to_non_nullable
              as ImageDescriptor?,
      uri: uri == freezed
          ? _value.uri
          : uri // ignore: cast_nullable_to_non_nullable
              as Uri,
      coverBytes: coverBytes == freezed
          ? _value.coverBytes
          : coverBytes // ignore: cast_nullable_to_non_nullable
              as List<int>?,
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
      duration: duration == freezed
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration?,
      year: year == freezed
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int?,
      releaseDate: releaseDate == freezed
          ? _value.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      available: available == freezed
          ? _value.available
          : available // ignore: cast_nullable_to_non_nullable
              as bool,
      spotifyId: spotifyId == freezed
          ? _value.spotifyId
          : spotifyId // ignore: cast_nullable_to_non_nullable
              as String?,
      source: source == freezed
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
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
class _$_TrackMetadata extends _TrackMetadata with DiagnosticableTreeMixin {
  const _$_TrackMetadata(
      {this.title,
      this.artistName,
      this.albumName,
      this.trackNo,
      this.discNo = 0,
      this.description,
      this.descriptionSource,
      @JsonKey(ignore: true) this.coverData,
      required this.uri,
      @JsonKey(ignore: true) final List<int>? coverBytes,
      this.coverUri,
      this.coverUriRemote,
      this.coverSource = "album",
      this.duration,
      this.year,
      this.releaseDate,
      this.available = true,
      this.spotifyId,
      this.source = "local",
      this.metadataSource})
      : _coverBytes = coverBytes,
        super._();

  factory _$_TrackMetadata.fromJson(Map<String, dynamic> json) =>
      _$$_TrackMetadataFromJson(json);

  /// The song's title.
  @override
  final String? title;

  /// The artist's name. Also used to look up the artist in the database.
  @override
  final String? artistName;

  /// The album's name. Also used with [artistName] to look up the album in the database.
  @override
  final String? albumName;

  /// The position of the track on the named album.
  @override
  final int? trackNo;
  @override
  @JsonKey()
  final int discNo;

  /// Extra details about a given track, such as its origins and meaning.
  @override
  final String? description;

  /// Where the [description] came from.
  @override
  final String? descriptionSource;

  /// Holds the data for a cover image. **DO NOT** STORE THIS IN THE DATABASE!
//@Deprecated("Don't use this, just use coverBytes or coverFile instead!")
  @override
  @JsonKey(ignore: true)
  final ImageDescriptor? coverData;

  /// The URI to the track. Used by the library (database) to find the file
  /// when it's time to play it, and for fallback details.
  @override
  final Uri uri;

  /// The raw bytes of the cover image. **DO NOT** STORE THIS IN THE DATABASE!
  @JsonKey(ignore: true)
  final List<int>? _coverBytes;

  /// The raw bytes of the cover image. **DO NOT** STORE THIS IN THE DATABASE!
  @override
  @JsonKey(ignore: true)
  List<int>? get coverBytes {
    final value = _coverBytes;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// The URI to the cover.
  @override
  final Uri? coverUri;

  /// A remote URI to the cover, such as from Spotify.
  /// Generally the URL used to download the cover from [coverSource].
  /// This is used with Discord RPC.
  @override
  final Uri? coverUriRemote;

  /// Can be "album" in addition to album cover sources.
  /// "album" here indicates the cover is the same as the album's.
  @override
  @JsonKey()
  final String? coverSource;

  /// The track's duration.
  @override
  final Duration? duration;

  /// The year the track was released. Prefer to show [releaseDate] wherever given.
  @override
  final int? year;

  /// The release date of this track.
  @override
  final DateTime? releaseDate;
  @override
  @JsonKey()
  final bool available;
  @override
  final String? spotifyId;

  /// The source of the audio for this track.
  /// This indicates where the user got a particular file, i.e. if it is
  /// ripped or bought from Bandcamp or Amazon.
  /// This can also be "spotify" or "youtube" to indicate the audio should be
  /// sourced from those services respectively (but it doesn't work yet).
  @override
  @JsonKey()
  final String? source;
  @override
  final String? metadataSource;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TrackMetadata(title: $title, artistName: $artistName, albumName: $albumName, trackNo: $trackNo, discNo: $discNo, description: $description, descriptionSource: $descriptionSource, coverData: $coverData, uri: $uri, coverBytes: $coverBytes, coverUri: $coverUri, coverUriRemote: $coverUriRemote, coverSource: $coverSource, duration: $duration, year: $year, releaseDate: $releaseDate, available: $available, spotifyId: $spotifyId, source: $source, metadataSource: $metadataSource)';
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
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('descriptionSource', descriptionSource))
      ..add(DiagnosticsProperty('coverData', coverData))
      ..add(DiagnosticsProperty('uri', uri))
      ..add(DiagnosticsProperty('coverBytes', coverBytes))
      ..add(DiagnosticsProperty('coverUri', coverUri))
      ..add(DiagnosticsProperty('coverUriRemote', coverUriRemote))
      ..add(DiagnosticsProperty('coverSource', coverSource))
      ..add(DiagnosticsProperty('duration', duration))
      ..add(DiagnosticsProperty('year', year))
      ..add(DiagnosticsProperty('releaseDate', releaseDate))
      ..add(DiagnosticsProperty('available', available))
      ..add(DiagnosticsProperty('spotifyId', spotifyId))
      ..add(DiagnosticsProperty('source', source))
      ..add(DiagnosticsProperty('metadataSource', metadataSource));
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
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality()
                .equals(other.descriptionSource, descriptionSource) &&
            const DeepCollectionEquality().equals(other.coverData, coverData) &&
            const DeepCollectionEquality().equals(other.uri, uri) &&
            const DeepCollectionEquality()
                .equals(other.coverBytes, coverBytes) &&
            const DeepCollectionEquality().equals(other.coverUri, coverUri) &&
            const DeepCollectionEquality()
                .equals(other.coverUriRemote, coverUriRemote) &&
            const DeepCollectionEquality()
                .equals(other.coverSource, coverSource) &&
            const DeepCollectionEquality().equals(other.duration, duration) &&
            const DeepCollectionEquality().equals(other.year, year) &&
            const DeepCollectionEquality()
                .equals(other.releaseDate, releaseDate) &&
            const DeepCollectionEquality().equals(other.available, available) &&
            const DeepCollectionEquality().equals(other.spotifyId, spotifyId) &&
            const DeepCollectionEquality().equals(other.source, source) &&
            const DeepCollectionEquality()
                .equals(other.metadataSource, metadataSource));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        const DeepCollectionEquality().hash(title),
        const DeepCollectionEquality().hash(artistName),
        const DeepCollectionEquality().hash(albumName),
        const DeepCollectionEquality().hash(trackNo),
        const DeepCollectionEquality().hash(discNo),
        const DeepCollectionEquality().hash(description),
        const DeepCollectionEquality().hash(descriptionSource),
        const DeepCollectionEquality().hash(coverData),
        const DeepCollectionEquality().hash(uri),
        const DeepCollectionEquality().hash(coverBytes),
        const DeepCollectionEquality().hash(coverUri),
        const DeepCollectionEquality().hash(coverUriRemote),
        const DeepCollectionEquality().hash(coverSource),
        const DeepCollectionEquality().hash(duration),
        const DeepCollectionEquality().hash(year),
        const DeepCollectionEquality().hash(releaseDate),
        const DeepCollectionEquality().hash(available),
        const DeepCollectionEquality().hash(spotifyId),
        const DeepCollectionEquality().hash(source),
        const DeepCollectionEquality().hash(metadataSource)
      ]);

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
      {final String? title,
      final String? artistName,
      final String? albumName,
      final int? trackNo,
      final int discNo,
      final String? description,
      final String? descriptionSource,
      @JsonKey(ignore: true) final ImageDescriptor? coverData,
      required final Uri uri,
      @JsonKey(ignore: true) final List<int>? coverBytes,
      final Uri? coverUri,
      final Uri? coverUriRemote,
      final String? coverSource,
      final Duration? duration,
      final int? year,
      final DateTime? releaseDate,
      final bool available,
      final String? spotifyId,
      final String? source,
      final String? metadataSource}) = _$_TrackMetadata;
  const _TrackMetadata._() : super._();

  factory _TrackMetadata.fromJson(Map<String, dynamic> json) =
      _$_TrackMetadata.fromJson;

  @override

  /// The song's title.
  String? get title => throw _privateConstructorUsedError;
  @override

  /// The artist's name. Also used to look up the artist in the database.
  String? get artistName => throw _privateConstructorUsedError;
  @override

  /// The album's name. Also used with [artistName] to look up the album in the database.
  String? get albumName => throw _privateConstructorUsedError;
  @override

  /// The position of the track on the named album.
  int? get trackNo => throw _privateConstructorUsedError;
  @override
  int get discNo => throw _privateConstructorUsedError;
  @override

  /// Extra details about a given track, such as its origins and meaning.
  String? get description => throw _privateConstructorUsedError;
  @override

  /// Where the [description] came from.
  String? get descriptionSource => throw _privateConstructorUsedError;
  @override

  /// Holds the data for a cover image. **DO NOT** STORE THIS IN THE DATABASE!
//@Deprecated("Don't use this, just use coverBytes or coverFile instead!")
  @JsonKey(ignore: true)
  ImageDescriptor? get coverData => throw _privateConstructorUsedError;
  @override

  /// The URI to the track. Used by the library (database) to find the file
  /// when it's time to play it, and for fallback details.
  Uri get uri => throw _privateConstructorUsedError;
  @override

  /// The raw bytes of the cover image. **DO NOT** STORE THIS IN THE DATABASE!
  @JsonKey(ignore: true)
  List<int>? get coverBytes => throw _privateConstructorUsedError;
  @override

  /// The URI to the cover.
  Uri? get coverUri => throw _privateConstructorUsedError;
  @override

  /// A remote URI to the cover, such as from Spotify.
  /// Generally the URL used to download the cover from [coverSource].
  /// This is used with Discord RPC.
  Uri? get coverUriRemote => throw _privateConstructorUsedError;
  @override

  /// Can be "album" in addition to album cover sources.
  /// "album" here indicates the cover is the same as the album's.
  String? get coverSource => throw _privateConstructorUsedError;
  @override

  /// The track's duration.
  Duration? get duration => throw _privateConstructorUsedError;
  @override

  /// The year the track was released. Prefer to show [releaseDate] wherever given.
  int? get year => throw _privateConstructorUsedError;
  @override

  /// The release date of this track.
  DateTime? get releaseDate => throw _privateConstructorUsedError;
  @override
  bool get available => throw _privateConstructorUsedError;
  @override
  String? get spotifyId => throw _privateConstructorUsedError;
  @override

  /// The source of the audio for this track.
  /// This indicates where the user got a particular file, i.e. if it is
  /// ripped or bought from Bandcamp or Amazon.
  /// This can also be "spotify" or "youtube" to indicate the audio should be
  /// sourced from those services respectively (but it doesn't work yet).
  String? get source => throw _privateConstructorUsedError;
  @override
  String? get metadataSource => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$TrackMetadataCopyWith<_TrackMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}
