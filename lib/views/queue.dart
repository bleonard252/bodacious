import 'dart:io';

import 'package:bodacious/main.dart';
import 'package:bodacious/widgets/cover_placeholder.dart';
import 'package:bodacious/widgets/frame_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class QueueView extends ConsumerWidget {
  final Function(Function())? setParentState;
  final ScrollController controller = ScrollController();
  QueueView({Key? key, this.setParentState}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        AppBar(
          leading: FrameSize.of(context) ? null : Tooltip(
            message: "Back to Now Playing",
            child: IconButton(
              onPressed: () => setParentState?.call(() => context.go("/now_playing")),
              icon: const Icon(MdiIcons.arrowLeft)
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        Expanded(
          child: ListView.builder(
            itemExtent: 72.0,
            itemCount: (ref.watch(queueProvider).value?.length ?? 0),
            itemBuilder: (context, index) {
              
              final track = ref.watch(queueProvider).value![index];
              return SizedBox(
                height: 72.0,
                child: ListTile(
                  selected: track.uri == ref.watch(nowPlayingProvider).value?.uri,
                  selectedColor: Theme.of(context).colorScheme.onInverseSurface,
                  selectedTileColor: Theme.of(context).colorScheme.inverseSurface,
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
                    player.skipToQueueItem(index);
                    //ref.read(nowPlayingProvider.notifier).changeTrack(track);
                    player.play();
                  },
                ),
              );
            }
          ),
        ),
      ],
    );
  }
}