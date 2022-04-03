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
    /// The artist's name.
    required String name,
    /// The URI to the artist icon.
    Uri? coverUri,
    /// The total number of albums by this artist (or albums present in the library).
    int? albumCount,
    /// The total number of tracks by this artist (or tracks present in the library).
    int? trackCount,
  }) = _ArtistMetadata;

  factory ArtistMetadata.fromJson(Map<String, dynamic> json) => _$ArtistMetadataFromJson(json);
  
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    return ArtistTableCompanion(
      name: Value(name),
      coverUri: Value(coverUri),
      albumCount: Value(albumCount),
      trackCount: Value(trackCount)
    ).toColumns(nullToAbsent);
  }
}