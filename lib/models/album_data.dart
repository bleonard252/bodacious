import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'album_data.freezed.dart';
part 'album_data.g.dart';


@freezed
class AlbumMetadata with _$AlbumMetadata {
  const factory AlbumMetadata({
    /// The artist's name, used to group this album and make it unique.
    required String artistName,
    /// The album's name.
    required String name,
    /// The URI to the album cover.
    Uri? coverUri,
    /// The total number of tracks on this album (or tracks present in the library).
    int? trackCount,
    /// The year the album was released. Prefer to show [releaseDate] wherever given.
    int? year,
    /// The release date of this album.
    DateTime? releaseDate,
  }) = _AlbumMetadata;

  factory AlbumMetadata.fromJson(Map<String, dynamic> json) => _$AlbumMetadataFromJson(json);
}