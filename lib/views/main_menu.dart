import 'package:bodacious/src/library/indexer.dart';
import 'package:bodacious/widgets/indexer_progress.dart';
import "package:flutter/material.dart";
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
              onTap: () {},
            ),
            const IndexerProgressWidget()
          ],
        )
      ),
    );
  }
}