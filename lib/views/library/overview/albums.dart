
import 'package:bodacious/main.dart';
import 'package:bodacious/models/album_data.dart';
import 'package:bodacious/widgets/item/album.dart';
import 'package:drift/drift.dart' hide Column;
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


class AlbumLibraryList extends ConsumerWidget {
  const AlbumLibraryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<int>(
      initialData: 0,
      stream: (db.selectOnly(db.albumTable)..addColumns([db.albumTable.id])).watch().map<int>((event) => event.length),
      builder: (context, snapshot) {
        return CustomScrollView(
          slivers: [
            if (snapshot.hasError) SliverFillRemaining(child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(MdiIcons.alertCircle, color: Colors.red),
                  ),
                  Text(snapshot.error.toString(), textAlign: TextAlign.center, style: const TextStyle(color: Colors.red))
                ]
              )
            ))
            else if (!snapshot.hasData) const SliverFillRemaining(child: Center(child: CircularProgressIndicator(value: null)))
            else if (snapshot.data == 0) SliverFillRemaining(
              child: Center(
                child: Material(
                  type: MaterialType.card,
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(MdiIcons.ghost, color: Colors.lightBlue),
                        ),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 300),
                          child: const Text("No albums found. Add a music folder in Settings > Library.", textAlign: TextAlign.center)
                        )
                      ]
                    ),
                  )
                )
              )
            )
            else SliverList(
              //itemExtent: 72.0,
              delegate: SliverChildBuilderDelegate(
                (context, index) => FutureBuilder<AlbumMetadata>(
                  future: (
                    db.select(db.albumTable)
                    ..orderBy([
                      (tbl) => OrderingTerm.desc(tbl.year),
                      (tbl) => OrderingTerm.asc(tbl.name),
                    ])
                    ..limit(1, offset: index)
                  ).getSingle(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return Container(height: 72);
                    final album = snapshot.data!;
                    return AlbumWidget(album);
                  },
                ),
                childCount: snapshot.data ?? 0
              )
            )
          ]
        );
      }
    );
  }
}