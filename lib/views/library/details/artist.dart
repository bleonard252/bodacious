import 'dart:io';

import 'package:bodacious/main.dart';
import 'package:bodacious/models/album_data.dart';
import 'package:bodacious/models/artist_data.dart';
import 'package:bodacious/models/track_data.dart';
import 'package:bodacious/widgets/cover_placeholder.dart';
import 'package:bodacious/widgets/frame_size.dart';
import 'package:bodacious/widgets/item/album.dart';
import 'package:bodacious/widgets/item/song.dart';
import 'package:drift/drift.dart' hide Column, Table;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ArtistDetailsWrapper extends StatelessWidget {
  final String id;
  final dynamic data;
  const ArtistDetailsWrapper({ Key? key, this.data, required this.id }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ArtistMetadata?>(
      initialData: data is ArtistMetadata ? data : null,
      future: data is ArtistMetadata ? null : (db.select(db.artistTable)
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
      ) : snapshot.hasData ? ArtistDetailsView(artist: snapshot.data!)
      : snapshot.connectionState == ConnectionState.done ?Material(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(MdiIcons.ghost, color: Colors.blue),
              ),
              Text("No artist found", textAlign: TextAlign.center, style: TextStyle(color: Colors.blue))
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

class ArtistDetailsView extends StatefulWidget {
  final ArtistMetadata artist;
  const ArtistDetailsView({ Key? key, required this.artist}) : super(key: key);

  @override
  State<ArtistDetailsView> createState() => ArtistDetailsViewState();
}

class ArtistDetailsViewState extends State<ArtistDetailsView> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    double _lastOffset = 0.0;
    controller.addListener(() {
      if (controller.positions.isEmpty) return;
      if (_lastOffset < 48 && controller.offset >= 48) {
        setState(() {});
      } else if (_lastOffset > 48 && controller.offset <= 48) {
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
    return FutureBuilder<ArtistMetadata?>(
      future: db.tryGetArtist(widget.artist.name),
      initialData: widget.artist,
      builder: (context, snapshot) {
        final ArtistMetadata artist = snapshot.data ?? widget.artist;
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            scrolledUnderElevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.5),
            title: (controller.positions.isNotEmpty && controller.offset >= 256) ? Text(widget.artist.name) : null,
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
              //       child: Row(
              //         crossAxisAlignment: CrossAxisAlignment.end,
              //         mainAxisAlignment: MainAxisAlignment.start,
              //         mainAxisSize: MainAxisSize.max,
              //         children: [
              //           if (controller.positions.isEmpty || controller.offset <= 48) 
              //           ClipOval(child: artist.coverUri != null ? Image(
              //             image: (artist.coverUri?.scheme == "file" ? FileImage(File.fromUri(artist.coverUri!))
              //               : NetworkImage(artist.coverUri.toString())) as ImageProvider,
              //             width: 72,
              //             height: 72,
              //             fit: BoxFit.cover,
              //             errorBuilder: (context, e, s) => const CoverPlaceholder(size: 48, iconSize: 24),
              //           ) : 
              //           Expanded(
              //             child: Padding(
              //               padding: (controller.positions.isEmpty || controller.offset <= 48) ? const EdgeInsets.all(8.0) : EdgeInsets.zero,
              //               child: Text(
              //                 artist.name, 
              //                 maxLines: 2,
              //                 overflow: TextOverflow.ellipsis,
              //               ),
              //             ),
              //           )
              //         ]
              //       ),
              //     ),
              //   ),
              //   //title: Text(album.name),
              // ),
              const SliverToBoxAdapter(child: SizedBox(height: 56)),
              SliverToBoxAdapter(child: (FrameSize.of(context)) ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: (artist.coverUri?.scheme == "file") ? ClipOval(
                        child: Image(
                          image: (artist.coverUri?.scheme == "file" ? FileImage(File.fromUri(artist.coverUri!))
                            : NetworkImage(artist.coverUri.toString())) as ImageProvider,
                          width: 196, height: 196,
                          fit: BoxFit.fitHeight,
                          errorBuilder: (context, e, s) => const CoverPlaceholder(size: 196),
                        ),
                      ) : FutureBuilder<AlbumMetadata?>(
                        future: (
                          db.select(db.albumTable)
                          //..addColumns([db.albumTable.coverUri, db.albumTable.artistName, db.albumTable.releaseDate, db.albumTable.year])
                          ..where((tbl) => tbl.artistName.equals(artist.name) & (tbl.releaseDate.isNotNull() | tbl.year.isNotNull()))
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
                            width: 196, height: 196,
                            fit: BoxFit.cover,
                            errorBuilder: (context, e, s) => const CoverPlaceholder(size: 196),
                          ): const CoverPlaceholder(size: 196);
                        }
                      )
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0).add(const EdgeInsets.symmetric(vertical: 12)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              artist.name, 
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            // Text(album.artistName, 
                            //   maxLines: 1,
                            //   overflow: TextOverflow.ellipsis,
                            //   style: Theme.of(context).textTheme.headline6
                            // )
                          ],
                        ),
                      ),
                    )
                  ]
                ),
              ) : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipOval(child: (artist.coverUri?.scheme == "file") ? Image(
                        image: (artist.coverUri?.scheme == "file" ? FileImage(File.fromUri(artist.coverUri!))
                          : NetworkImage(artist.coverUri.toString())) as ImageProvider,
                        width: 196, height: 196,
                        fit: BoxFit.fitHeight,
                        errorBuilder: (context, e, s) => const CoverPlaceholder(size: 196),
                      ) :FutureBuilder<AlbumMetadata?>(
                        future: (
                          db.select(db.albumTable)
                          //..addColumns([db.albumTable.coverUri, db.albumTable.artistName, db.albumTable.releaseDate, db.albumTable.year])
                          ..where((tbl) => tbl.artistName.equals(artist.name) & (tbl.releaseDate.isNotNull() | tbl.year.isNotNull()))
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
                            width: 196, height: 196,
                            fit: BoxFit.cover,
                            errorBuilder: (context, e, s) => const CoverPlaceholder(size: 196),
                          ): const CoverPlaceholder(size: 72); // leave this one at 72
                        }
                      )),
                    ),
                    Text(
                      artist.name, 
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline5,
                      textAlign: TextAlign.center,
                    ),
                    // Text(album.artistName, 
                    //   maxLines: 1,
                    //   overflow: TextOverflow.ellipsis,
                    //   style: Theme.of(context).textTheme.headline6,
                    //   textAlign: TextAlign.center,
                    // )
                  ]
                ),
              )),
              if (artist.trackCount != null || artist.albumCount != null) SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Text.rich(TextSpan(children: [
                      TextSpan(text: "Details", style: Theme.of(context).textTheme.headline6),
                      if (artist.trackCount != null) TextSpan(children: [
                        const TextSpan(text: "\nNumber of tracks: ", style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: artist.trackCount.toString())
                      ]),
                      if (artist.albumCount != null) TextSpan(children: [
                        const TextSpan(text: "\nNumber of albums: ", style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: artist.albumCount.toString())
                      ]),
                    ]))
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text("Albums", style: Theme.of(context).textTheme.headline6),
                ),
              ),
              FutureBuilder<List<AlbumMetadata>>(
                future: (
                  db.select(db.albumTable)
                  ..where((tbl) => tbl.artistName.equals(artist.name))
                  ..orderBy([
                    (tbl) => OrderingTerm.asc(tbl.year),
                  ])
                ).get(),
                builder: (context, snapshot) => SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final album = snapshot.data?[index] ?? const AlbumMetadata(artistName: "", name: "Loading...");
                      return Consumer(
                        builder: (context, ref, _) {
                          return AlbumWidget(
                            album, hideArtist: true
                          );
                        }
                      );
                    },
                    childCount: snapshot.data?.length ?? 0
                  )
                )
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text("All Songs", style: Theme.of(context).textTheme.headline6),
                ),
              ),
              FutureBuilder<List<TrackMetadata>>(
                future: (
                  db.select(db.trackTable)
                  ..where((tbl) => tbl.artistName.equals(artist.name))
                  ..orderBy([
                    (tbl) => OrderingTerm.asc(tbl.year),
                    (tbl) => OrderingTerm.asc(tbl.albumName),
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
                              useAlbumName: true,
                              selected: ref.watch(nowPlayingProvider).value?.uri == track.uri,
                              onTap: track.uri == Uri() ? null : () async {
                                await player.stop();
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
}