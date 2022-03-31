import 'dart:io';

import 'package:bodacious/main.dart';
import 'package:bodacious/models/album_data.dart';
import 'package:bodacious/src/library/init_db.dart';
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sembast/sembast.dart';

import '../../../widgets/cover_placeholder.dart';

class AlbumLibraryList extends ConsumerWidget {
  const AlbumLibraryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<void>(
      builder: (context, snapshot) {
        return FutureBuilder<int>(
          future: albumStore.count(db),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) return Container();
            return ListView.builder(
              itemBuilder: (context, index) => FutureBuilder<Map<String, dynamic>?>(
                future: albumStore.findFirst(db, finder: Finder(offset: index, limit: 1, sortOrders: [SortOrder('year'), SortOrder('name')])).then((value) => value?.value),
                builder: (context, snapshot) {
                  final album = AlbumMetadata.fromJson(snapshot.data ?? {"name": "Unknown album", "artistName": "Unknown artist"});
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
                        TextSpan(text: album.artistName)
                      ])),
                      onTap: () {
                        // TODO: open the details page, show the songs on the album
                      },
                    ),
                  );
                },
              ),
              itemCount: snapshot.data
            );
          }
        );
      }
    );
  }
}