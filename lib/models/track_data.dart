import 'package:flutter/foundation.dart';

import 'dart:ui' show ImageDescriptor;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'track_data.freezed.dart';
part 'track_data.g.dart';

@freezed
class TrackMetadata with _$TrackMetadata {
  const TrackMetadata._();
  const factory TrackMetadata({
    /// The song's title.
    String? title,
    /// The artist's name. Also used to look up the artist in the database.
    String? artistName,
    /// The album's name. Also used with [artistName] to look up the album in the database.
    String? albumName,
    /// Holds the data for a cover image. **DO NOT** STORE THIS IN THE DATABASE!
    //@Deprecated("Don't use this, just use coverBytes or coverFile instead!")
    @JsonKey(ignore: true) ImageDescriptor? coverData,
    /// The URI to the track. Used by the library (database) to find the file
    /// when it's time to play it, and for fallback details.
    Uri? uri,
    /// The raw bytes of the cover image. **DO NOT** STORE THIS IN THE DATABASE!
    @JsonKey(ignore: true) List<int>? coverBytes,
    /// The URI to the cover.
    Uri? coverUri
  }) = _TrackMetadata;

  factory TrackMetadata.fromJson(Map<String, dynamic> json) => _$TrackMetadataFromJson(json);
}