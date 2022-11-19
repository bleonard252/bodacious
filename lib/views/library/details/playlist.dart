import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:bodacious/drift/database.dart';
import 'package:bodacious/main.dart';
import 'package:bodacious/models/album_data.dart';
import 'package:bodacious/models/artist_data.dart';
import 'package:bodacious/models/playlist_data.dart';
import 'package:bodacious/models/track_data.dart';
import 'package:bodacious/widgets/cover_placeholder.dart';
import 'package:bodacious/widgets/frame_size.dart';
import 'package:bodacious/widgets/item/artist.dart';
import 'package:bodacious/widgets/item/song.dart';
import 'package:drift/drift.dart' hide Column, Table;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PlaylistDetailsWrapper extends StatelessWidget {
  final String id;
  final dynamic data;
  const PlaylistDetailsWrapper({ Key? key, this.data, required this.id }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PlaylistMetadata?>(
      initialData: data is PlaylistMetadata ? data : null,
      future: data is PlaylistMetadata ? null : (db.select(db.playlistTable)
      ..where((tbl) => tbl.id.equals(id))
      ).getSingleOrNull(),
      builder: (context, snapshot) =>
      snapshot.hasError ? Material(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(MdiIcons.alertCircle, color: Colors.red),
              ),
              Text(snapshot.error.toString(), textAlign: TextAlign.center, style: const TextStyle(color: Colors.red))
            ]
          )
        ),
      ) : snapshot.hasData ? PlaylistDetailsView(playlist: snapshot.data!)
      : snapshot.connectionState == ConnectionState.done ? Material(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(MdiIcons.ghost, color: Colors.blue),
              ),
              Text("No playlist found", textAlign: TextAlign.center, style: TextStyle(color: Colors.blue))
            ]
          )
        )
      ) : const Material(
        color: Colors.black,
        child: Center(child: CircularProgressIndicator(value: null))
      )
    );
  }
}

class PlaylistDetailsView extends StatefulWidget {
  final PlaylistMetadata playlist;
  const PlaylistDetailsView({ Key? key, required this.playlist }) : super(key: key);

  @override
  State<PlaylistDetailsView> createState() => PlaylistDetailsViewState();
}

class PlaylistDetailsViewState extends State<PlaylistDetailsView> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    double _lastOffset = 0.0;
    controller.addListener(() {
      if (controller.positions.isEmpty) return;
      if (_lastOffset < 256 && controller.offset >= 256) {
        setState(() {});
      } else if (_lastOffset > 256 && controller.offset <= 256) {
        setState(() {});
      } else if (controller.position.atEdge) {
        setState(() {});
      }
      _lastOffset = controller.offset;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PlaylistMetadata?>(
      future: db.tryGetPlaylistById(widget.playlist.id),
      initialData: widget.playlist,
      builder: (context, snapshot) {
        final PlaylistMetadata playlist = snapshot.data ?? widget.playlist;
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            scrolledUnderElevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.5),
            title: (controller.positions.isNotEmpty && controller.offset >= 256) ? Text(widget.playlist.name) : null,
          ),
          extendBody: true,
          extendBodyBehindAppBar: true,
          body: CustomScrollView(
            controller: controller,
            slivers: [
              // SliverAppBar(
              //   expandedHeight: 128.0,
              //   pinned: true,
              //   flexibleSpace: FlexibleSpaceBar(
              //     title: PreferredSize(
              //       preferredSize: const Size.fromHeight(76),
              //       child:
              //     ),
              //   ),
              //   //title: Text(album.name),
              // ),
              const SliverToBoxAdapter(child: SizedBox(height: 72)),
              SliverToBoxAdapter(child: (FrameSize.of(context)) ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (playlist.coverUri?.scheme == "file") Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image(
                        image: (playlist.coverUri?.scheme == "file" ? FileImage(File.fromUri(playlist.coverUri!))
                          : NetworkImage(playlist.coverUri.toString())) as ImageProvider,
                        width: 196, height: 196,
                        fit: BoxFit.fitHeight,
                        errorBuilder: (context, e, s) => const CoverPlaceholder(size: 196),
                      ),
                    )
                    else const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CoverPlaceholder(size: 196),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0).add(const EdgeInsets.symmetric(vertical: 12)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              playlist.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            playButtons(playlist)
                          ],
                        ),
                      ),
                    ),
                  ]
                ),
              ) : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (playlist.coverUri?.scheme == "file") Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image(
                        image: (playlist.coverUri?.scheme == "file" ? FileImage(File.fromUri(playlist.coverUri!))
                          : NetworkImage(playlist.coverUri.toString())) as ImageProvider,
                        width: 196, height: 196,
                        fit: BoxFit.fitHeight,
                        errorBuilder: (context, e, s) => const CoverPlaceholder(size: 196),
                      ),
                    )
                    else const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CoverPlaceholder(size: 196),
                    ),
                    Text(
                      playlist.name, 
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline5,
                      textAlign: TextAlign.center,
                    ),
                    playButtons(playlist)
                  ]
                ),
              )),
              if (playlist.createdAt != null || playlist.trackCount != null) SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Text.rich(TextSpan(children: [
                      TextSpan(text: "Details", style: Theme.of(context).textTheme.headline6),
                      if (playlist.createdAt != null) TextSpan(children: [
                        const TextSpan(text: "\nCreated on ", style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: playlist.createdAt!.year.toString()),
                        const TextSpan(text: "/"),
                        TextSpan(text: playlist.createdAt!.month.toString()),
                        const TextSpan(text: "/"),
                        TextSpan(text: playlist.createdAt!.day.toString())
                      ]),
                      if (playlist.trackCount != null) TextSpan(children: [
                        const TextSpan(text: "\nNumber of tracks: ", style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: playlist.trackCount.toString())
                      ]),
                    ]))
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text("Songs", style: Theme.of(context).textTheme.headline6),
                ),
              ),
              FutureBuilder<List<TrackMetadata>>(
                future: db.tryGetPlaylistTracksById(playlist.id),
                builder: (context, snapshot) => SliverReorderableList(
                  onReorder: (oldIndex, newIndex) async {
                    if (oldIndex == newIndex) return;
                    final List<TrackMetadata> tracks = snapshot.data ?? [];
                    final TrackMetadata track = tracks.removeAt(oldIndex);
                    if (newIndex > oldIndex) newIndex--;
                    tracks.insert(newIndex, track);
                    appLogger.info("Reordering playlist ${playlist.id} item from $oldIndex to $newIndex");
                    // updatePlaylistTracks(playlist.id, tracks);
                    final trackList = await db.tryGetPlaylistEntriesById(playlist.id);
                    await db.transaction(() async {
                      for (int i = 0; i < tracks.length; i++) {
                        final entry = trackList.firstWhere((element) => element.track == tracks[i].id);
                        await (db.update(db.playlistEntries)
                          ..where((tbl) => tbl.playlist.equals(playlist.id) & tbl.track.equals(tracks[i].id) & tbl.id.equals(entry.id))
                        ).write(PlaylistEntriesCompanion(
                          index: Value(i)
                        ));
                        trackList.remove(entry);
                      }
                    });
                    print(await (db.select(db.playlistEntries)
                      ..where((tbl) => tbl.playlist.equals(playlist.id))
                    ).get());
                    setState(() {});
                  },
                  itemBuilder: (context, index) {
                    final track = snapshot.data?[index] ?? TrackMetadata(uri: Uri(), title: "Loading...");
                    return SizedBox(
                      key: Key(track.id),
                      height: 72.0,
                      child: Consumer(
                        builder: (context, ref, _) {
                          return ReorderableDelayedDragStartListener(
                            index: index,
                            child: SongWidget(
                              track,
                              reorderable: true,
                              queueIndex: index,
                              inPlaylist: playlist.id,
                              showTrackNo: false,
                              selected: ref.watch(nowPlayingProvider).value?.uri == track.uri,
                              onDeleted: () => setState(() {}),
                              onTap: track.uri == Uri() ? null : () async {
                                player.stop();
                                final tracks = await db.tryGetPlaylistTracksById(playlist.id);
                                await player.updateQueue(tracks.map((e) => e.asMediaItem()).toList(), index);
                                await player.play();
                              },
                            ),
                          );
                        }
                      ),
                    );
                  },
                  itemCount: snapshot.data?.length ?? 0
                )
              )
            ]
          ),
        );
      }
    );
  }

  playButtons([PlaylistMetadata? playlist]) => Builder(
    builder: ((context) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(onPressed: () async {
            // Play All
            final traxx = await db.tryGetPlaylistTracksById((playlist ?? widget.playlist).id);
            await player.stop();
            await player.updateQueue(traxx.map((p0) => p0.asMediaItem()).toList(), 0);
            await player.play();
          }, child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text("Play All"),
          )),
          const SizedBox(width: 16),
          FloatingActionButton.extended(
            onPressed: () async {
              final traxx = await db.tryGetPlaylistTracksById((playlist ?? widget.playlist).id);
              await player.stop();
              await player.updateQueue(traxx.map((p0) => p0.asMediaItem()).toList(), 0);
              await player.setShuffleMode(AudioServiceShuffleMode.all);
              await player.play();
            },
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            label: const Text("Shuffle"),
            icon: const Icon(MdiIcons.shuffle)
          )
        ],
      ),
    ))
  );
}