import 'dart:async';
import 'dart:io';

import 'package:bodacious/main.dart';
import 'package:bodacious/src/library/indexer.dart';
import 'package:bodacious/src/online/lastfm.dart';
import 'package:bodacious/widgets/indexer_progress.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:go_router/go_router.dart';
import 'package:lastfm/lastfm.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:simple_icons/simple_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class OnlineServicesSettingsView extends StatefulWidget {
  const OnlineServicesSettingsView({ Key? key }) : super(key: key);

  @override
  State<OnlineServicesSettingsView> createState() => _OnlineServicesSettingsViewState();
}

class _OnlineServicesSettingsViewState extends State<OnlineServicesSettingsView> {  
  @override
  Widget build(BuildContext context) {
    final _children = [
      // LAST.FM SECTION
      if (apiKeys.lastfmApiKey != null) ...[
        ListTile(
          leading: const Icon(SimpleIcons.lastdotfm, color: Color(0xffd51007)),
          title: Text("Last.fm", style: Theme.of(context).textTheme.headline6),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
        ),
        SwitchListTile(
          title: const Text("Use Last.fm for library information"),
          subtitle: const Text("When this is on, Bodacious checks Last.fm when refreshing the library or when editing the library."),
          value: config.lastFmIntegration,
          onChanged: (value) async {
            setState(() => config.lastFmIntegration = value);
          },
        ),
        StatefulBuilder(builder: (context, setState) => 
          (config.lastFmToken == null) ? ListTile(
            title: const Text("Log in to Last.fm"),
            onTap: () async {
              final _lastfm = LastFMUnauthorized(apiKeys.lastfmApiKey!, apiKeys.lastfmSecret, "Bodacious/0.5.0 <https://github.com/bleonard252/bodacious>");
              if (!await launchUrl(Uri.parse(await _lastfm.authorizeDesktop()))) {
                await showDialog(context: context, builder: (context) => const AlertDialog(
                  content: Text("Last.fm authorization failed")
                ));
                return;
              }
              await showDialog(context: context, builder: (context) => const AlertDialog(
                title: Text("Authorizing in your browser"),
                content: Text("Once you've authorized Bodacious, press OK."),
              ));
              lastfm = await _lastfm.finishAuthorizeDesktop();
              config.lastFmToken = (lastfm as LastFMAuthorized).sessionKey;
              config.lastFmUsername = (lastfm as LastFMAuthorized).username;
              setState(() {});
            },
          ) : ListTile(
            title: const Text("Log out of Last.fm"),
            subtitle: Text("You're signed in as ${config.lastFmUsername}"),
            onTap: () async {
              final r = await showDialog<bool>(context: context, builder: (context) => AlertDialog(
                title: const Text("Are you sure?"),
                content: const Text("As soon as you sign out, communication with Last.fm will stop."),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("No")),
                  TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("Yes"))
                ],
              )) ?? false;
              if (!r) return;
              lastfm = null;
              config.lastFmToken = null;
              config.lastFmUsername = null;
              setState(() {});
            },
          )
        ),
        SwitchListTile(
          title: const Text("Enable scrobbling"),
          subtitle: const Text("Send Last.fm information about what you're listening to."),
          value: config.lastFmScrobbling,
          onChanged: (value) async {
            setState(() => config.lastFmScrobbling = value);
          },
        ),
        const Divider(),
      ],
      // SPOTIFY SECTION
      if (apiKeys.spotifyClientId != null) ...[
        ListTile(
          leading: const Icon(MdiIcons.spotify, color: Color(0xff1DB954)),
          title: Text("Spotify", style: Theme.of(context).textTheme.headline6),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
        ),
        SwitchListTile(
          title: const Text("Use Spotify for library information"),
          subtitle: const Text("When this is on, Bodacious checks Spotify when refreshing the library or when editing the library."),
          value: config.spotifyIntegration,
          onChanged: (value) async {
            setState(() => config.spotifyIntegration = value);
          },
        ),
        const Divider(),
      ],
      // DISCORD SECTION
      if ((Platform.isLinux || Platform.isWindows) && apiKeys.discordAppId != null) ...[
        ListTile(
          leading: const Icon(SimpleIcons.discord, color: Color(0xff5865F2)),
          title: Text("Discord", style: Theme.of(context).textTheme.headline6),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
        ),
        SwitchListTile(
          title: const Text("Show what you're listening to on Discord"),
          value: config.discordRpc,
          onChanged: (value) async {
            setState(() => config.discordRpc = value);
          },
        ),
      ]
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Services", style: TextStyle(color: Colors.blue)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: _children.isNotEmpty ? ListView(
        children: _children,
      ) : const Center(child: Text("No services available. Make sure the app was built with API keys."))
    );
  }
}