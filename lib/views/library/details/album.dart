import 'dart:io';

import 'package:bodacious/main.dart';
import 'package:bodacious/models/album_data.dart';
import 'package:bodacious/models/track_data.dart';
import 'package:bodacious/widgets/cover_placeholder.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
    return FutureBuilder<AlbumMetadata?>(
      future: db.tryGetAlbum(widget.album.name, by: widget.album.artistName),
      initialData: widget.album,
      builder: (context, snapshot) {
        final AlbumMetadata album = snapshot.data ?? widget.album;
        return Scaffold(
          body: CustomScrollView(
            controller: controller,
            slivers: [
              SliverAppBar(
                expandedHeight: 128.0,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: PreferredSize(
                    preferredSize: const Size.fromHeight(76),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        if (controller.positions.isEmpty || controller.offset <= 48) ...[
                          if (album.coverUri?.scheme == "file") Image(
                            image: (album.coverUri?.scheme == "file" ? FileImage(File.fromUri(album.coverUri!))
                              : NetworkImage(album.coverUri.toString())) as ImageProvider,
                            width: 72,
                            fit: BoxFit.fitHeight,
                            errorBuilder: (context, e, s) => const CoverPlaceholder(size: 72),
                          )
                          else const CoverPlaceholder(size: 72)
                        ],
                        Padding(
                          padding: (controller.positions.isEmpty || controller.offset <= 48) ? const EdgeInsets.all(8.0) : EdgeInsets.zero,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                album.name, 
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              if (controller.positions.isEmpty || controller.offset <= 48) Text(album.artistName, 
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.caption
                              )
                            ],
                          ),
                        )
                      ]
                    ),
                  ),
                ),
                //title: Text(album.name),
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
                        child: ListTile(
                          leading: SizedBox(
                            height: 48,
                            width: 48,
                            child: Stack(
                              children: [
                                if (track.trackNo != null) ...[
                                  Positioned.fill(child: Center(child: Text(track.trackNo!.toString().padLeft(2, '0')))),
                                  Positioned.fill(child: Container(color: Colors.black54))
                                ],
                                track.coverBytes != null || track.coverUri?.scheme == "file" ? Image(
                                  image: (track.coverUri?.scheme == "file" ? FileImage(File.fromUri(track.coverUri!))
                                    : NetworkImage(track.coverUri.toString())) as ImageProvider,
                                  width: 48,
                                  height: 48,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, e, s) => const CoverPlaceholder(size: 48, iconSize: 24),
                                ) : const CoverPlaceholder(size: 48, iconSize: 24),
                              ]
                            ),
                          ),
                          title: Text(track.title ?? (track.uri.pathSegments.isEmpty ? "Unknown track" : track.uri.pathSegments.last)),
                          subtitle: track.artistName?.isEmpty == false ? Text(track.artistName!) : null,
                          onTap: track.uri == Uri() ? null : () {
                            player.stop();
                            player.updateQueue(snapshot.data!.map((e) => e.asMediaItem()).toList());
                            //ref.read(nowPlayingProvider.notifier).changeTrack(track);
                            player.skipToQueueItem(index);
                            player.play();
                          },
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