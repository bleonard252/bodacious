import 'package:audio_service/audio_service.dart';
import 'package:flutter/foundation.dart';

import 'dart:ui' show ImageDescriptor;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'track_data.freezed.dart';
part 'track_data.g.dart';

@freezed
class TrackMetadata with _$TrackMetadata {
  const TrackMetadata._();
  factory TrackMetadata.empty() => TrackMetadata(uri: Uri());
  const factory TrackMetadata({
    /// The song's title.
    String? title,
    /// The artist's name. Also used to look up the artist in the database.
    String? artistName,
    /// The album's name. Also used with [artistName] to look up the album in the database.
    String? albumName,
    /// The position of the track on the named album.
    int? trackNo,
    @Default(0) int discNo,
    /// Holds the data for a cover image. **DO NOT** STORE THIS IN THE DATABASE!
    //@Deprecated("Don't use this, just use coverBytes or coverFile instead!")
    @JsonKey(ignore: true) ImageDescriptor? coverData,
    /// The URI to the track. Used by the library (database) to find the file
    /// when it's time to play it, and for fallback details.
    required Uri uri,
    /// The raw bytes of the cover image. **DO NOT** STORE THIS IN THE DATABASE!
    @JsonKey(ignore: true) List<int>? coverBytes,
    /// The URI to the cover.
    Uri? coverUri,
    /// The track's duration.
    Duration? duration
  }) = _TrackMetadata;

  factory TrackMetadata.fromJson(Map<String, dynamic> json) => _$TrackMetadataFromJson(json);

  _BodaciousMediaItem asMediaItem() => _BodaciousMediaItem(this);
}

class _BodaciousMediaItem implements MediaItem {
  final TrackMetadata parent;
  _BodaciousMediaItem(this.parent);

  @override
  String? get album => parent.albumName;
  @override
  Uri? get artUri => parent.coverUri;

  @override
  String? get artist => parent.artistName;

  @override
  MediaItemCopyWith get copyWith => throw UnimplementedError();

  @override
  String? get displayDescription => null;

  @override
  String? get displaySubtitle => null;

  @override
  String? get displayTitle => null;

  @override
  Duration? get duration => parent.duration;

  @override
  Map<String, dynamic>? get extras => null;

  @override
  String? get genre => null; //for now

  @override
  String get id => parent.uri.toString();

  @override
  bool? get playable => true;

  @override
  Rating? get rating => null;

  @override
  String get title => parent.title ?? parent.uri.pathSegments.lastOrNull ?? "Bodacious";
    
}