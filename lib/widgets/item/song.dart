import 'dart:io';

import 'package:bodacious/main.dart';
import 'package:bodacious/models/track_data.dart';
import 'package:bodacious/widgets/cover_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SongWidget extends ConsumerWidget {
  final TrackMetadata track;
  final Function()? onTap;
  final bool selected;
  /// This changes the [selected] appearance.
  final bool inQueue;
  final bool showTrackNo;
  /// Good for artist pages.
  final bool useAlbumName;
  final bool showVariations;
  final int? queueIndex;
  const SongWidget(this.track, {
    Key? key,
    this.onTap,
    this.showTrackNo = false,
    this.selected = false,
    this.inQueue = false,
    this.useAlbumName = false,
    this.showVariations = false,
    this.queueIndex
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 72.0,
      child: Column(
        children: [
          ListTile(
            selected: selected,
            selectedColor: inQueue ? Theme.of(context).colorScheme.onInverseSurface : Theme.of(context).colorScheme.primary,
            selectedTileColor: inQueue ? Theme.of(context).colorScheme.inverseSurface : null,
            leading: SizedBox(
              width: 48,
              height: 48,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Positioned.fill(
                    child: Container(
                      foregroundDecoration: track.available ? null : BoxDecoration(
                        color: Colors.black.withAlpha(127),
                        backgroundBlendMode: BlendMode.srcOver
                      ),
                      child: track.coverBytes != null || track.coverUri?.scheme == "file" ? Image(
                      image: (track.coverUri?.scheme == "file" ? FileImage(File.fromUri(track.coverUri!))
                        : NetworkImage(track.coverUri.toString())) as ImageProvider,
                      width: 48,
                      height: 48,
                      color: track.available ? null : Colors.black,
                      colorBlendMode: track.available ? BlendMode.srcIn : BlendMode.saturation,
                      fit: BoxFit.cover,
                      errorBuilder: (context, e, s) => const CoverPlaceholder(size: 48, iconSize: 24),
                    ) : const CoverPlaceholder(size: 48, iconSize: 24),
                    ),
                  ),
                  if (selected) ...[
                    Positioned.fill(child: Container(color: Colors.black54)),
                    Positioned.fill(child: Center(child: Icon(MdiIcons.equalizer, color: Theme.of(context).colorScheme.primary))),
                  ]
                  else if (showTrackNo && track.trackNo != null && track.trackNo != 0) ...[
                    Positioned.fill(child: Container(color: Colors.black54)),
                    Positioned.fill(child: Center(child: Text(track.trackNo!.toString().padLeft(2, '0')))),
                  ],
                ]
              ),
            ),
            title: Text(track.title ?? (track.uri.pathSegments.isEmpty ? "Unknown track" : track.uri.pathSegments.last)),
            subtitle: !track.available ? const Text("Track unavailable") : 
              useAlbumName ? track.albumName?.isEmpty == false ? Text(track.albumName!) : null : track.artistName?.isEmpty == false ? Text(track.artistName!) : null,
            onTap: !track.available ? null : onTap,
            enabled: track.available,
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
                        child: Text("Track info"),
                        value: "trackinfo",
                      ),
                      if (track.available) const PopupMenuItem(
                        child: Text("Play next"),
                        value: "playnext",
                      ),
                      if (track.available) const PopupMenuItem(
                        child: Text("Add to Queue"),
                        value: "queue",
                      ),
                      if (inQueue && queueIndex != null) const PopupMenuItem(
                        child: Text("Remove from Queue"),
                        value: "removequeue",
                      )
                    ]).then((value) {
                      switch (value) {
                        case "playnext":
                          final q = ref.read(queueProvider).value;
                          player.insertQueueItem((q?.position ?? 0)+1, track.asMediaItem());
                          //ref.invalidate(queueProvider);
                          break;
                        case "queue":
                          player.addQueueItem(track.asMediaItem());
                          //ref.invalidate(queueProvider);
                          break;
                        case "removequeue":
                          if (queueIndex == null) break;
                          player.removeQueueItemAt(queueIndex!);
                          //ref.invalidate(queueProvider);
                          break;
                        default:
                      }
                    });
                  }
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}