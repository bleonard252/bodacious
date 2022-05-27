import 'package:bodacious/drift/database.dart';
import 'package:drift/drift.dart' hide JsonKey;
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'album_data.freezed.dart';
part 'album_data.g.dart';


@freezed
class AlbumMetadata with _$AlbumMetadata implements Insertable<AlbumMetadata> {
  const AlbumMetadata._();
  const factory AlbumMetadata({
    /// The database ID of the album.
    /// It is 7-20 characters long but is generally 12 characters long.
    /// These IDs are unique but not ordered.
    @Default("") String id,
    /// The artist's name, used to group this album and make it unique.
    required String artistName,
    @Default("") String artistId,
    /// The album's name.
    required String name,
    /// The URI to the album cover.
    Uri? coverUri,
    Uri? coverUriRemote,
    String? coverSource,
    /// Extra details about the album.
    String? description,
    /// Where the [description] came from.
    String? descriptionSource,
    /// The total number of tracks on this album (or tracks present in the library).
    int? trackCount,
    /// The year the album was released. Prefer to show [releaseDate] wherever given.
    int? year,
    /// The release date of this album.
    DateTime? releaseDate,
    String? spotifyId,
    String? metadataSource
  }) = _AlbumMetadata;

  factory AlbumMetadata.fromJson(Map<String, dynamic> json) => _$AlbumMetadataFromJson(json);
  
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    return AlbumTableCompanion(
      artistName: Value(artistName),
      name: Value(name),
      coverUri: Value(coverUri),
      coverUriRemote: Value(coverUriRemote),
      coverSource: Value(coverSource),
      trackCount: Value(trackCount),
      year: Value(year),
      releaseDate: Value(releaseDate),
      metadataSource: Value(metadataSource),
    ).toColumns(nullToAbsent);
  }
}