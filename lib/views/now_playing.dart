import 'dart:io';
import 'dart:typed_data';

import 'package:bodacious/main.dart';
import 'package:bodacious/models/track_data.dart';
import 'package:file_picker/file_picker.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:palette_generator/palette_generator.dart';

import '../src/metadata/load.dart';
import '../widgets/now_playing.dart';

class NowPlayingView extends ConsumerStatefulWidget {
  const NowPlayingView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NowPlayingViewState();
}

class _NowPlayingViewState extends ConsumerState<NowPlayingView> {

  @override
  Widget build(BuildContext context) {
    final meta = ref.watch(nowPlayingProvider);
    final _fallbackColors = [
      PaletteColor(Theme.of(context).colorScheme.primary, 500),
      PaletteColor(Theme.of(context).canvasColor, 100),
    ];
    return FutureBuilder<PaletteGenerator>(
      future: () async {
        if (ref.watch(nowPlayingProvider).coverData == null) return PaletteGenerator.fromColors(_fallbackColors);
        return PaletteGenerator.fromImage(
          (await (await meta.coverData!.instantiateCodec(targetWidth: 128, targetHeight: 128)).getNextFrame()).image
        );
      }(),
      initialData: PaletteGenerator.fromColors(_fallbackColors),
      builder: (context, snapshot) {
        final vibrant = Theme.of(context).brightness == Brightness.light ? snapshot.data?.lightVibrantColor : snapshot.data?.darkVibrantColor;
        final vtheme = snapshot.data?.dominantColor != null ? ColorScheme.fromSeed(seedColor: snapshot.data!.dominantColor!.color) : Theme.of(context).colorScheme;
        return DecoratedBox(
          decoration: BoxDecoration(color: 
            vtheme.primary //?? vibrant?.color
            //?? snapshot.data?.dominantColor?.color
            //?? Theme.of(context).canvasColor
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              colorScheme: vtheme,
              iconTheme: IconTheme.of(context).copyWith(
                color: vtheme.onPrimary
              )
            ),
            child: Material(
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    child: Image(
                      image: MemoryImage(Uint8List.fromList(meta.coverBytes ?? [])),
                      width: 256,
                      height: 256,
                      fit: BoxFit.cover,
                      errorBuilder: (context, e, s) => Container(
                        height: 256,
                        width: 256,
                        child: Center(
                          child: Icon(MdiIcons.musicBoxOutline, color: Colors.grey[700], size: 64)
                        ),
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(meta.title ?? 
                        (player.audioSource is UriAudioSource ? (player.audioSource as UriAudioSource).uri.pathSegments.last
                        : "No track name given"),
                        style: Theme.of(context).textTheme.headline6?.copyWith(
                          color: vtheme.onPrimary
                        ),
                      ),
                      if (meta.artistName?.isNotEmpty == true) Text(meta.artistName!,
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                          color: vtheme.onPrimary//color: vibrant?.bodyTextColor
                        ),
                      ),
                      if (meta.albumName?.isNotEmpty == true) Text(meta.albumName!,
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                          color: vtheme.onPrimary//color: vibrant?.bodyTextColor
                        ),
                      )
                    ]
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      StreamBuilder<Duration>(
                        stream: player.positionStream,
                        initialData: player.position,
                        builder: (context, _snapshot) => Slider(
                          value: player.position > (player.duration ?? const Duration(milliseconds: 0)) ? 0 
                          : (_snapshot.data ?? player.position).inMilliseconds.toDouble(),
                          max: player.duration?.inMilliseconds.toDouble() ?? 0,
                          onChanged: (newValue) => player.seek(Duration(milliseconds: newValue.toInt())),
                          label: (_snapshot.data ?? player.position).inMinutes.toString()
                          +":"+
                          ((_snapshot.data ?? player.position).inSeconds%60).toString(),
                          activeColor: snapshot.data?.dominantColor?.color,
                          inactiveColor: snapshot.data?.dominantColor?.bodyTextColor,
                        )
                      ),
                      StreamBuilder(
                        stream: player.playerStateStream,
                        builder: (context, snapshot) {
                          return IconTheme(
                            data: IconThemeData(
                              size: 36,
                              color: vtheme.onPrimary
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Tooltip(
                                  message: "Favorite",
                                  child: IconButton(onPressed: null, icon: Icon(MdiIcons.starOutline))
                                ),
                                const Spacer(),
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
                                buildPlayPauseButton(),
                                Tooltip(
                                  message: "Next",
                                  child: IconButton(
                                    onPressed: player.hasNext ? () => player.seekToNext() : null,
                                    icon: const Icon(MdiIcons.skipForward)
                                  )
                                ),
                                const Spacer(),
                                Builder(
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
                                          // PopupMenuItem(
                                          //   child: CheckboxListTile(
                                          //     title: const Text("Shuffle"),
                                          //     value: player.shuffleModeEnabled,
                                          //     secondary: Icon(player.shuffleModeEnabled ? MdiIcons.shuffle : MdiIcons.shuffleDisabled), 
                                          //     onChanged: (bool? value) => player.setShuffleModeEnabled(value!),
                                          //   ),
                                          //   enabled: false,
                                          // ), fuck I forgot this don't go here
                                        ]);
                                      }
                                    );
                                  }
                                )],
                            ),
                          );
                        }
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          StreamBuilder(
                            stream: player.shuffleModeEnabledStream,
                            builder: (context, snapshot) => Tooltip(
                              message: player.shuffleModeEnabled ? "Shuffling" : "Not shuffling",
                              child: IconButton(
                                onPressed: () => player.setShuffleModeEnabled(!player.shuffleModeEnabled),
                                icon: Icon(
                                  player.shuffleModeEnabled ? MdiIcons.shuffle : MdiIcons.shuffleDisabled,
                                ),
                              ),
                            ),
                          ),
                          StreamBuilder(
                            stream: player.loopModeStream,
                            builder: (context, snapshot) => Tooltip(
                              message: player.loopMode == LoopMode.all ? "Repeating all. Press to repeat this track" 
                                : player.loopMode == LoopMode.one ? "Repeating this track. Press to turn off repeat" 
                                : "Repeating off. Press to repeat all",
                              child: IconButton(
                                onPressed: () => player.setLoopMode(
                                  (player.loopMode == LoopMode.off) ? LoopMode.all
                                  : (player.loopMode == LoopMode.all) ? LoopMode.one
                                  : LoopMode.off
                                ),
                                icon: Icon(
                                  player.loopMode == LoopMode.all ? MdiIcons.repeat 
                                  : player.loopMode == LoopMode.one ? MdiIcons.repeatOnce
                                  : MdiIcons.repeatOff
                                ),
                              ),
                            ),
                          ),
                          const Tooltip(
                            message: "View queue",
                            child: IconButton(
                              icon: Icon(MdiIcons.playlistPlay),
                              onPressed: null,
                            ),
                          )
                        ]
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }
  
  Widget buildPlayPauseButton() {
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
                //player.setAudioSource(ProgressiveAudioSource(Uri.file("/")));
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
}