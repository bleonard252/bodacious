import 'dart:io';

import 'package:bodacious/models/playlist_data.dart';
import 'package:bodacious/models/track_data.dart';
import 'package:bodacious/widgets/frame_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../main.dart';
import '../cover_placeholder.dart';

class PlaylistWidget extends ConsumerWidget {
  final PlaylistMetadata playlist;
  final Function()? onTap;
  final bool hideCounter;
  final InlineSpan? subtitle;
  const PlaylistWidget(this.playlist, {
    Key? key,
    this.onTap,
    this.hideCounter = false,
    this.subtitle
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logger = appLogger.independentChild("PlaylistWidget");
    final _subtitle = buildChildren();
    return SizedBox(
      height: _subtitle.isEmpty ? 64.0 : 80.0,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: playlist.coverUri?.scheme == "file" ? Image(
          image: (playlist.coverUri?.scheme == "file" ? FileImage(File.fromUri(playlist.coverUri!))
            : NetworkImage(playlist.coverUri.toString())) as ImageProvider,
          width: 48,
          height: 48,
          fit: BoxFit.cover,
          errorBuilder: (context, e, s) => const CoverPlaceholder(size: 48, iconSize: 24),
        ) : const CoverPlaceholder(size: 48, iconSize: 24),
        title: Text.rich(TextSpan(children: [
          WidgetSpan(
            child: Icon(MdiIcons.playlistMusic, size: Theme.of(context).textTheme.subtitle1?.fontSize),
            alignment: PlaceholderAlignment.middle
          ),
          const WidgetSpan(child: SizedBox(width: 6)),
          TextSpan(text: playlist.name)
        ])),
        subtitle: _subtitle.isEmpty ? null : Text.rich(TextSpan(children: _subtitle)),
        onTap: onTap ?? () async {
          context.go("/library/pl/${playlist.id}", extra: playlist);
        },
        trailing: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(MdiIcons.dotsVertical),
              onPressed: () {
                // the following block was ripped straight from PopupMenuButtonState().showButtonMenu
                final button = context.findRenderObject()! as RenderBox;
                final overlay = Navigator.of(context, rootNavigator: true).overlay!.context.findRenderObject()! as RenderBox;
                final position = RelativeRect.fromRect(
                  Rect.fromPoints(
                    button.localToGlobal(Offset.zero, ancestor: overlay),
                    button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay),
                  ),
                  Offset.zero & overlay.size,
                );
                showMenu(context: context, position: position, items: [
                  const PopupMenuItem(
                    child: Text("Play all next"),
                    value: "playnext",
                  ),
                  const PopupMenuItem(
                    child: Text("Add all to Queue"),
                    value: "queue",
                  ),
                  const PopupMenuItem(
                    child: Text("Delete playlist", style: TextStyle(color: Colors.red)),
                    value: "delete",
                  ),
                ]).then((value) async {
                  switch (value) {
                    case "playnext":
                      var q = ref.read(queueProvider).value;
                      if (q == null) logger.warning("Queue is null! Waiting up to 250ms to try again.");
                      if (player.queue.value.isNotEmpty) {
                        logger.verbose("Attempting to get full queue");
                        q ??= await ref.read(queueProvider.stream).firstWhere((element) => element.entries.isNotEmpty).timeout(const Duration(milliseconds: 250), onTimeout: () {
                          logger.error("Failed to get queue", error: "Timed out");
                          return Queue<TrackMetadata>(entries: [], position: 0);
                        }).catchError((error, stackTrace) {
                          logger.error("Failed to get queue", error: error, stackTrace: stackTrace);
                          return Queue<TrackMetadata>(entries: [], position: 0);
                        });
                      } else if (player.queue.value.isEmpty) {
                        logger.debug("Nothing is playing, playing now: ${playlist.name}", error: q);
                        final tracks = await db.tryGetPlaylistTracksById(playlist.id);
                        player.addQueueItems(tracks.map((e) => e.asMediaItem()).toList());
                        break;
                      }
                      logger.debug("Playing all next: ${playlist.name}", error: q);
                      final tracks = await db.tryGetPlaylistTracksById(playlist.id);
                      final x = (q?.position ?? player.currentIndex ?? 0);
                      player.insertQueueItems(x+1, tracks.map((e) => e.asMediaItem()).toList());
                      ref.refresh(nowPlayingProvider);
                      ref.refresh(queueProvider);
                      // for (int i = 0; i < tracks.length; i++) {
                      //   player.insertQueueItem(x+i+1, tracks[i].asMediaItem());
                      // }
                      break;
                    case "queue":
                      final tracks = await db.tryGetPlaylistTracksById(playlist.id);
                      player.addQueueItems(tracks.map((e) => e.asMediaItem()).toList());
                      ref.refresh(nowPlayingProvider);
                      ref.refresh(queueProvider);
                      // for (int i = 0; i < tracks.length; i++) {
                      //   player.addQueueItem(tracks[i].asMediaItem());
                      // }
                      break;
                    case "delete":
                      final result = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Delete playlist"),
                          content: const Text("Are you sure you want to delete this playlist? "
                          "Songs will not be deleted, but the playlist will be removed."),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text("Delete"),
                            ),
                          ],
                        ),
                      );
                      if (result == true) await db.deletePlaylistById(playlist.id);
                      break;
                    default:
                  }
                });
              }
            );
          }
        ),
      ),
    );
  }

  List<InlineSpan> buildChildren() {
    return [
      if (subtitle != null) subtitle!,
      // const WidgetSpan(child: Icon(MdiIcons.spotify)),
      // const WidgetSpan(child: SizedBox(width: 6)),
      if (!hideCounter) TextSpan(text: "${playlist.trackCount} songs"),
      //if (album.year != null) TextSpan(text: album.year.toString())
    ];
  }
}