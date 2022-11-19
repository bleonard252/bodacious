import 'package:bodacious/drift/database.dart';
import 'package:bodacious/models/track_data.dart';
import 'package:drift/drift.dart' hide JsonKey;
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';

part 'playlist_data.freezed.dart';
part 'playlist_data.g.dart';

@freezed
class PlaylistMetadata with _$PlaylistMetadata implements Insertable<PlaylistMetadata> {
  const PlaylistMetadata._();
  const factory PlaylistMetadata({
    /// The database ID of the playlist.
    @Default("") String id,
    /// The user-defined name of this playlist.
    /// Defaults to the track, album, or artist used to create it.
    required String name,
    /// The URI to the cover. If not set, it defaults to:
    /// * no icon in the playlist view, AND
    /// * the first entry as the playlist icon in the list
    Uri? coverUri,
    /// The source of the cover. Likely "manual" or "album".
    /// Not used for any special purpose.
    String? coverSource,
    /// User-defined description of the playlist.
    String? description,
    /// The number of tracks in the playlist.
    int? trackCount,
    /// The URI to the XSPF file for this playlist.
    @JsonKey(ignore: true) Uri? uri,
    // /// The URI of each track in the playlist, in order, as strings.
    // /// Likely to be exactly how the <location/> contents appear.
    // @Default([]) List<String> trackList,
    /// Attach the XML document to the object to easily get additional metadata
    /// from the file itself.
    @JsonKey(ignore: true) XmlDocument? document,
    /// The playlist's declared creation date.
    DateTime? createdAt,
    /// The index of the playlist in the Library menu.
    int? index,
  }) = _PlaylistMetadata;

  factory PlaylistMetadata.fromJson(Map<String, dynamic> json) => _$PlaylistMetadataFromJson(json);
  
  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    return PlaylistTableCompanion(
      id: Value(id),
      name: Value(name),
      coverUri: Value(coverUri),
      coverSource: Value(coverSource),
      description: Value(description),
      trackCount: Value(trackCount),
      createdAt: Value.ofNullable(createdAt),
      index: Value(index),
    ).toColumns(nullToAbsent);
  }

  // @override
  // Map<String, Expression> toColumns(bool nullToAbsent) {
  //   return PlaylistTableCompanion(
  //     id: Value(id),
  //     name: Value(name),
  //     coverUri: Value(coverUri),
  //     description: Value(description),
  //     uri: Value(uri),
  //     tracks: Value(tracks)
  //   ).toColumns(nullToAbsent);
  // }

  /// Metadata for the tracks.
  /// This is generally populated with basic tracks
  //get List<PartialTrackMetadata> tracks = trackList.map((e) => PartialTrackMetadata(uri: e));

  // factory PlaylistMetadata.fromXspf(XmlDocument xml, Uri uri) {
  //   if (xml.rootElement.name.local != "playlist" || xml.rootElement.namespaceUri != "http://xspf.org/ns/0") {
  //     throw UnsupportedError("This is not a playlist!");
  //   }
  //   if (xml.rootElement.getElement("trackList") == null) {
  //     throw UnsupportedError("Tracklists are required for playlists.");
  //   }
  //   final trackList = <String>[];
  //   for (final element in xml.rootElement.getElement("trackList")!.childElements) {
  //     final track = element.getElement("location");
  //     if (track != null) trackList.add(track.innerText);
  //   }
  //   return PlaylistMetadata(
  //     name: xml.rootElement.getElement("title")?.innerText
  //     ?? xml.rootElement.getElement("trackList")?.firstElementChild?.getElement("title")?.innerText
  //     ?? uri.pathSegments.last,
  //     uri: uri,
  //     coverUri: xml.rootElement.getElement("image") == null ? null : Uri.tryParse(xml.rootElement.getElement("image")!.innerText),
  //     description: xml.rootElement.getElement("annotation")?.innerText,
  //     trackList: trackList,
  //     createdAt: xml.rootElement.getElement("date") == null ? null : DateTime.tryParse(xml.rootElement.getElement("date")!.innerText)
  //   );
    //throw UnimplementedError("not yet");
  //}

  // PlaylistMetadataWithTracks withTracks([XmlDocument? document]) {
  //   final xml = document ?? this.document;
  //   if (xml == null) throw ArgumentError("An XMLDocument must be specified via PlaylistMetadata.document or the document parameter.");
  //   final tracks = <PartialTrackMetadata>[];
  //   for (final XmlElement element in xml.rootElement.getElement("trackList")!.childElements) {
  //     final uriTag = element.getElement("location");
  //     if (uriTag == null) continue;
  //     //if (uriTag != null) tracks.add(PartialTrackMetadata(uri: Uri.parse(track)));
  //     final title = element.getElement("title")?.innerText;
  //     final artist = element.getElement("creator")?.innerText;
  //     final album = element.getElement("album")?.innerText;
  //     final durationTag = element.getElement("duration");
  //     final imageTag = element.getElement("image");
  //     tracks.add(PartialTrackMetadata(
  //       uri: Uri.parse(uriTag.innerText),
  //       title: title,
  //       albumName: album,
  //       artistName: artist,
  //       coverUri: imageTag == null ? null : Uri.parse(imageTag.innerText),
  //       duration: durationTag == null ? null : Duration(milliseconds: int.parse(durationTag.innerText))
  //     ));
  //   }
  //   return PlaylistMetadataWithTracks(this, tracks);
  // }
}

// class PlaylistMetadataWithTracks {
//   final PlaylistMetadata metadata;
//   late List<PartialTrackMetadata> tracks;
//   PlaylistMetadataWithTracks(this.metadata, this.tracks);

//   static defaultTracks(PlaylistMetadata metadata) => metadata.trackList.map((e) => PartialTrackMetadata(uri: Uri.parse(e))).toList();

//   /// Update the track metadata.
//   withTracks(List<PartialTrackMetadata> tracks) => PlaylistMetadataWithTracks(metadata, tracks);
// }

class PartialTrackMetadata {
  final String? title;
  final String? artistName;
  final String? albumName;
  final Uri? coverUri;
  final Duration? duration;
  final Uri uri;

  const PartialTrackMetadata({
    required this.uri,
    this.title,
    this.artistName,
    this.albumName,
    this.coverUri,
    this.duration
  });

  TrackMetadata toTrackMetadata({
    required String id,
    required String artistId,
    required String albumId,
    int? index,
  }) => TrackMetadata(
    id: id,
    uri: uri,
    coverUri: coverUri,
    coverSource: "playlist",
    trackArtistId: artistId,
    albumArtistId: artistId,
    albumArtistName: artistName,
    artistName: artistName,
    available: true,
    duration: duration,
    albumId: albumId,
    albumName: albumName,
    source: "playlist",
    trackNo: index,
    metadataSource: "playlist",
  );
}