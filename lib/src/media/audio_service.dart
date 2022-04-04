import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:bodacious/drift/database.dart';
import 'package:bodacious/main.dart';
import 'package:dart_vlc/dart_vlc.dart' as vlc;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:just_audio/just_audio.dart' as just;
import 'package:mime/mime.dart';
import 'package:rxdart/src/subjects/behavior_subject.dart';

import '../../models/track_data.dart';

/// The audio handler for all of Bodacious.
abstract class BodaciousAudioHandler extends BaseAudioHandler with SeekHandler {
  /// The current playback position.
  Duration get position => playbackState.value.position;
  Duration? get duration => mediaItem.value?.duration;
  bool get hasPrevious => false;
  bool get hasNext => false;

  Future<void> prepareFromTrackMetadata(TrackMetadata trackMetadata) async {
    queue.add([
      // reset the queue
      trackMetadata.asMediaItem()
    ]);
  }
  @override
  Future<BodaciousMediaItem?> getMediaItem(String mediaId) async {
    try {
      
      return (await db.tryGetTrackFromUri(Uri.file(mediaId)))?.asMediaItem();
    } catch(e) {
      return null;
    }
  }
}

class JustAudioHandler extends BodaciousAudioHandler {
  late final just.AudioPlayer player;
  JustAudioHandler() {
    player = just.AudioPlayer();
    // Set up the event pipeline
    player.playbackEventStream.listen((event) {
      //final now = _ref.read(nowPlayingProvider).asData!.value;
      mediaItem.add(mediaItem.value?.copyWith(duration: player.duration));
      playbackState.add(PlaybackState(
        playing: player.playing,
        controls: [
          //MediaControl(androidIcon: "drawable/ic_action_shuffle", label: "Shuffle", action: MediaAction.setShuffleMode)
          MediaControl.skipToPrevious,
          player.playing ? MediaControl.pause : MediaControl.play,
          MediaControl.skipToNext,
        ],
        updatePosition: event.updatePosition,
        updateTime: event.updateTime,
        systemActions: {
          MediaAction.setShuffleMode,
          MediaAction.seek,
          MediaAction.skipToPrevious,
          MediaAction.playPause,
          MediaAction.skipToNext,
        }
      ));
    });
  }

  @override
  prepareFromUri(uri, [extras]) => player.setAudioSource(just.ConcatenatingAudioSource(children: [
    just.AudioSource.uri(uri)
  ]));

  @override
  play() => player.play();
  @override
  pause() => player.pause();
  @override
  seek(Duration position) => player.seek(position);
  @override
  skipToNext() => player.seekToNext();
  @override
  skipToPrevious() => player.seekToPrevious();
  @override
  stop() => player.stop();

  @override
  addQueueItem(MediaItem mediaItem) async {
    if (player.audioSource is! just.ConcatenatingAudioSource) {
      player.setAudioSource(just.ConcatenatingAudioSource(children: []));
    }
    await (player.audioSource as just.ConcatenatingAudioSource).add(
      mediaItem is BodaciousMediaItem ? mediaItem.parent.asAudioSource()
      : just.AudioSource.uri(Uri.file(mediaItem.id))
    );
  }
  @override
  removeQueueItemAt(int index) async {
    if (player.audioSource is! just.ConcatenatingAudioSource) {
      return;
    }
    await (player.audioSource as just.ConcatenatingAudioSource).removeAt(index);
  }
  @override
  prepareFromTrackMetadata(TrackMetadata trackMetadata) {
    return player.setAudioSource(just.ConcatenatingAudioSource(children: [
      trackMetadata.asAudioSource()
    ]));
  }
}

class VlcAudioHandler extends BodaciousAudioHandler {
  late final vlc.Player player;
  bool _shuffling = false;
  AudioServiceRepeatMode _repeating = AudioServiceRepeatMode.none;

  static const Map<AudioServiceRepeatMode, vlc.PlaylistMode> repeatModes = {
    AudioServiceRepeatMode.all: vlc.PlaylistMode.repeat,
    AudioServiceRepeatMode.one: vlc.PlaylistMode.single,
    AudioServiceRepeatMode.none: vlc.PlaylistMode.loop
  };


  VlcAudioHandler() {
    player = vlc.Player(id: 0xb0da, commandlineArguments: ['--no-video']);
    // pipe the events from this player to the audio handler's events
    player.generalStream.listen(_incomingEvent);
    player.playbackStream.listen(_incomingEvent);
    player.positionStream.listen(_incomingEvent);
    player.currentStream.listen(_incomingEvent);
  }

  Future<void> _incomingEvent(dynamic event) async {
    if (event is vlc.GeneralState) {
      playbackState.add(playbackState.value.copyWith(
        speed: event.rate
      ));
    } else if (event is vlc.PlaybackState) {
      playbackState.add(playbackState.value.copyWith(
        playing: event.isPlaying,
        repeatMode: _repeating,
        //repeatMode: player.current.isPlaylist ?
        // (player.current.media as vlc.Playlist).playlistMode == vlc.PlaylistMode.loop ? AudioServiceRepeatMode.all
        // : (player.current.media as vlc.Playlist).playlistMode == vlc.PlaylistMode.repeat ? AudioServiceRepeatMode.one
        // : AudioServiceRepeatMode.none : AudioServiceRepeatMode.none,
        shuffleMode: _shuffling ? AudioServiceShuffleMode.all : AudioServiceShuffleMode.none,
      ));
      if (player.current.media is vlc.Playlist) {
        queue.add(await Future.wait((player.current.media as vlc.Playlist).medias.map((e) async => (await db.tryGetTrackFromUri(Uri.file(e.resource)))!.asMediaItem())));
      }
    } else if (event is vlc.PositionState) {
      if (event.position != null) {
        playbackState.add(playbackState.value.copyWith(
          updatePosition: event.position ?? const Duration(),
        ));
      }
      mediaItem.add(mediaItem.value is BodaciousMediaItem 
      ? (mediaItem.value as BodaciousMediaItem).parent.copyWith(duration: event.duration).asMediaItem()
      : mediaItem.value?.copyWith(duration: event.duration));
    } else if (event is vlc.CurrentState) {
      if (event.media != null) {
        mediaItem.add(MediaItem(
          id: event.media!.resource,
          title: event.media!.metas["Title"] ?? event.media!.metas["title"] ?? Uri.parse(event.media!.resource).pathSegments.lastOrNull ?? "Nothing is playing"
        ));
        if (event.isPlaylist) {
          queue.add(event.medias.map((e) => MediaItem(
            id: e.resource,
            title: e.metas["Title"] ?? e.metas["title"] ?? Uri.parse(e.resource).pathSegments.lastOrNull ?? "Unknown track"
          )).toList());
        }
        // TrackMetadata? _record;
        // try {
        //   TrackMetadata.fromJson((await songStore.findFirst(db, finder: Finder(filter: Filter.and([
        //     Filter.equals('uri', Uri.file(event.media!.resource))
        //   ]))))?.value ?? {'uri': Uri.file(event.media!.resource)});
        // } finally {}
        // _ref.read(nowPlayingProvider.notifier).changeTrack(_record ?? TrackMetadata(
        //   uri: Uri.file(event.media!.resource),
        //   title: event.media!.metas["Title"] ?? event.media!.metas["title"] ?? Uri.file(event.media!.resource).pathSegments.lastOrNull ?? "Untitled"
        // ));
        // This will be handled by the nowPlayingProvider on its own :hug:
      } else {
        mediaItem.add(null);
      }
    }
  }


  @override
  prepareFromUri(uri, [extras]) => Future.sync(() => player.open(
    vlc.Playlist(
      medias: [
        vlc.Media.file(File.fromUri(uri))
      ]
    ),
    autoStart: false
  ));
  @override
  prepareFromTrackMetadata(TrackMetadata trackMetadata) => Future.sync(() => player.open(
    vlc.Playlist(
      medias: [
        trackMetadata.asVlcMedia()
      ]
    ),
    autoStart: false
  ));

  @override
  play() => Future.sync(() => player.play());
  //.then((value) => playbackState.add(playbackState.value.copyWith(playing: true)));
  @override
  pause() => Future.sync(() => player.pause())
  .then((value) => playbackState.add(playbackState.value.copyWith(playing: false)));
  @override
  seek(Duration position) => Future.sync(() => player.seek(position))
  .then((value) => playbackState.add(playbackState.value.copyWith(updatePosition: position)));
  @override
  skipToNext() => Future.sync(() => player.next());
  @override
  skipToPrevious() => Future.sync(() => player.back());
  @override
  stop() => Future.sync(() => player.stop()).then((_) => super.stop());

  @override
  addQueueItem(MediaItem mediaItem) async {
    if (player.current.isPlaylist) {
      player.current.medias.add(vlc.Media.file(File(mediaItem.id)));
      // a more complex solution may be needed
      // when network resources come into play
    } else {
      await updateQueue([mediaItem]);
    }
    return super.addQueueItem(mediaItem);
  }
  @override
  updateQueue(List<MediaItem> queue) async {
    player.open(vlc.Playlist(
      medias: queue.map((e) => vlc.Media.file(File.fromUri(Uri.parse(e.id)))).toList()
    ));
    return super.updateQueue(queue);
  }
  @override
  skipToQueueItem(int index) {
    player.jump(index);
    return super.skipToQueueItem(index);
  }
  @override
  Future<void> removeQueueItemAt(int index) {
    player.remove(index);
    return super.removeQueueItemAt(index);
  }

  @override
  Future<void> setShuffleMode(AudioServiceShuffleMode shuffleMode) {
    throw UnsupportedError("You cannot set shuffle on this device.");
    return super.setShuffleMode(shuffleMode);
  }
  @override
  Future<void> setRepeatMode(AudioServiceRepeatMode repeatMode) async {
    if (repeatMode == AudioServiceRepeatMode.group) throw UnsupportedError("Group repeat is not supported");
    _repeating = repeatMode;
    playbackState.add(playbackState.value.copyWith(
      repeatMode: _repeating,
    ));
    return player.setPlaylistMode(repeatModes[repeatMode]!);
  }
}