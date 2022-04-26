import 'package:dart_discord_rpc/dart_discord_rpc.dart';

import '../main.dart';

Future<void> startDiscordRpc() async {
  player.mediaItem.listen((value) {
    if (value == null) {
      discord.clearPresence();
    } else {
      discord.updatePresence(DiscordPresence(
        details: value.title,
        state: value.artist,
        largeImageText: value.album,
        //largeImageKey: "BoUnknown", // someday we're gonna get public URLs for these album covers
        endTimeStamp: value.duration != null ? DateTime.now().add(value.duration ?? Duration.zero).add(-player.position).millisecondsSinceEpoch : null
      ));
    }
  }, onError: (error) => errors.add(error.toString()));
}