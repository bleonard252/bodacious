import 'package:dart_discord_rpc/dart_discord_rpc.dart';

import '../main.dart';

Future<void> startDiscordRpc() async {
  await player.mediaItem.listen((value) async {
    if (!config.discordRpc) return;
    if (value == null) {
      discord.clearPresence();
    } else {
      final lik = value.album != null && value.artist != null ? (await db.tryGetAlbum(value.album!, by: value.artist!)) : null;
      final lik2 = value.artist != null ? (await db.tryGetArtist(value.artist!)) : null;
      discord.updatePresence(DiscordPresence(
        details: value.title,
        state: value.artist != null ? "by "+value.artist! : null,
        largeImageText: value.album,
        //largeImageKey: "BoUnknown", // someday we're gonna get public URLs for these album covers
        largeImageKey: lik?.coverUriRemote.toString(),
        smallImageKey: lik2?.coverUriRemote.toString(),
        smallImageText: value.artist,
        endTimeStamp: value.duration != null ? DateTime.now().add(value.duration ?? Duration.zero).add(-player.position).millisecondsSinceEpoch : null
      ));
    }
  }).asFuture();
}