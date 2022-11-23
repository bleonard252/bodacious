import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:bodacious/main.dart';
import 'package:bodacious/models/album_data.dart';
import 'package:bodacious/models/artist_data.dart';
import 'package:bodacious/models/track_data.dart';
import 'package:bodacious/views/library/edit/cover.dart';
import 'package:bodacious/widgets/cover_placeholder.dart';
import 'package:bodacious/widgets/frame_size.dart';
import 'package:bodacious/widgets/item/artist.dart';
import 'package:bodacious/widgets/item/song.dart';
import 'package:drift/drift.dart' hide Column, Table;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AlbumDetailsWrapper extends StatelessWidget {
  final String id;
  final dynamic data;
  const AlbumDetailsWrapper({ Key? key, this.data, required this.id }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AlbumMetadata?>(
      initialData: data is AlbumMetadata ? data : null,
      future: data is AlbumMetadata ? null : (db.select(db.albumTable)
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
      ) : snapshot.hasData ? AlbumDetailsView(album: snapshot.data!)
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
              Text("No album found", textAlign: TextAlign.center, style: TextStyle(color: Colors.blue))
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

class AlbumDetailsView extends StatefulWidget {
  final AlbumMetadata album;
  const AlbumDetailsView({ Key? key, required this.album }) : super(key: key);

  @override
  State<AlbumDetailsView> createState() => AlbumDetailsViewState();
}

class AlbumDetailsViewState extends State<AlbumDetailsView> {
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
    return FutureBuilder<AlbumMetadata?>(
      future: db.tryGetAlbum(widget.album.name, by: widget.album.artistName),
      initialData: widget.album,
      builder: (context, snapshot) {
        final AlbumMetadata album = snapshot.data ?? widget.album;
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            scrolledUnderElevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.5),
            title: (controller.positions.isNotEmpty && controller.offset >= 256) ? Text(widget.album.name) : null,
            actions: [
              IconButton(
                icon: const Icon(MdiIcons.pencil),
                tooltip: "Edit",
                onPressed: () async {
                  final tracks = (await db.tryGetAlbumTracksById(album.id)).map((e) => e.id).toList();
                  showDialog(context: context, builder: (context) => CoverEditorDialog(
                    type: BoType.album, id: album.id,
                    coverUri: album.coverUri,
                    trackIds: tracks,
                    albumIds: [album.id],
                  ));
                }
              ),
            ],
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
                    if (album.coverUri?.scheme == "file") Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image(
                        image: (album.coverUri?.scheme == "file" ? FileImage(File.fromUri(album.coverUri!))
                          : NetworkImage(album.coverUri.toString())) as ImageProvider,
                        height: 196,
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
                              album.name, 
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            Text(album.artistName, 
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.headline6
                            ),
                            playButtons(album)
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
                    if (album.coverUri?.scheme == "file") Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image(
                        image: (album.coverUri?.scheme == "file" ? FileImage(File.fromUri(album.coverUri!))
                          : NetworkImage(album.coverUri.toString())) as ImageProvider,
                        height: 196,
                        fit: BoxFit.fitHeight,
                        errorBuilder: (context, e, s) => const CoverPlaceholder(size: 196),
                      ),
                    )
                    else const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CoverPlaceholder(size: 196),
                    ),
                    Text(
                      album.name, 
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline5,
                      textAlign: TextAlign.center,
                    ),
                    Text(album.artistName, 
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline6,
                      textAlign: TextAlign.center,
                    ),
                    playButtons(album)
                  ]
                ),
              )),
              FutureBuilder<ArtistMetadata?>(
                future: db.tryGetArtist(album.artistName),
                builder: (context, snapshot) => snapshot.hasData ? SliverToBoxAdapter(child: ArtistWidget(
                  snapshot.data!,
                  hideDetails: true,
                  subtitle: const TextSpan(text: "Album artist"),
                )) 
                : SliverToBoxAdapter(child: Container())
              ),
              if (album.year != null || album.trackCount != null) SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Text.rich(TextSpan(children: [
                      TextSpan(text: "Details", style: Theme.of(context).textTheme.headline6),
                      if (album.year != null) TextSpan(children: [
                        const TextSpan(text: "\nYear: ", style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: album.year.toString())
                      ]),
                      if (album.trackCount != null) TextSpan(children: [
                        const TextSpan(text: "\nNumber of tracks: ", style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: album.trackCount.toString())
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
                future: (
                  db.select(db.trackTable)
                  ..where((tbl) => tbl.artistName.equals(album.artistName) & tbl.albumName.equals(album.name))
                  ..orderBy([
                    (tbl) => OrderingTerm.asc(tbl.discNo),
                    (tbl) => OrderingTerm.asc(tbl.trackNo),
                  ])
                ).get(),
                builder: (context, snapshot) => SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final track = snapshot.data?[index] ?? TrackMetadata(uri: Uri(), title: "Loading...");
                      return SizedBox(
                        height: 72.0,
                        child: Consumer(
                          builder: (context, ref, _) {
                            return SongWidget(
                              track,
                              showTrackNo: true,
                              selected: ref.watch(nowPlayingProvider).value?.uri == track.uri,
                              onTap: track.uri == Uri() ? null : () async {
                                player.stop();
                                await player.updateQueue(snapshot.data!.map((e) => e.asMediaItem()).toList(), index);
                                await player.play();
                              },
                            );
                          }
                        ),
                      );
                    },
                    childCount: snapshot.data?.length ?? 0
                  )
                )
              )
            ]
          ),
        );
      }
    );
  }

  playButtons([AlbumMetadata? album]) => Builder(
    builder: ((context) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(onPressed: () async {
            // Play All
            final traxx = await db.tryGetAlbumTracks((album ?? widget.album).name, by: (album ?? widget.album).artistName);
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
              final traxx = await db.tryGetAlbumTracks((album ?? widget.album).name, by: (album ?? widget.album).artistName);
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