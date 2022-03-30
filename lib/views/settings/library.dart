import 'dart:io';

import 'package:bodacious/main.dart';
import 'package:bodacious/src/library/init_db.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sembast/sembast.dart';

class LibrarySettingsView extends StatefulWidget {
  const LibrarySettingsView({ Key? key }) : super(key: key);

  @override
  State<LibrarySettingsView> createState() => _LibrarySettingsViewState();
}

class _LibrarySettingsViewState extends State<LibrarySettingsView> {
  bool? useSystemLibrary;
  List<String> libraryDirs = [];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Library", style: TextStyle(color: Colors.orange)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: () async {
          useSystemLibrary = await configStore.record("use-system-library").get(db) ?? false;
          libraryDirs = List.castFrom<dynamic, String>((await configStore.record("libraries").get(db))?.toList() ?? []);
          return true;
        }(),
        builder: (context, snapshot) {
          return ListView(
            children: [
              if (Platform.isAndroid) SwitchListTile(
                title: const Text("Use Android media library"),
                subtitle: const Text("Import your phone's music library automatically. "
                "Use this if you want a \"set it and forget it\" library like "
                "most other Android music player apps.\n"
                "This makes the below unusable."),
                value: useSystemLibrary ?? false,
                onChanged: null
                // (value) async {
                //   await configStore.record("use-system-library").put(db, value);
                //   setState(() => useSystemLibrary = value);
                // },
              ),
              for (final dir in libraryDirs) Row(
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
                    child: IconButton(onPressed: () => setState(() {
                      libraryDirs.remove(dir);
                    }), icon: const Icon(MdiIcons.close)),
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
                  await configStore.record("libraries").put(db, libraryDirs);
                  if (kDebugMode) {
                    print(await configStore.record("libraries").get(db));
                  }
                  setState(() {});
                },
              )
            ],
          );
        }
      ),
    );
  }
}