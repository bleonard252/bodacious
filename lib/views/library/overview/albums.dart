import 'dart:io';

import 'package:bodacious/main.dart';
import 'package:bodacious/models/album_data.dart';
import 'package:drift/drift.dart';
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../widgets/cover_placeholder.dart';

class AlbumLibraryList extends ConsumerWidget {
  const AlbumLibraryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<void>(
      stream: db.select(db.albumTable).watch(),
      builder: (context, _) {
        return FutureBuilder<int>(
          future: (db.selectOnly(db.albumTable)..addColumns([db.albumTable.name])).get().then((value) => value.length),
          builder: (context, snapshot) {
            return CustomScrollView(
              slivers: [
                if (snapshot.connectionState != ConnectionState.done) SliverToBoxAdapter(child: Container())
                else SliverList(
                  //itemExtent: 72.0,
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => FutureBuilder<AlbumMetadata>(
                      future: (
                        db.select(db.albumTable)
                        ..orderBy([
                          (tbl) => OrderingTerm.desc(tbl.year),
                          (tbl) => OrderingTerm.asc(tbl.name)
                        ])
                        ..limit(1, offset: index)
                      ).getSingle(),
                      builder: (context, snapshot) {
                        final album = snapshot.data ?? const AlbumMetadata(artistName: "", name: "Loading...");
                        return SizedBox(
                          height: 72.0,
                          child: ListTile(
                            leading: album.coverUri?.scheme == "file" ? Image(
                              image: (album.coverUri?.scheme == "file" ? FileImage(File.fromUri(album.coverUri!))
                                : NetworkImage(album.coverUri.toString())) as ImageProvider,
                              width: 48,
                              height: 48,
                              fit: BoxFit.cover,
                              errorBuilder: (context, e, s) => const CoverPlaceholder(size: 48, iconSize: 24),
                            ) : const CoverPlaceholder(size: 48, iconSize: 24),
                            title: Text.rich(TextSpan(children: [
                              WidgetSpan(
                                child: Icon(MdiIcons.album, size: Theme.of(context).textTheme.subtitle1?.fontSize),
                                alignment: PlaceholderAlignment.middle
                              ),
                              const WidgetSpan(child: SizedBox(width: 6)),
                              TextSpan(text: album.name)
                            ])),
                            subtitle: Text.rich(TextSpan(children: [
                              // const WidgetSpan(child: Icon(MdiIcons.spotify)),
                              // const WidgetSpan(child: SizedBox(width: 6)),
                              TextSpan(text: album.artistName),
                              if (album.year != null) TextSpan(text: album.year.toString())
                            ])),
                            onTap: () {
                              context.go("/library/albums/"+Uri.encodeComponent(album.artistName)+"/"+Uri.encodeComponent(album.name), extra: album);
                            },
                          ),
                        );
                      },
                    ),
                    childCount: snapshot.data ?? 0
                  )
                )
              ]
            );
          }
        );
      }
    );
  }
}