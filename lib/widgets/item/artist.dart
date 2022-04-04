import 'dart:io';

import 'package:bodacious/models/album_data.dart';
import 'package:bodacious/models/artist_data.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../main.dart';
import '../cover_placeholder.dart';

class ArtistWidget extends ConsumerWidget {
  final ArtistMetadata artist;
  final Function()? onTap;
  final bool hideDetails;
  const ArtistWidget(this.artist, {
    Key? key,
    this.onTap,
    this.hideDetails = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: ClipOval(child: FutureBuilder<AlbumMetadata?>(
        future: (
          db.select(db.albumTable)
          //..addColumns([db.albumTable.coverUri, db.albumTable.artistName, db.albumTable.releaseDate, db.albumTable.year])
          ..where((tbl) => tbl.artistName.equals(artist.name))
          ..orderBy([
            (tbl) => OrderingTerm.desc(tbl.releaseDate),
            (tbl) => OrderingTerm.desc(tbl.year),
          ])
          ..limit(1)
        ).getSingleOrNull(),
        // albumStore.findFirst(db, finder: Finder(
        //   filter: Filter.matches('artistName', artist.name),
        //   sortOrders: [SortOrder('releaseDate', false), SortOrder('year', false)]
        // )),
        builder: (context, snapshot) {
          //final album = AlbumMetadata.fromJson((snapshot.data as dynamic)?.value ?? {"name": "Unknown album", "artistName": "Unknown artist"});
          final coverUri = snapshot.data?.coverUri;
          return coverUri?.scheme == "file" ? Image(
            image: (coverUri?.scheme == "file" ? FileImage(File.fromUri(coverUri!))
              : NetworkImage(coverUri.toString())) as ImageProvider,
            width: 48,
            height: 48,
            fit: BoxFit.cover,
            errorBuilder: (context, e, s) => const CoverPlaceholder(size: 48, iconSize: 24),
          ): const CoverPlaceholder(size: 48, iconSize: 24);
        })
      ),
      title: Text.rich(TextSpan(children: [
        // WidgetSpan(
        //   child: Icon(MdiIcons.album, size: Theme.of(context).textTheme.subtitle1?.fontSize),
        //   alignment: PlaceholderAlignment.middle
        // ),
        // const WidgetSpan(child: SizedBox(width: 6)),
        TextSpan(text: artist.name)
      ])),
      subtitle: Text.rich(TextSpan(
        children: [
          // const WidgetSpan(child: Icon(MdiIcons.spotify)),
          // const WidgetSpan(child: SizedBox(width: 6)),
          if (artist.albumCount != null && !hideDetails) TextSpan(text: artist.albumCount!.toString()+" album"+(artist.albumCount!=1?"s":""), style: const TextStyle(fontStyle: FontStyle.italic))
        ],
      )),
      onTap: onTap ?? () {
        context.go("/library/artists/"+Uri.encodeComponent(artist.name), extra: artist);
      },
    );
  }
}