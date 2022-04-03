import 'dart:io';

import 'package:bodacious/main.dart';
import 'package:bodacious/models/track_data.dart';
import 'package:drift/drift.dart';
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../widgets/cover_placeholder.dart';

class SongLibraryList extends ConsumerWidget {
  const SongLibraryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<void>(
      builder: (context, snapshot) {
        return FutureBuilder<int>(
          future: (db.selectOnly(db.trackTable)..addColumns([db.trackTable.title])).get().then((value) => value.length),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) return Container();
            return ListView.builder(
              itemBuilder: (context, index) => FutureBuilder<TrackMetadata>(
                future: (
                  db.select(db.trackTable)
                  ..orderBy([
                    (tbl) => OrderingTerm.asc(tbl.title)
                  ])
                  ..limit(1, offset: index)
                ).getSingle(),
                builder: (context, snapshot) {
                  final track = snapshot.data ?? TrackMetadata(uri: Uri(), title: "Loading...");
                  return SizedBox(
                    height: 72.0,
                    child: ListTile(
                      leading: track.coverBytes != null || track.coverUri?.scheme == "file" ? Image(
                        image: (track.coverUri?.scheme == "file" ? FileImage(File.fromUri(track.coverUri!))
                          : NetworkImage(track.coverUri.toString())) as ImageProvider,
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                        errorBuilder: (context, e, s) => const CoverPlaceholder(size: 48, iconSize: 24),
                      ) : const CoverPlaceholder(size: 48, iconSize: 24),
                      title: Text(track.title ?? (track.uri.pathSegments.isEmpty ? "Unknown track" : track.uri.pathSegments.last)),
                      subtitle: track.artistName?.isEmpty == false ? Text(track.artistName!) : null,
                      onTap: () {
                        player.prepareFromTrackMetadata(track);
                        //ref.read(nowPlayingProvider.notifier).changeTrack(track);
                        player.play();
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