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
  /// The database ID of the track.
  /// It is 7-20 characters long but is generally 13 characters long.
  /// These IDs are unique but not ordered.
  String get id => throw _privateConstructorUsedError;

  /// The song's title.
  String? get title => throw _privateConstructorUsedError;

  /// The track artist's name.
  String? get artistName => throw _privateConstructorUsedError;

  /// The name of the artist of the album.
  String? get albumArtistName => throw _privateConstructorUsedError;

  /// The database ID of the album artist.
  String? get albumArtistId => throw _privateConstructorUsedError;

  /// The database ID of the track artist.
  /// This is usually the same as [albumArtistId].
  String? get trackArtistId => throw _privateConstructorUsedError;

  /// The album's name. Also used with [artistName] to look up the album in the database.
  String? get albumName => throw _privateConstructorUsedError;

  /// The album's database ID.
  String? get albumId => throw _privateConstructorUsedError;

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
      _$TrackMetadataCopyWithImpl<$Res, TrackMetadata>;
  @useResult
  $Res call(
      {String id,
      String? title,
      String? artistName,
      String? albumArtistName,
      String? albumArtistId,
      String? trackArtistId,
      String? albumName,
      String? albumId,
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
class _$TrackMetadataCopyWithImpl<$Res, $Val extends TrackMetadata>
    implements $TrackMetadataCopyWith<$Res> {
  _$TrackMetadataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = freezed,
    Object? artistName = freezed,
    Object? albumArtistName = freezed,
    Object? albumArtistId = freezed,
    Object? trackArtistId = freezed,
    Object? albumName = freezed,
    Object? albumId = freezed,
    Object? trackNo = freezed,
    Object? discNo = null,
    Object? description = freezed,
    Object? descriptionSource = freezed,
    Object? coverData = freezed,
    Object? uri = null,
    Object? coverBytes = freezed,
    Object? coverUri = freezed,
    Object? coverUriRemote = freezed,
    Object? coverSource = freezed,
    Object? duration = freezed,
    Object? year = freezed,
    Object? releaseDate = freezed,
    Object? available = null,
    Object? spotifyId = freezed,
    Object? source = freezed,
    Object? metadataSource = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      artistName: freezed == artistName
          ? _value.artistName
          : artistName // ignore: cast_nullable_to_non_nullable
              as String?,
      albumArtistName: freezed == albumArtistName
          ? _value.albumArtistName
          : albumArtistName // ignore: cast_nullable_to_non_nullable
              as String?,
      albumArtistId: freezed == albumArtistId
          ? _value.albumArtistId
          : albumArtistId // ignore: cast_nullable_to_non_nullable
              as String?,
      trackArtistId: freezed == trackArtistId
          ? _value.trackArtistId
          : trackArtistId // ignore: cast_nullable_to_non_nullable
              as String?,
      albumName: freezed == albumName
          ? _value.albumName
          : albumName // ignore: cast_nullable_to_non_nullable
              as String?,
      albumId: freezed == albumId
          ? _value.albumId
          : albumId // ignore: cast_nullable_to_non_nullable
              as String?,
      trackNo: freezed == trackNo
          ? _value.trackNo
          : trackNo // ignore: cast_nullable_to_non_nullable
              as int?,
      discNo: null == discNo
          ? _value.discNo
          : discNo // ignore: cast_nullable_to_non_nullable
              as int,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      descriptionSource: freezed == descriptionSource
          ? _value.descriptionSource
          : descriptionSource // ignore: cast_nullable_to_non_nullable
              as String?,
      coverData: freezed == coverData
          ? _value.coverData
          : coverData // ignore: cast_nullable_to_non_nullable
              as ImageDescriptor?,
      uri: null == uri
          ? _value.uri
          : uri // ignore: cast_nullable_to_non_nullable
              as Uri,
      coverBytes: freezed == coverBytes
          ? _value.coverBytes
          : coverBytes // ignore: cast_nullable_to_non_nullable
              as List<int>?,
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
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration?,
      year: freezed == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int?,
      releaseDate: freezed == releaseDate
          ? _value.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      available: null == available
          ? _value.available
          : available // ignore: cast_nullable_to_non_nullable
              as bool,
      spotifyId: freezed == spotifyId
          ? _value.spotifyId
          : spotifyId // ignore: cast_nullable_to_non_nullable
              as String?,
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String?,
      metadataSource: freezed == metadataSource
          ? _value.metadataSource
          : metadataSource // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TrackMetadataCopyWith<$Res>
    implements $TrackMetadataCopyWith<$Res> {
  factory _$$_TrackMetadataCopyWith(
          _$_TrackMetadata value, $Res Function(_$_TrackMetadata) then) =
      __$$_TrackMetadataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String? title,
      String? artistName,
      String? albumArtistName,
      String? albumArtistId,
      String? trackArtistId,
      String? albumName,
      String? albumId,
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
class __$$_TrackMetadataCopyWithImpl<$Res>
    extends _$TrackMetadataCopyWithImpl<$Res, _$_TrackMetadata>
    implements _$$_TrackMetadataCopyWith<$Res> {
  __$$_TrackMetadataCopyWithImpl(
      _$_TrackMetadata _value, $Res Function(_$_TrackMetadata) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = freezed,
    Object? artistName = freezed,
    Object? albumArtistName = freezed,
    Object? albumArtistId = freezed,
    Object? trackArtistId = freezed,
    Object? albumName = freezed,
    Object? albumId = freezed,
    Object? trackNo = freezed,
    Object? discNo = null,
    Object? description = freezed,
    Object? descriptionSource = freezed,
    Object? coverData = freezed,
    Object? uri = null,
    Object? coverBytes = freezed,
    Object? coverUri = freezed,
    Object? coverUriRemote = freezed,
    Object? coverSource = freezed,
    Object? duration = freezed,
    Object? year = freezed,
    Object? releaseDate = freezed,
    Object? available = null,
    Object? spotifyId = freezed,
    Object? source = freezed,
    Object? metadataSource = freezed,
  }) {
    return _then(_$_TrackMetadata(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      artistName: freezed == artistName
          ? _value.artistName
          : artistName // ignore: cast_nullable_to_non_nullable
              as String?,
      albumArtistName: freezed == albumArtistName
          ? _value.albumArtistName
          : albumArtistName // ignore: cast_nullable_to_non_nullable
              as String?,
      albumArtistId: freezed == albumArtistId
          ? _value.albumArtistId
          : albumArtistId // ignore: cast_nullable_to_non_nullable
              as String?,
      trackArtistId: freezed == trackArtistId
          ? _value.trackArtistId
          : trackArtistId // ignore: cast_nullable_to_non_nullable
              as String?,
      albumName: freezed == albumName
          ? _value.albumName
          : albumName // ignore: cast_nullable_to_non_nullable
              as String?,
      albumId: freezed == albumId
          ? _value.albumId
          : albumId // ignore: cast_nullable_to_non_nullable
              as String?,
      trackNo: freezed == trackNo
          ? _value.trackNo
          : trackNo // ignore: cast_nullable_to_non_nullable
              as int?,
      discNo: null == discNo
          ? _value.discNo
          : discNo // ignore: cast_nullable_to_non_nullable
              as int,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      descriptionSource: freezed == descriptionSource
          ? _value.descriptionSource
          : descriptionSource // ignore: cast_nullable_to_non_nullable
              as String?,
      coverData: freezed == coverData
          ? _value.coverData
          : coverData // ignore: cast_nullable_to_non_nullable
              as ImageDescriptor?,
      uri: null == uri
          ? _value.uri
          : uri // ignore: cast_nullable_to_non_nullable
              as Uri,
      coverBytes: freezed == coverBytes
          ? _value._coverBytes
          : coverBytes // ignore: cast_nullable_to_non_nullable
              as List<int>?,
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
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration?,
      year: freezed == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int?,
      releaseDate: freezed == releaseDate
          ? _value.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      available: null == available
          ? _value.available
          : available // ignore: cast_nullable_to_non_nullable
              as bool,
      spotifyId: freezed == spotifyId
          ? _value.spotifyId
          : spotifyId // ignore: cast_nullable_to_non_nullable
              as String?,
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
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
class _$_TrackMetadata extends _TrackMetadata with DiagnosticableTreeMixin {
  const _$_TrackMetadata(
      {this.id = "",
      this.title,
      this.artistName,
      this.albumArtistName,
      this.albumArtistId,
      this.trackArtistId,
      this.albumName,
      this.albumId,
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

  /// The database ID of the track.
  /// It is 7-20 characters long but is generally 13 characters long.
  /// These IDs are unique but not ordered.
  @override
  @JsonKey()
  final String id;

  /// The song's title.
  @override
  final String? title;

  /// The track artist's name.
  @override
  final String? artistName;

  /// The name of the artist of the album.
  @override
  final String? albumArtistName;

  /// The database ID of the album artist.
  @override
  final String? albumArtistId;

  /// The database ID of the track artist.
  /// This is usually the same as [albumArtistId].
  @override
  final String? trackArtistId;

  /// The album's name. Also used with [artistName] to look up the album in the database.
  @override
  final String? albumName;

  /// The album's database ID.
  @override
  final String? albumId;

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
    return 'TrackMetadata(id: $id, title: $title, artistName: $artistName, albumArtistName: $albumArtistName, albumArtistId: $albumArtistId, trackArtistId: $trackArtistId, albumName: $albumName, albumId: $albumId, trackNo: $trackNo, discNo: $discNo, description: $description, descriptionSource: $descriptionSource, coverData: $coverData, uri: $uri, coverBytes: $coverBytes, coverUri: $coverUri, coverUriRemote: $coverUriRemote, coverSource: $coverSource, duration: $duration, year: $year, releaseDate: $releaseDate, available: $available, spotifyId: $spotifyId, source: $source, metadataSource: $metadataSource)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TrackMetadata'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('artistName', artistName))
      ..add(DiagnosticsProperty('albumArtistName', albumArtistName))
      ..add(DiagnosticsProperty('albumArtistId', albumArtistId))
      ..add(DiagnosticsProperty('trackArtistId', trackArtistId))
      ..add(DiagnosticsProperty('albumName', albumName))
      ..add(DiagnosticsProperty('albumId', albumId))
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
            other is _$_TrackMetadata &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.artistName, artistName) ||
                other.artistName == artistName) &&
            (identical(other.albumArtistName, albumArtistName) ||
                other.albumArtistName == albumArtistName) &&
            (identical(other.albumArtistId, albumArtistId) ||
                other.albumArtistId == albumArtistId) &&
            (identical(other.trackArtistId, trackArtistId) ||
                other.trackArtistId == trackArtistId) &&
            (identical(other.albumName, albumName) ||
                other.albumName == albumName) &&
            (identical(other.albumId, albumId) || other.albumId == albumId) &&
            (identical(other.trackNo, trackNo) || other.trackNo == trackNo) &&
            (identical(other.discNo, discNo) || other.discNo == discNo) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.descriptionSource, descriptionSource) ||
                other.descriptionSource == descriptionSource) &&
            (identical(other.coverData, coverData) ||
                other.coverData == coverData) &&
            (identical(other.uri, uri) || other.uri == uri) &&
            const DeepCollectionEquality()
                .equals(other._coverBytes, _coverBytes) &&
            (identical(other.coverUri, coverUri) ||
                other.coverUri == coverUri) &&
            (identical(other.coverUriRemote, coverUriRemote) ||
                other.coverUriRemote == coverUriRemote) &&
            (identical(other.coverSource, coverSource) ||
                other.coverSource == coverSource) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.releaseDate, releaseDate) ||
                other.releaseDate == releaseDate) &&
            (identical(other.available, available) ||
                other.available == available) &&
            (identical(other.spotifyId, spotifyId) ||
                other.spotifyId == spotifyId) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.metadataSource, metadataSource) ||
                other.metadataSource == metadataSource));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        title,
        artistName,
        albumArtistName,
        albumArtistId,
        trackArtistId,
        albumName,
        albumId,
        trackNo,
        discNo,
        description,
        descriptionSource,
        coverData,
        uri,
        const DeepCollectionEquality().hash(_coverBytes),
        coverUri,
        coverUriRemote,
        coverSource,
        duration,
        year,
        releaseDate,
        available,
        spotifyId,
        source,
        metadataSource
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TrackMetadataCopyWith<_$_TrackMetadata> get copyWith =>
      __$$_TrackMetadataCopyWithImpl<_$_TrackMetadata>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TrackMetadataToJson(
      this,
    );
  }
}

abstract class _TrackMetadata extends TrackMetadata {
  const factory _TrackMetadata(
      {final String id,
      final String? title,
      final String? artistName,
      final String? albumArtistName,
      final String? albumArtistId,
      final String? trackArtistId,
      final String? albumName,
      final String? albumId,
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

  /// The database ID of the track.
  /// It is 7-20 characters long but is generally 13 characters long.
  /// These IDs are unique but not ordered.
  String get id;
  @override

  /// The song's title.
  String? get title;
  @override

  /// The track artist's name.
  String? get artistName;
  @override

  /// The name of the artist of the album.
  String? get albumArtistName;
  @override

  /// The database ID of the album artist.
  String? get albumArtistId;
  @override

  /// The database ID of the track artist.
  /// This is usually the same as [albumArtistId].
  String? get trackArtistId;
  @override

  /// The album's name. Also used with [artistName] to look up the album in the database.
  String? get albumName;
  @override

  /// The album's database ID.
  String? get albumId;
  @override

  /// The position of the track on the named album.
  int? get trackNo;
  @override
  int get discNo;
  @override

  /// Extra details about a given track, such as its origins and meaning.
  String? get description;
  @override

  /// Where the [description] came from.
  String? get descriptionSource;
  @override

  /// Holds the data for a cover image. **DO NOT** STORE THIS IN THE DATABASE!
//@Deprecated("Don't use this, just use coverBytes or coverFile instead!")
  @JsonKey(ignore: true)
  ImageDescriptor? get coverData;
  @override

  /// The URI to the track. Used by the library (database) to find the file
  /// when it's time to play it, and for fallback details.
  Uri get uri;
  @override

  /// The raw bytes of the cover image. **DO NOT** STORE THIS IN THE DATABASE!
  @JsonKey(ignore: true)
  List<int>? get coverBytes;
  @override

  /// The URI to the cover.
  Uri? get coverUri;
  @override

  /// A remote URI to the cover, such as from Spotify.
  /// Generally the URL used to download the cover from [coverSource].
  /// This is used with Discord RPC.
  Uri? get coverUriRemote;
  @override

  /// Can be "album" in addition to album cover sources.
  /// "album" here indicates the cover is the same as the album's.
  String? get coverSource;
  @override

  /// The track's duration.
  Duration? get duration;
  @override

  /// The year the track was released. Prefer to show [releaseDate] wherever given.
  int? get year;
  @override

  /// The release date of this track.
  DateTime? get releaseDate;
  @override
  bool get available;
  @override
  String? get spotifyId;
  @override

  /// The source of the audio for this track.
  /// This indicates where the user got a particular file, i.e. if it is
  /// ripped or bought from Bandcamp or Amazon.
  /// This can also be "spotify" or "youtube" to indicate the audio should be
  /// sourced from those services respectively (but it doesn't work yet).
  String? get source;
  @override
  String? get metadataSource;
  @override
  @JsonKey(ignore: true)
  _$$_TrackMetadataCopyWith<_$_TrackMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}
