// ignore: unused_import
import 'package:flutter/foundation.dart';
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
    /// Not really sure what this will be yet but it'll somehow hold the data for the cover
    /// but it won't be stored in the database (loaded from tags or a file)
    dynamic coverData
  }) = _TrackMetadata;
}