import 'dart:io';

import 'package:bodacious/main.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PersonalizationSettingsView extends StatefulWidget {
  const PersonalizationSettingsView({ Key? key }) : super(key: key);

  @override
  State<PersonalizationSettingsView> createState() => _PersonalizationSettingsViewState();
}

class _PersonalizationSettingsViewState extends State<PersonalizationSettingsView> {  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Library", style: TextStyle(color: Colors.green)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          bottom: const TabBar(tabs: [
            Tab(child: Text("Now Playing"))
          ]),
        ),
        body: TabBarView(
          children: [
            ListView(
              children: [
                SwitchListTile(
                  title: const Text("Compact Now Playing on sidebar"),
                  subtitle: const Text("Show a compact \"Now Playing\" bar on the sidebar. "
                  "Only applicable on wider displays, where the sidebar appears."),
                  value: config.wideCompactNowPlaying,
                  onChanged: (value) async {
                    setState(() => config.wideCompactNowPlaying = value);
                  },
                ),
              ],
            )
          ]
        )
      ),
    );
  }
}