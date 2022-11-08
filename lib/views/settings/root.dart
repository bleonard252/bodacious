import 'package:bodacious/main.dart';
import "package:flutter/material.dart";
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SettingsHome extends StatelessWidget {
  const SettingsHome({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.green,
              child: Icon(MdiIcons.palette, color: Colors.black),
            ),
            title: const Text("Personalization"),
            subtitle: const Text("Make Bodacious yours"),
            onTap: () => context.go("/settings/personalization")
          ),
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.orange,
              child: Icon(MdiIcons.viewList, color: Colors.black),
            ),
            title: const Text("Library"),
            subtitle: const Text("Where should we find your music?"),
            onTap: () => context.go("/settings/library")
          ),
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.pink,
              child: Icon(MdiIcons.speaker, color: Colors.black),
            ),
            enabled: false,
            title: const Text("Behavior"),
            subtitle: const Text("How would Bo work best for you?"),
            onTap: () => context.go("/settings/behavior")
          ),
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(MdiIcons.web, color: Colors.black),
            ),
            enabled: apiKeys.discordAppId.exists() || apiKeys.lastfmApiKey.exists() || apiKeys.spotifyClientId.exists(),
            title: const Text("Services"),
            subtitle: const Text("Last.fm and Spotify integrations"),
            onTap: () => context.go("/settings/services")
          ),
        ],
      ),
    );
  }
}

extension on String? {
  bool exists() {
    return this?.isNotEmpty ?? false;
  }
}