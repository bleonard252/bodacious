import 'dart:convert';
import 'dart:io';

import 'package:bodacious/main.dart';
import 'package:bodacious/models/album_data.dart';
import 'package:bodacious/models/artist_data.dart';
import 'package:drift/drift.dart';
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../widgets/cover_placeholder.dart';

class ArtistLibraryList extends ConsumerWidget {
  const ArtistLibraryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<void>(
      stream: db.select(db.artistTable).watch(),
      builder: (context, _) {
        return FutureBuilder<int>(
          future: (db.selectOnly(db.artistTable)..addColumns([db.artistTable.name])).get().then((value) => value.length),
          builder: (context, snapshot) {
            return CustomScrollView(
              slivers: [
                if (snapshot.connectionState != ConnectionState.done) SliverToBoxAdapter(child: Container())
                else SliverList(
                  //itemExtent: 72.0,
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => FutureBuilder<ArtistMetadata>(
                      future: (
                        db.select(db.artistTable)
                        ..orderBy([
                          (tbl) => OrderingTerm.asc(tbl.name)
                        ])
                        ..limit(1, offset: index)
                      ).getSingle(),
                      builder: (context, snapshot) {
                        final artist = snapshot.data ?? const ArtistMetadata(name: "Loading...");
                        return ListTile(
                          leading: ClipOval(child: FutureBuilder<TypedResult?>(
                            future: (
                              db.selectOnly(db.albumTable)
                              ..addColumns([db.albumTable.coverUri])
                              ..where(db.albumTable.artistName.equals(artist.name))
                              ..orderBy([
                                OrderingTerm.desc(db.albumTable.releaseDate),
                                OrderingTerm.desc(db.albumTable.year),
                              ])
                              ..limit(1)
                            ).getSingleOrNull(),
                            // albumStore.findFirst(db, finder: Finder(
                            //   filter: Filter.matches('artistName', artist.name),
                            //   sortOrders: [SortOrder('releaseDate', false), SortOrder('year', false)]
                            // )),
                            builder: (context, snapshot) {
                              //final album = AlbumMetadata.fromJson((snapshot.data as dynamic)?.value ?? {"name": "Unknown album", "artistName": "Unknown artist"});
                              final coverUri = snapshot.data?.readTableOrNull(db.albumTable)?.coverUri;
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
                              if (artist.albumCount != null) TextSpan(text: artist.albumCount!.toString()+" album"+(artist.albumCount!=1?"s":""), style: const TextStyle(fontStyle: FontStyle.italic))
                            ],
                          )),
                          onTap: () {
                            // TODO: open the details page, show the albums by the artist
                          },
                        );
                      },
                    ),
                    childCount: snapshot.data ?? 0
                  )
                ),
              ],
            );
          }
        );
      }
    );
  }
}