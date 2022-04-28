
import 'package:bodacious/main.dart';
import "package:flutter/material.dart";

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