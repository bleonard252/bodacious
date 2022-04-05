part of 'audio_service.dart';

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
      } else {
        mediaItem.add(null);
      }
    }
  }

  @override
  int? get currentIndex => player.current.index;

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
  skipToNext() => Future.sync(() => player.current.index == null ? player.next() : player.jump(player.current.index!+1));
  @override
  skipToPrevious() => Future.sync(() => player.current.index == null ? player.back() : player.jump(player.current.index!-1));
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
  insertQueueItem(int index, MediaItem mediaItem) async {
    if (player.current.isPlaylist) {
      player.insert(index, vlc.Media.file(File(Uri.parse(mediaItem.id).toFilePath())));
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