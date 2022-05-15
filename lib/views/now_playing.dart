import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:audio_service/audio_service.dart';
import 'package:bodacious/main.dart';
import 'package:bodacious/src/media/audio_service.dart';
import 'package:bodacious/src/time.dart';
import 'package:bodacious/views/queue.dart';
import 'package:bodacious/widgets/cover_placeholder.dart';
import 'package:bodacious/widgets/frame_size.dart';
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:palette_generator/palette_generator.dart';

class NowPlayingView extends ConsumerStatefulWidget {
  const NowPlayingView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NowPlayingViewState();
}

class _NowPlayingViewState extends ConsumerState<NowPlayingView> {

  @override
  Widget build(BuildContext context) {
    final meta = ref.watch(nowPlayingProvider).asData!.value;
    final _fallbackColors = [
      PaletteColor(Theme.of(context).colorScheme.primary, 500),
      PaletteColor(Theme.of(context).canvasColor, 100),
    ];
    return FutureBuilder<PaletteGenerator>(
      future: () async {
        if (meta.coverBytes != null) {
          return PaletteGenerator.fromImage(
            (await 
              (await 
                (await ImageDescriptor.encoded(
                  await ImmutableBuffer.fromUint8List(
                    Uint8List.fromList(meta.coverBytes ?? [])
                  )
                )).instantiateCodec(targetHeight: 64)
              ).getNextFrame()
            ).image
          );
        } else if (meta.coverUri != null) {
          return PaletteGenerator.fromImage(
            (await 
              (await 
                (await ImageDescriptor.encoded(
                  await ImmutableBuffer.fromUint8List(
                    await File.fromUri(meta.coverUri!).readAsBytes()
                  )
                )).instantiateCodec(targetHeight: 64)
              ).getNextFrame()
            ).image
          );
        } else {
          return PaletteGenerator.fromColors(_fallbackColors);
        }
      }(),
      initialData: PaletteGenerator.fromColors(_fallbackColors),
      builder: (context, snapshot) {
        final vibrant = Theme.of(context).brightness == Brightness.light ? snapshot.data?.lightVibrantColor : snapshot.data?.darkVibrantColor;
        final vtheme = snapshot.data?.dominantColor != null ? ColorScheme.fromSeed(seedColor: snapshot.data!.dominantColor!.color) : ColorScheme.fromSeed(seedColor: Theme.of(context).colorScheme.primary);
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
              child: SafeArea(
                bottom: false,
                child: Row(
                  children: [
                    if (FrameSize.of(context) || !OuterFrame.goRouter.location.contains('?queue')) Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ConstrainedBox(
                              constraints: BoxConstraints.loose(Size.fromHeight(MediaQuery.of(context).size.height)),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Center(
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                                      child: meta.coverBytes != null || meta.coverUri?.scheme == "file" ? Image(
                                        image: (meta.coverBytes != null ? MemoryImage(Uint8List.fromList(meta.coverBytes!))
                                          : meta.coverUri?.scheme == "file" ? FileImage(File.fromUri(meta.coverUri!))
                                          : NetworkImage(meta.coverUri.toString())) as ImageProvider,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, e, s) => const CoverPlaceholder(size: null, iconSize: 64)
                                      ) : const CoverPlaceholder(size: null, iconSize: 64),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(meta.title ?? (meta.uri.pathSegments.isEmpty ? "" : meta.uri.pathSegments.last),
                                style: Theme.of(context).textTheme.headline6?.copyWith(
                                  color: vtheme.onPrimary
                                ),
                                maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center
                              ),
                              Text(meta.artistName ?? "",
                                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                                  color: vtheme.onPrimary//color: vibrant?.bodyTextColor
                                ),
                                maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center
                              ),
                              Text(meta.albumName ?? "",
                                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                                  color: vtheme.onPrimary//color: vibrant?.bodyTextColor
                                ),
                                maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 36.0),
                                child: StreamBuilder<Duration>(
                                  stream: player.playbackState.map((event) => event.position),
                                  initialData: player.position,
                                  builder: (context, _snapshot) => Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(formatPlaybackTime(player.position),
                                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                                          color: vtheme.onPrimary//color: vibrant?.bodyTextColor
                                        ),
                                        maxLines: 1, overflow: TextOverflow.ellipsis
                                      ),
                                      Text(formatPlaybackTime(player.duration ?? Duration.zero),
                                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                                          color: vtheme.onPrimary//color: vibrant?.bodyTextColor
                                        ),
                                        maxLines: 1, overflow: TextOverflow.ellipsis
                                      ),
                                    ],
                                  )
                                ),
                              )
                            ]
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0) - const EdgeInsets.only(top: 12.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                StreamBuilder<Duration>(
                                  stream: player.playbackState.map((event) => event.position),
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
                                  stream: player.playbackState,
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
                                    StreamBuilder<PlaybackState>(
                                      stream: player.playbackState,
                                      initialData: player.playbackState.valueOrNull,
                                      builder: (context, snapshot) => Tooltip(
                                        message: snapshot.data?.shuffleMode != AudioServiceShuffleMode.none ? "Shuffling" : "Not shuffling",
                                        child: IconButton(
                                          onPressed: () => player.setShuffleMode(
                                            (snapshot.data?.shuffleMode == AudioServiceShuffleMode.none)
                                            ? AudioServiceShuffleMode.all
                                            : AudioServiceShuffleMode.none
                                          ),
                                          icon: Icon(
                                            snapshot.data?.shuffleMode != AudioServiceShuffleMode.none
                                            ? MdiIcons.shuffle
                                            : MdiIcons.shuffleDisabled,
                                          ),
                                        ),
                                      ),
                                    ),
                                    StreamBuilder<PlaybackState>(
                                      stream: player.playbackState,
                                      initialData: player.playbackState.valueOrNull,
                                      builder: (context, snapshot) => Tooltip(
                                        message: snapshot.error?.toString() ?? (snapshot.data?.repeatMode == AudioServiceRepeatMode.all ? "Repeating all. Press to repeat this track" 
                                          : snapshot.data?.repeatMode == AudioServiceRepeatMode.one ? "Repeating this track. Press to turn off repeat" 
                                          : "Repeating off. Press to repeat all"),
                                        child: IconButton(
                                          onPressed: () => player.setRepeatMode(
                                            (snapshot.data?.repeatMode == AudioServiceRepeatMode.none) ? AudioServiceRepeatMode.all
                                            : (snapshot.data?.repeatMode == AudioServiceRepeatMode.all) ? AudioServiceRepeatMode.one
                                            : AudioServiceRepeatMode.none
                                          ),
                                          icon: Icon(
                                            snapshot.data?.repeatMode == AudioServiceRepeatMode.all ? MdiIcons.repeat 
                                            : snapshot.data?.repeatMode == AudioServiceRepeatMode.one ? MdiIcons.repeatOnce
                                            : MdiIcons.repeatOff
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (!FrameSize.of(context)) Tooltip(
                                      message: "View queue",
                                      child: IconButton(
                                        icon: const Icon(MdiIcons.playlistPlay),
                                        onPressed: () => setState(() => context.go("/now_playing?queue")),
                                      ),
                                    )
                                  ]
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    if (FrameSize.of(context) || OuterFrame.goRouter.location.contains('?queue')) Expanded(child: QueueView(setParentState: setState))
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
  
  Widget buildPlayPauseButton() {
    return StreamBuilder(
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
}