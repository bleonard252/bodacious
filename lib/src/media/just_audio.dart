part of 'audio_service.dart';

class JustAudioHandler extends BodaciousAudioHandler {
  late final just.AudioPlayer player;
  JustAudioHandler() {
    player = just.AudioPlayer();
    void playlist(just.AudioSource current, dynamic output) {
      if (current is just.UriAudioSource) {
        output.add(MediaItem(
          id: current.uri.toString(),
          title: Uri.decodeComponent(current.uri.pathSegments.lastOrNull ?? "Unknown track")
        ));
        // db.tryGetTrackFromUri(current.uri)
        // .then((value) => value == null ? null : output.add(value.asMediaItem()));
      } else {
        print("How did we get here?");
      }
    }
    // Set up the event pipeline
    player.playbackEventStream.listen((event) {
      //final now = _ref.read(nowPlayingProvider).asData!.value;
      if (player.audioSource is just.UriAudioSource) {
        mediaItem.add(MediaItem(id: (player.audioSource as just.UriAudioSource).uri.toString(), title: (player.audioSource as just.UriAudioSource).uri.pathSegments.lastOrNull ?? "Unknown track"));
        // db.tryGetTrackFromUri((player.audioSource as just.UriAudioSource).uri)
        // .then((value) => value == null ? null : mediaItem.add(value.asMediaItem()));
        queue.add([mediaItem.value!]);
      } else if (player.audioSource is just.ConcatenatingAudioSource) {
        final current = (player.audioSource as just.ConcatenatingAudioSource).children.elementAt(player.currentIndex ?? 0);
        playlist(current, mediaItem);
        final List<MediaItem> _queue = [];
        for (final mediaItem in (player.audioSource as just.ConcatenatingAudioSource).children) {
          playlist(mediaItem, _queue);
        }
        queue.add(_queue);
      } else if (player.audioSource == null) {} else {
        print("How did I get here?");
      }
      if (mediaItem.valueOrNull != null) mediaItem.add(mediaItem.value!.copyWith(duration: player.duration));
      playbackState.add(PlaybackState(
        playing: player.playing,
        controls: [
          //MediaControl(androidIcon: "drawable/ic_action_shuffle", label: "Shuffle", action: MediaAction.setShuffleMode)
          MediaControl.skipToPrevious,
          player.playing ? MediaControl.pause : MediaControl.play,
          MediaControl.skipToNext,
        ],
        shuffleMode: player.shuffleModeEnabled ? AudioServiceShuffleMode.all : AudioServiceShuffleMode.none,
        repeatMode: player.loopMode == just.LoopMode.all ? AudioServiceRepeatMode.all
        : player.loopMode == just.LoopMode.one ? AudioServiceRepeatMode.one
        : AudioServiceRepeatMode.none,
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
    player.sequenceStream.listen((event) {
      final List<MediaItem> _queue = [];
      for (final mediaItem in event ?? []) {
        playlist(mediaItem, _queue);
      }
      queue.add(_queue);
    });
    player.positionStream.listen((event) {
      playbackState.add(playbackState.value.copyWith(updatePosition: event));
    });
    player.shuffleModeEnabledStream.listen((event) {
      playbackState.add(playbackState.value.copyWith(shuffleMode: event ? AudioServiceShuffleMode.all : AudioServiceShuffleMode.none));
    });
    player.loopModeStream.listen((event) {
      playbackState.add(playbackState.value.copyWith(repeatMode: event == just.LoopMode.all ? AudioServiceRepeatMode.all
        : event == just.LoopMode.one ? AudioServiceRepeatMode.one : AudioServiceRepeatMode.none));
    });
  }

  @override
  int? get currentIndex => player.currentIndex;

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
      just.AudioSource.uri(Uri.parse(mediaItem.id))
    );
  }
  @override
  updateQueue(List<MediaItem> queue) async {
    player.setAudioSource(just.ConcatenatingAudioSource(children: [
      for (final mediaItem in queue)
      just.AudioSource.uri(Uri.parse(mediaItem.id))
    ]));
  }
  @override
  insertQueueItem(int index, MediaItem mediaItem) async {
    if (player.audioSource is! just.ConcatenatingAudioSource) {
      player.setAudioSource(just.ConcatenatingAudioSource(children: []));
    }
    await (player.audioSource as just.ConcatenatingAudioSource).insert(
      index,
      just.AudioSource.uri(Uri.parse(mediaItem.id))
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
  Future<void> skipToQueueItem(int index) async {
    if (player.audioSource is! just.ConcatenatingAudioSource) {
      return;
    }
    return await player.seek(Duration.zero, index: index);
  }
  @override
  prepareFromTrackMetadata(TrackMetadata trackMetadata) {
    return player.setAudioSource(just.ConcatenatingAudioSource(children: [
      just.AudioSource.uri(trackMetadata.uri)
    ]));
  }

  @override
  setShuffleMode(AudioServiceShuffleMode shuffleMode) => player.setShuffleModeEnabled(shuffleMode == AudioServiceShuffleMode.all);
  @override
  setRepeatMode(AudioServiceRepeatMode repeatMode) => player.setLoopMode(
    repeatMode == AudioServiceRepeatMode.all ? just.LoopMode.all
    : repeatMode == AudioServiceRepeatMode.one ? just.LoopMode.one
    : just.LoopMode.off
  );
}