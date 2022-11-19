
import 'package:bodacious/main.dart';
import 'package:bodacious/models/track_data.dart';
import 'package:bodacious/widgets/item/song.dart';
import 'package:drift/drift.dart' hide Column;
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


class SongLibraryList extends ConsumerWidget {
  const SongLibraryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<int>(
      future: (db.selectOnly(db.trackTable)..addColumns([db.trackTable.title])).get().then((value) => value.length),
      builder: (context, snapshot) {
        return CustomScrollView(
          slivers: [
            if (snapshot.hasError) SliverFillRemaining(child: Center(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(MdiIcons.alertCircle, color: Colors.red),
                  ),
                  Text(snapshot.error.toString(), textAlign: TextAlign.center, style: const TextStyle(color: Colors.red))
                ]
              )
            ))
            else if (!snapshot.hasData) SliverToBoxAdapter(child: Container())
            else if (snapshot.data == 0) SliverFillRemaining(
              child: Center(
                child: Material(
                  type: MaterialType.card,
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(MdiIcons.ghost, color: Colors.lightBlue),
                        ),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 300),
                          child: const Text("No songs found. Add a music folder in Settings > Library.", textAlign: TextAlign.center)
                        )
                      ]
                    ),
                  )
                )
              )
            )
            else SliverList(
              //itemExtent: 72.0,
              delegate: SliverChildBuilderDelegate(
                (context, index) => FutureBuilder<TrackMetadata>(
                  future: (
                    db.select(db.trackTable)
                    ..orderBy([
                      (tbl) => OrderingTerm.asc(tbl.title)
                    ])
                    ..limit(1, offset: index)
                  ).getSingle(),
                  builder: (context, snapshot) {
                    final track = snapshot.data ?? TrackMetadata(uri: Uri(), title: "Loading...", artistName: "");
                    return SongWidget(
                      track,
                      selected: ref.watch(nowPlayingProvider).value?.uri == track.uri,
                      onTap: () async {
                        //player.prepareFromTrackMetadata(track);
                        player.stop();
                        await player.updateQueue([snapshot.data!.asMediaItem()], 0);
                        await player.play();
                      },
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
}