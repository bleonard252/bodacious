// stateful dialog widget with landscape and portrait versions

import 'package:bodacious/main.dart';
import 'package:flinq/flinq.dart';
import 'package:flutter/material.dart';

class CoverEditorDialog extends StatefulWidget {
  const CoverEditorDialog({super.key});

  @override
  State<CoverEditorDialog> createState() => _CoverEditorDialogState();

  /// Get the cover image URIs of each listed album.
  static Future<List<Uri>> getCoverFromAlbums(List<String> ids) async {
    final List<Uri> covers = [];
    for (final String id in ids) {
      final album = await db.tryGetAlbumById(id);
      if (album?.coverUri == null) continue;
      covers.add(album!.coverUri!);
    }
    return covers.notNull.distinct;
  }

  static Future<List<Uri>> getCoverFromTracks(List<String> ids) async {
    final List<Uri> covers = [];
    for (final String id in ids) {
      final track = await db.tryGetTrackById(id);
      if (track == null) continue;
      if (track.coverUri != null) {
        covers.add(track.coverUri!);
      } else if (track.albumId != null) {
        final album = await db.tryGetAlbumById(track.albumId!);
        if (album?.coverUri != null) covers.add(album!.coverUri!);
      }
    }
    return covers.notNull.distinct;
  }

  static Future<List<Uri>> getCoverFromArtists(List<String> ids) async {
    final List<Uri> covers = [];
    for (final String id in ids) {
      final artist = await db.tryGetArtistById(id);
      if (artist == null) continue;
      if (artist.coverUri != null) {
        covers.add(artist.coverUri!);
      } else {
        final albums = await (db.select(db.albumTable)..where((tbl) => tbl.artistId.equals(id))).get();
        for (final album in albums) {
          if (album.coverUri != null) {
            covers.add(album.coverUri!);
          }
        }
      }
    }
    return covers.notNull.distinct;
  }
}

class _CoverEditorDialogState extends State<CoverEditorDialog> {

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Edit Cover'),
      children: <Widget>[
        // landscape version
        if (MediaQuery.of(context).orientation == Orientation.landscape) Row(
          children: <Widget>[
            Expanded(
              child: buildCoverImage()
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  // cover image picker
                ],
              ),
            ),
          ],
        )
        // portrait version
         else Column(
          children: <Widget>[
            // cover image
            // cover image picker
          ],
        ),
        Row(
          children: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: const Text('Apply'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildCoverImage() {
    return Container(
      height: 200,
      width: 200,
      color: Colors.grey,
    );
  }
}