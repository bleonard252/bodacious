import 'dart:io';

import 'package:bodacious/models/track_data.dart';
import 'package:mime/mime.dart';

final fileExtensionRegex = RegExp(r'\.[a-zA-Z0-9]{1,5}$');

TrackMetadata inferMetadataFromContext(Uri uri) {
  String? expectingTitle, expectingAlbum, expectingArtist;
  int? expectingTrackNo;
  final pathIterator = uri.pathSegments.reversed.iterator;
  // == Last path segment
  var isOk = pathIterator.moveNext();
  assert(isOk, "There is no case where this should be called on an empty path.");
  var split = pathIterator.current.replaceFirst(fileExtensionRegex, "").split(" - ");
  expectingTitle = pathIterator.current.replaceFirst(fileExtensionRegex, "");
  if (split.length > 4) {
    return TrackMetadata(
      uri: uri,
      title: "[E1] "+expectingTitle,
      // [E1] indicates that the track name had too many segments and is
      // currently unsupported.
    );
  } else if (split.length == 4) {
    return TrackMetadata(
      uri: uri,
      title: split[3],
      trackNo: int.tryParse(split[2]),
      albumName: split[1],
      artistName: split[0],
    );
  } else if (split.length == 3) {
      final _title = RegExp(r'^([0-9]{1,})[- .]?[ ]?').matchAsPrefix(split[2]);
      expectingTitle = _title == null ? split[2] : split[2].substring(_title.end);
      expectingTrackNo = int.tryParse(_title?.group(1) ?? "");
      return TrackMetadata(
        uri: uri,
        title: expectingTitle,
        trackNo: expectingTrackNo,
        albumName: split[1],
        artistName: split[0]
      );
  } else if (split.length == 2) {
    // final _title = RegExp(r'^([0-9]{1,})[ ]?[- .]?[ ]?').matchAsPrefix(split[1]);
    // expectingTitle = _title == null ? split[1] : split[1].substring(_title.end).replaceFirst(fileExtensionRegex, "");
    // expectingTrackNo = int.tryParse(_title?.group(1) ?? "");
    if (RegExp(r'^([0-9]{1,})$').hasMatch(split[0])) {
      expectingTrackNo = int.tryParse(split[0]);
      expectingTitle = split[1];
    }
    if (expectingTrackNo == null) {
      return TrackMetadata(
        uri: uri,
        title: expectingTitle,
        trackNo: expectingTrackNo,
        artistName: split[0]
      );
    }
  } else {
    final _title = RegExp(r'^([0-9]{1,})[ ]?[- .]?[ ]?').matchAsPrefix(split[0]);
    expectingTitle = _title == null ? split[0] : split[0].substring(_title.end).replaceFirst(fileExtensionRegex, "");
    expectingTrackNo = int.tryParse(_title?.group(1) ?? "");
  }
  // == Second-to-last path segment
  isOk = pathIterator.moveNext();
  if (!isOk) { // Ran out of segments for some reason? Okay, just use what we got.
    return TrackMetadata(
      uri: uri,
      title: expectingTitle,
    );
  }
  split = pathIterator.current.split(" - ");
  if (split.length > 2) {
    return TrackMetadata(
      uri: uri,
      title: expectingTitle,
      trackNo: expectingTrackNo,
      albumName: "[E1] "+pathIterator.current
    );
  } else if (split.length == 2) {
    return TrackMetadata(
      uri: uri,
      title: expectingTitle,
      trackNo: expectingTrackNo,
      albumName: split[1],
      artistName: split[0]
    );
  } else {expectingAlbum = pathIterator.current;}
  // == Third-to-last path segment (should be Artist name)
  isOk = pathIterator.moveNext();
  if (!isOk) { // Ran out of segments for some reason? Okay, just use what we got.
    return TrackMetadata(
      uri: uri,
      title: expectingTitle,
      trackNo: expectingTrackNo,
      albumName: expectingAlbum,
    );
  }
  split = pathIterator.current.split(" - ");
  if (split.length > 1) {
    return TrackMetadata(
      uri: uri,
      title: expectingTitle,
      trackNo: expectingTrackNo,
      albumName: expectingAlbum,
      artistName: "[E1] "+pathIterator.current
    );
  } else {
    expectingArtist = pathIterator.current;
  }
  return TrackMetadata(
    uri: uri,
    title: expectingTitle,
    trackNo: expectingTrackNo,
    albumName: expectingAlbum,
    artistName: expectingArtist
  );
  // Genre may be in yet another above folder,
  // but please check the user's preferences for that
  // as it may not be a genre at all!
  // TODO: stop at library boundaries, too
}

Future<FileSystemEntity?> inferCoverFile(File file) async {
  try {
    return await file.parent.list().timeout(const Duration(seconds: 2), onTimeout: (stream) => stream.close())
      .firstWhere((element) =>
        (
          element.uri.pathSegments.last.toLowerCase().startsWith("cover.")
          || element.uri.pathSegments.last.toLowerCase().startsWith("folder.")
          || element.uri.pathSegments.last.toLowerCase().startsWith("album.")
          || element.uri.pathSegments.last.toLowerCase().startsWith("front.")
        ) && (MimeTypeResolver().lookup(element.uri.pathSegments.last)?.startsWith("image/") ?? false)
      );
  } catch(_) {
    return null;
  }
}