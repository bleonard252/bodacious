import 'package:bodacious/main.dart';
import 'package:bodacious/src/online/lastfm.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:lastfm/lastfm.dart';

Future<void> startScrobbling() async {
  String? last;
  Future<void> scrobble(Duration position) async {
    if (config.lastFmScrobbling == false) return await Future.delayed(const Duration(milliseconds: 10000)); // wait 10 seconds so that it doesn't trip again
    if (lastfm is LastFMAuthorized && config.lastFmToken != null) {
      if (player.mediaItem.valueOrNull?.artist == null) return;
      if (player.mediaItem.value?.id == last) return;
      if (player.mediaItem.value?.duration == null) return;
      // if (kDebugMode) {
      //   print("Scrobbling..."+(player.mediaItem.value?.id ?? ""));
      // }
      try {
        await (lastfm as LastFMAuthorized).scrobble(
          track: player.mediaItem.value!.title,
          artist: player.mediaItem.value!.artist!, 
          album: player.mediaItem.value!.album!,
          startTime: DateTime.now().toUtc().subtract(position)
        );
      } on DioError {return await Future.delayed(const Duration(milliseconds: 60000));}
      // if (kDebugMode) {
      //   print("Scrobbling successful");
      // }
      last = player.mediaItem.value?.id;
    }
  }

  bool running = false;
  await player.playbackState.listen((value) async {
    if (running) return;
    running = true;
    if (player.position >= const Duration(minutes: 4)) {
      await scrobble(player.position);
    } else if (player.position.inSeconds >= (player.mediaItem.value?.duration ?? Duration.zero).inSeconds / 2) {
      await scrobble(player.position);
    }
    running = false;
  }).asFuture();
}

Future<void> startLastFmNowPlaying() async {
  String? last;
  Future<void> scrobble() async {
    if (config.lastFmScrobbling == false) return await Future.delayed(const Duration(milliseconds: 10000)); // wait 10 seconds so that it doesn't trip again
    if (lastfm is LastFMAuthorized && config.lastFmToken != null) {
      if (player.mediaItem.value?.id == last) return;
      if (player.mediaItem.valueOrNull?.artist == null) return;
      // if (kDebugMode) {
      //   print("Telling last.fm about our new song..."+(player.mediaItem.value?.id ?? ""));
      // }
      try {
        await (lastfm as LastFMAuthorized).updateNowPlaying(track: player.mediaItem.value!.title, artist: player.mediaItem.value!.artist!, album: player.mediaItem.value!.album!);
      } on DioError {return await Future.delayed(const Duration(milliseconds: 60000));}
      // if (kDebugMode) {
      //   print("NP update done");
      // }
      last = player.mediaItem.value?.id;
    }
  }

  bool running = false;
  await player.mediaItem.listen((value) async {
    if (running) return;
    running = true;
    await Future.delayed(const Duration(milliseconds: 500)); // mostly a workaround tbh
    await scrobble();
    running = false;
  }).asFuture();
}