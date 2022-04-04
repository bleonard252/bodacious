import 'dart:io';

import 'package:bodacious/models/track_data.dart';
import 'package:bodacious/widgets/cover_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SongWidget extends ConsumerWidget {
  final TrackMetadata track;
  final Function()? onTap;
  final bool selected;
  /// This changes the [selected] appearance.
  final bool inQueue;
  final bool showTrackNo;
  /// Good for artist pages.
  final bool useAlbumName;
  const SongWidget(this.track, {
    Key? key,
    this.onTap,
    this.showTrackNo = false,
    this.selected = false,
    this.inQueue = false,
    this.useAlbumName = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 72.0,
      child: ListTile(
        selected: selected,
        selectedColor: inQueue ? Theme.of(context).colorScheme.onInverseSurface : Theme.of(context).colorScheme.primary,
        selectedTileColor: inQueue ? Theme.of(context).colorScheme.inverseSurface : null,
        leading: SizedBox(
          width: 48,
          height: 48,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned.fill(child: track.coverBytes != null || track.coverUri?.scheme == "file" ? Image(
                image: (track.coverUri?.scheme == "file" ? FileImage(File.fromUri(track.coverUri!))
                  : NetworkImage(track.coverUri.toString())) as ImageProvider,
                width: 48,
                height: 48,
                fit: BoxFit.cover,
                errorBuilder: (context, e, s) => const CoverPlaceholder(size: 48, iconSize: 24),
              ) : const CoverPlaceholder(size: 48, iconSize: 24)),
              if (showTrackNo && track.trackNo != null && track.trackNo != 0) ...[
                Positioned.fill(child: Container(color: Colors.black54)),
                Positioned.fill(child: Center(child: Text(track.trackNo!.toString().padLeft(2, '0')))),
              ],
            ]
          ),
        ),
        title: Text(track.title ?? (track.uri.pathSegments.isEmpty ? "Unknown track" : track.uri.pathSegments.last)),
        subtitle: track.artistName?.isEmpty == false ? Text(track.artistName!) : null,
        onTap: onTap
      ),
    );
  }
}