import 'dart:io';

import 'package:bodacious/models/album_data.dart';
import 'package:bodacious/models/artist_data.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../main.dart';
import '../cover_placeholder.dart';

class ArtistWidget extends ConsumerWidget {
  final ArtistMetadata artist;
  final Function()? onTap;
  final bool hideDetails;
  final InlineSpan? subtitle;
  const ArtistWidget(this.artist, {
    Key? key,
    this.onTap,
    this.hideDetails = false,
    this.subtitle
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _subtitle = buildChildren();
    return SizedBox(
      height: _subtitle.isEmpty ? 64.0 : null,
      child: ListTile(
        contentPadding: _subtitle.isEmpty ? const EdgeInsets.symmetric(horizontal: 16, vertical: 8) : null,
        leading: ClipOval(child: artist.coverUri != null ? Image(
          image: (artist.coverUri?.scheme == "file" ? FileImage(File.fromUri(artist.coverUri!))
            : NetworkImage(artist.coverUri.toString())) as ImageProvider,
          width: 48,
          height: 48,
          fit: BoxFit.cover,
          errorBuilder: (context, e, s) => const CoverPlaceholder(size: 48, iconSize: 24),
        ) : FutureBuilder<AlbumMetadata?>(
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
        subtitle: _subtitle.isEmpty ? null : Text.rich(TextSpan(children: _subtitle)),
        onTap: onTap ?? () {
          context.go("/library/${artist.id}", extra: artist);
        },
      ),
    );
  }

  List<InlineSpan> buildChildren() {
    return [
      // const WidgetSpan(child: Icon(MdiIcons.spotify)),
      // const WidgetSpan(child: SizedBox(width: 6)),
      if (subtitle != null) subtitle!,
      if (artist.albumCount != null && !hideDetails) TextSpan(text: artist.albumCount!.toString()+" album"+(artist.albumCount!=1?"s":""), style: const TextStyle(fontStyle: FontStyle.italic))
    ];
  }
}