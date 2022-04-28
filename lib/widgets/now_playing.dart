import 'dart:io';
import 'dart:typed_data';

import 'package:bodacious/main.dart';
import 'package:bodacious/models/track_data.dart';
import 'package:bodacious/widgets/cover_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'frame_size.dart';

class NowPlayingBar extends ConsumerWidget {
  const NowPlayingBar({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final data = NowPlayingData.of(context);
    return Material(
      elevation: 8, 
      color: Theme.of(context).colorScheme.surface,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(child: buildTrackInfo(context)),
          FrameSize.of(context) ? SizedBox(
            width: 240,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                StreamBuilder(
                  stream: player.playbackState,
                  builder: (context, snapshot) {
                    return Row(children: [
                      Tooltip(
                        message: "Previous",
                        child: IconButton(
                          onPressed: () => player.skipToPrevious(),
                          icon: const Icon(MdiIcons.skipBackward)
                        )
                      ),
                      buildPlayPauseButton(),
                      Tooltip(
                        message: "Next",
                        child: IconButton(
                          onPressed: () => player.skipToNext(),
                          icon: const Icon(MdiIcons.skipForward)
                        )
                      ),
                    ]);
                  }
                )
              ],
            ),
          ) : buildPlayPauseButton(),
        ],
      )
    );
  }

  // [mdi:play Play button] and [mdi:pause Pause button]
  Widget buildPlayPauseButton() {
  return StreamBuilder<bool>(
    stream: player.playbackState.map((event) => event.playing),
      initialData: player.playbackState.valueOrNull?.playing,
      builder: (context, snap) => snap.data == true ? Tooltip(
      message: "Pause",
      child: IconButton(onPressed: () {
        player.pause();
      }, icon: const Icon(MdiIcons.pause))
    ) : Tooltip(
      message: "Play",
      child: IconButton(onPressed: () {
        player.play();
      }, icon: const Icon(MdiIcons.play))
    ),
  );
}

  Widget buildTrackInfo(BuildContext context) {
    return InkWell(
      onTap: () => OuterFrame.goRouter.go("/now_playing"),
      child: Consumer(
        builder: (context, ref, child) {
          final meta = ref.watch(nowPlayingProvider).asData?.value ?? TrackMetadata.empty();
          var secondRow = [
            if (meta.artistName?.isNotEmpty == true) TextSpan(text: meta.artistName ?? "Artist"),
            // WidgetSpan(child: SizedBox(width: 12)),
            // TextSpan(text: "Album"),
          ];
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: meta.coverBytes != null || meta.coverUri?.scheme == "file" ? Image(
                  image: (meta.coverBytes != null ? MemoryImage(Uint8List.fromList(meta.coverBytes!))
                    : meta.coverUri?.scheme == "file" ? FileImage(File.fromUri(meta.coverUri!))
                    : NetworkImage(meta.coverUri.toString())) as ImageProvider,
                  width: 64,
                  height: 64,
                  fit: BoxFit.cover,
                  errorBuilder: (context, e, s) => const CoverPlaceholder(size: 64, iconSize: 36),
                ) : const CoverPlaceholder(size: 64, iconSize: 36),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(meta.title ?? (meta.uri.pathSegments.isEmpty ? "" : meta.uri.pathSegments.last), maxLines: 1, overflow: TextOverflow.fade),
                    if (secondRow.isNotEmpty) Text.rich(TextSpan(children: secondRow), 
                      style: Theme.of(context).textTheme.caption
                    )
                  ],
                ),
              )
            ],
          );
        }
      ),
    );
  }
}