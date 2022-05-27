import 'package:bodacious/drift/database.dart';
import 'package:drift/drift.dart' hide JsonKey;
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'artist_data.freezed.dart';
part 'artist_data.g.dart';

@freezed
class ArtistMetadata with _$ArtistMetadata implements Insertable<ArtistMetadata> {
  const ArtistMetadata._();
  const factory ArtistMetadata({
    /// The database ID of the artist.
    /// It is 7-20 characters long but is generally 10 characters long.
    /// These IDs are unique but not ordered.
    @Default("") String id,
    /// The artist's name.
    required String name,
    /// The URI to the artist icon.
    Uri? coverUri,
    /// A remote URI to the cover, such as from Spotify.
    /// Generally the URL used to download the cover from [coverSource].
    /// This is used with Discord RPC.
    Uri? coverUriRemote,
    /// Can be "spotify", "metadata", "neighbor", "mse", "lastfm", "genius", or other sources.
    String? coverSource,
    /// A biography for the artist.
    String? description,
    /// Where the biography came from.
    String? descriptionSource,
    /// The total number of albums by this artist (or albums present in the library).
    int? albumCount,
    /// The total number of tracks by this artist (or tracks present in the library).
    int? trackCount,
    String? spotifyId,
    String? metadataSource
  }) = _ArtistMetadata;

  factory ArtistMetadata.fromJson(Map<String, dynamic> json) => _$ArtistMetadataFromJson(json);
  
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    return ArtistTableCompanion(
      name: Value(name),
      coverUri: Value(coverUri),
      coverUriRemote: Value(coverUriRemote),
      coverSource: Value(coverSource),
      description: Value(description),
      descriptionSource: Value(descriptionSource),
      albumCount: Value(albumCount),
      trackCount: Value(trackCount),
      metadataSource: Value(metadataSource),
    ).toColumns(nullToAbsent);
  }
}