import 'dart:async';
import 'dart:io';

import 'package:bodacious/main.dart';
import 'package:bodacious/src/library/indexer.dart';
import 'package:bodacious/widgets/indexer_progress.dart';
import 'package:file_picker/file_picker.dart';
import "package:flutter/material.dart";
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LibrarySettingsView extends StatefulWidget {
  const LibrarySettingsView({ Key? key }) : super(key: key);

  @override
  State<LibrarySettingsView> createState() => _LibrarySettingsViewState();
}

class _LibrarySettingsViewState extends State<LibrarySettingsView> {
  List<String> libraryDirs = List.from(config.libraries);
  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Library", style: TextStyle(color: Colors.orange)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          bottom: const TabBar(tabs: [
            Tab(child: Text("Options")),
            Tab(child: Text("Collections")),
          ]),
        ),
        body: TabBarView(
          children: [
            ListView(
              children: [
                const IndexerProgressWidget(),
                if (Platform.isAndroid) SwitchListTile(
                  title: const Text("Use Android media library"),
                  subtitle: const Text("Import your phone's music library automatically. "
                  "Use this if you want a \"set it and forget it\" library like "
                  "most other Android music player apps.\n"
                  "This makes the below unusable."),
                  value: config.useSystemLibrary,
                  onChanged: null
                  // (value) async {
                  //   setState(() => useSystemLibrary = value);
                  // },
                ),
                StreamBuilder<IndexerProgressReport>(
                  stream: TheIndexer.progress,
                  initialData: TheIndexer.progress.valueOrNull,
                  builder: (context, snapshot) {
                    return ListTile(
                      enabled: snapshot.data?.state == IndexerState.FINISHED || snapshot.data == null,
                      title: const Text("Force re-scan"),
                      subtitle: const Text("Scan your library again to update tags on existing files."),
                      onTap: snapshot.data?.state == IndexerState.FINISHED || snapshot.data == null ? () async {
                        unawaited(TheIndexer.spawn(force: true));
                      } : null,
                    );
                  }
                ),
              ]
            ),
            ListView(
              children: [
                for (final dir in config.libraries) Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        child: Text(dir, maxLines: 1, overflow: TextOverflow.ellipsis),
                      ),
                    ),
                    Tooltip(
                      message: "Remove from library",
                      child: IconButton(onPressed: () {
                        libraryDirs.remove(dir);
                        config.libraries = libraryDirs;
                        setState(() {});
                      }, icon: const Icon(MdiIcons.close)),
                    )
                  ],
                ),
                ListTile(
                  title: const Text("Add new library folder"),
                  leading: const Icon(MdiIcons.plus),
                  onTap: () async {
                    final library = await FilePicker.platform.getDirectoryPath(
                      dialogTitle: "Select a music library root"
                    );
                    if (library?.isNotEmpty != true) return;
                    libraryDirs.add(library!);
                    config.libraries = libraryDirs;
                    setState(() {});
                  },
                )
              ],
            ),
          ],
        )
      ),
    );
  }
}