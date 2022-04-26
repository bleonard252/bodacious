

import 'package:audio_service/audio_service.dart';
import 'package:bodacious/main.dart';
import 'package:bodacious/src/online/lastfm.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lastfm/lastfm.dart';

Future<void> startScrobbling() async {
  String? last;
  Future<void> scrobble() async {
    if (lastfm is LastFMAuthorized && config.lastFmToken != null) {
      if (player.mediaItem.valueOrNull?.artist == null) return;
      if (player.mediaItem.value?.id == last) return;
      if (kDebugMode) {
        print("Scrobbling...");
      }
      await (lastfm as LastFMAuthorized).scrobble(track: player.mediaItem.value!.title, artist: player.mediaItem.value!.artist!, album: player.mediaItem.value!.album!);
      if (kDebugMode) {
        print("Scrobbling successful");
      }
      last = player.mediaItem.value?.id;
    }
  }

  bool running = false;
  await player.playbackState.listen((value) async {
    if (running) return;
    running = true;
    if (value.position >= const Duration(minutes: 4)) {
      await scrobble();
    } else if (value.position.inSeconds >= (player.mediaItem.value?.duration ?? Duration.zero).inSeconds / 2) {
      await scrobble();
    }
    running = false;
  }).asFuture();
}

Future<void> startLastFmNowPlaying() async {
  String? last;
  Future<void> scrobble() async {
    if (lastfm is LastFMAuthorized && config.lastFmToken != null) {
      if (player.mediaItem.value?.id == last) return;
      if (player.mediaItem.valueOrNull?.artist == null) return;
      if (kDebugMode) {
        print("Telling last.fm about our new song...");
      }
      await (lastfm as LastFMAuthorized).updateNowPlaying(track: player.mediaItem.value!.title, artist: player.mediaItem.value!.artist!, album: player.mediaItem.value!.album!);
      if (kDebugMode) {
        print("NP update done");
      }
      last = player.mediaItem.value?.id;
    }
  }

  bool running = false;
  await player.mediaItem.listen((value) async {
    if (running) return;
    running = true;
    await scrobble();
    running = false;
  }).asFuture();
}