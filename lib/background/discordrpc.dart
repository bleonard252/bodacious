import 'package:bodacious/models/track_data.dart';
import 'package:dart_discord_rpc/dart_discord_rpc.dart';

import '../main.dart';

Future<void> startDiscordRpc() async {
  await player.mediaItem.listen((value) async {
    if (value == null) {
      discord.clearPresence();
    } else {
      final lik = value.album != null && value.artist != null ? (await db.tryGetAlbum(value.album!, by: value.artist!)) : null;
      discord.updatePresence(DiscordPresence(
        details: value.title,
        state: value.artist,
        largeImageText: value.album,
        //largeImageKey: "BoUnknown", // someday we're gonna get public URLs for these album covers
        largeImageKey: lik?.coverUriRemote.toString(),
        endTimeStamp: value.duration != null ? DateTime.now().add(value.duration ?? Duration.zero).add(-player.position).millisecondsSinceEpoch : null
      ));
    }
  }).asFuture();
}