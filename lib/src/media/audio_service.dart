import 'package:audio_service/audio_service.dart';
import 'package:bodacious/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mime/mime.dart';

class BodaciousBackgroundService extends BaseAudioHandler with SeekHandler {
  final AudioPlayer player;
  late final ProviderBase nowPlaying;
  BodaciousBackgroundService(this.player) {
    player.playbackEventStream.listen((event) {
      if (playerBackgroundRef == null) return;
      final now = playerBackgroundRef!.read(nowPlayingProvider);
      mediaItem.add(MediaItem(
        id: (player.audioSource is UriAudioSource) ? (player.audioSource as UriAudioSource).uri.toString() 
        : player.audioSource.toString(),
        title: now.title ??
          ((player.audioSource is UriAudioSource) ? (player.audioSource as UriAudioSource).uri.toString() 
          : "Untitled track"),
        artist: now.artistName,
        album: now.albumName,
        artUri: now.coverUri, // ?? (now.coverBytes != null ? (player.audioSource as UriAudioSource).uri.resolve("cover.jpg") : null),
        duration: player.duration,
      ));
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


}