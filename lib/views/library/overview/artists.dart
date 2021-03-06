
import 'package:bodacious/main.dart';
import 'package:bodacious/models/artist_data.dart';
import 'package:bodacious/widgets/item/artist.dart';
import 'package:drift/drift.dart' hide Column;
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


class ArtistLibraryList extends ConsumerWidget {
  const ArtistLibraryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<int>(
      stream: (db.selectOnly(db.artistTable)..addColumns([db.artistTable.id])).watch().map(((value) => value.length)),
      builder: (context, snapshot) {
        return CustomScrollView(
          slivers: [
            if (snapshot.hasError) SliverFillRemaining(child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Icon(MdiIcons.alertCircle, color: Colors.red),
                  ),
                  Text(snapshot.error.toString(), textAlign: TextAlign.center, style: const TextStyle(color: Colors.red))
                ]
              )
            ))
            else if (!snapshot.hasData) const SliverFillRemaining(child: Center(child: CircularProgressIndicator(value: null)))
            else SliverList(
              //itemExtent: 72.0,
              delegate: SliverChildBuilderDelegate(
                (context, index) => FutureBuilder<ArtistMetadata>(
                  future: (
                    db.select(db.artistTable)
                    ..orderBy([
                      (tbl) => OrderingTerm.asc(tbl.name)
                    ])
                    ..limit(1, offset: index)
                  ).getSingle(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return Container(height: 72);
                    final artist = snapshot.data!;
                    return ArtistWidget(artist);
                  },
                ),
                childCount: snapshot.data ?? 0
              )
            ),
          ],
        );
      }
    );
  }
}