import 'package:bodacious/widgets/indexer_progress.dart';
import "package:flutter/material.dart";
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MobileMainMenu extends StatelessWidget {
  const MobileMainMenu({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        bottom: false,
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(MdiIcons.cog),
              title: const Text("Settings"),
              onTap: () => context.go("/settings"),
            ),
            const IndexerProgressWidget(),
            ListTile(
              leading: const Icon(MdiIcons.alertOctagonOutline),
              title: const Text("Logs"),
              onTap: () => context.push("/Logs"),
            ),
            ListTile(
              leading: const Icon(MdiIcons.informationOutline),
              title: const Text("About"),
              onTap: () => context.push("/about"),
            ),
          ],
        )
      ),
    );
  }
}