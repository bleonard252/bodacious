part of 'audio_service.dart';

class JustAudioHandler extends BodaciousAudioHandler {
  late final just.AudioPlayer player;
  JustAudioHandler() {
    player = just.AudioPlayer();
    void playlist(just.AudioSource current, dynamic output, [int? index]) {
      if (current is just.UriAudioSource) {
        if (index != player.currentIndex) {
          late String _title;
          try {_title = Uri.decodeComponent(current.uri.pathSegments.lastOrNull ?? "Unknown track");}
          catch(e) {_title = current.uri.pathSegments.lastOrNull ?? "Unknown track";}
          output.add(MediaItem(
            id: current.uri.toString(),
            title: _title
          ));
        } else {
          output.add(mediaItem.valueOrNull?.copyWith(id: current.uri.toString()) ?? MediaItem(
            id: current.uri.toString(),
            title: current.uri.pathSegments.lastOrNull ?? "Unknown track"
          ));
        }
        // db.tryGetTrackFromUri(current.uri)
        // .then((value) => value == null ? null : output.add(value.asMediaItem()));
      } else {
        errors.add("An invalid audio source was found (JustAudio)");
      }
    }
    // Set up the event pipeline
    player.playbackEventStream.listen((event) {
      //final now = _ref.read(nowPlayingProvider).asData!.value;
      if (player.audioSource is just.UriAudioSource) {
        //mediaItem.add(MediaItem(id: (player.audioSource as just.UriAudioSource).uri.toString(), title: (player.audioSource as just.UriAudioSource).uri.pathSegments.lastOrNull ?? "Unknown track"));
        mediaItem.add(mediaItem.valueOrNull?.copyWith(id: (player.audioSource as just.UriAudioSource).uri.toString()) ?? MediaItem(
          id: (player.audioSource as just.UriAudioSource).uri.toString(),
          title: (player.audioSource as just.UriAudioSource).uri.pathSegments.lastOrNull ?? "Unknown track"
        ));
        // db.tryGetTrackFromUri((player.audioSource as just.UriAudioSource).uri)
        // .then((value) => value == null ? null : mediaItem.add(value.asMediaItem()));
        queue.add([mediaItem.value!]);
      } else if (player.audioSource is just.ConcatenatingAudioSource) {
        if ((player.audioSource as just.ConcatenatingAudioSource).children.isEmpty) return queue.add([]);
        final current = (player.audioSource as just.ConcatenatingAudioSource).children.elementAt(player.currentIndex ?? 0);
        playlist(current, mediaItem, player.currentIndex);
        final List<MediaItem> _queue = [];
        for (final mediaItem in (player.audioSource as just.ConcatenatingAudioSource).children) {
          playlist(mediaItem, _queue);
        }
        queue.add(_queue);
      } else if (player.audioSource == null) {return mediaItem.add(null);}
      if (mediaItem.valueOrNull != null) mediaItem.add(mediaItem.value!.copyWith(duration: player.duration));
      playbackState.add(PlaybackState(
        playing: player.playing,
        processingState: AudioProcessingState.ready,
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
      mediaItem.add(mediaItem.value?.copyWith(duration: event.duration));
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
  updateQueue(List<MediaItem> queue, [int? index]) async {
    player.setAudioSource(just.ConcatenatingAudioSource(children: [
      for (final mediaItem in queue)
      just.AudioSource.uri(Uri.parse(mediaItem.id))
    ]), initialIndex: index);
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