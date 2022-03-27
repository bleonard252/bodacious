import 'package:flutter/foundation.dart';

import 'dart:ui' show ImageDescriptor;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'track_data.freezed.dart';

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
    ImageDescriptor? coverData,
    /// The raw bytes of the cover image.
    List<int>? coverBytes
  }) = _TrackMetadata;
}