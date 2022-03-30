import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:bodacious/main.dart';
import 'package:bodacious/models/track_data.dart';
import 'package:bodacious/src/metadata/id3.dart';
import 'package:bodacious/widgets/cover_placeholder.dart';
import 'package:bodacious/widgets/now_playing_data.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class NowPlayingBar extends ConsumerWidget {
  const NowPlayingBar({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = NowPlayingData.of(context);
    return Material(
      elevation: 8, 
      color: Theme.of(context).colorScheme.surface,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(child: buildTrackInfo(data!, context)),
          MediaQuery.of(context).size.width > 480 ? SizedBox(
            width: 240,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                StreamBuilder(
                  stream: player.playerStateStream,
                  builder: (context, snapshot) {
                    return Row(children: [
                      Tooltip(
                        message: "Previous",
                        child: IconButton(onPressed: player.hasPrevious || player.audioSource != null ? () {
                          if (player.position > const Duration(seconds: 1) || !player.hasPrevious) {
                            player.seek(const Duration(seconds: 0));
                          } else {
                            player.seekToPrevious();
                          }
                        } : null, icon: const Icon(MdiIcons.skipBackward))
                      ),
                      buildPlayPauseButton(data, ref),
                      Tooltip(
                        message: "Next",
                        child: IconButton(
                          onPressed: player.hasNext ? () => player.seekToNext() : null,
                          icon: const Icon(MdiIcons.skipForward)
                        )
                      ),
                    ]);
                  }
                )
              ],
            ),
          ) : buildPlayPauseButton(data, ref),
        ],
      )
    );
  }

  // [mdi:play Play button] and [mdi:pause Pause button]
  Widget buildPlayPauseButton(NowPlayingData data, WidgetRef ref) {
    return StreamBuilder(
      stream: player.playingStream,
      builder: (context, snap) => snap.data == true ? Tooltip(
        message: "Pause",
        child: IconButton(onPressed: () {
          assert(player.audioSource != null);
          if (player.audioSource == null) return;
          player.pause();
        }, icon: const Icon(MdiIcons.pause))
      ) : Tooltip(
        message: "Play",
        child: IconButton(onPressed: () {
          if (player.audioSource == null || player.position >= (player.duration ?? const Duration())-(const Duration(milliseconds: 500))) {
            FilePicker.platform.pickFiles(
              type: FileType.audio,
              withData: true,
              allowCompression: false,
              allowMultiple: false
            ).then((file) {
              if (file == null || file.files.isEmpty) return;
              player.setAudioSource(AudioSource.uri(Uri.file(file.files.single.path!)));
              loadID3FromBytes(file.files.single.bytes!, File(file.files.single.path!)).then((value) => 
                ref.read(nowPlayingProvider.notifier).changeTrack(value)
              );
              player.play();
              player.playbackEventStream.firstWhere((e) => (e.processingState == ProcessingState.completed)).then((event) {
                player.pause();
                ref.read(nowPlayingProvider.notifier).changeTrack(const TrackMetadata());
              });
            });
          } else {
            player.play();
          }
        }, icon: const Icon(MdiIcons.play))
      ),
    );
  }

  Widget buildTrackInfo(NowPlayingData npdata, BuildContext context) {
    return InkWell(
      onTap: () => OuterFrame.goRouter.go("/now_playing"),
      child: Consumer(
        builder: (context, ref, child) {
          final meta = ref.watch(nowPlayingProvider);
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
                    Text(meta.title ?? meta.uri?.pathSegments.last ?? ""),
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