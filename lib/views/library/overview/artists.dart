
import 'package:bodacious/main.dart';
import 'package:bodacious/models/artist_data.dart';
import 'package:bodacious/widgets/item/artist.dart';
import 'package:drift/drift.dart';
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';


class ArtistLibraryList extends ConsumerWidget {
  const ArtistLibraryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<void>(
      stream: db.selectOnly(db.artistTable).watch(),
      builder: (context, _) {
        return FutureBuilder<List<TypedResult>>(
          future: (db.selectOnly(db.artistTable)..addColumns([db.artistTable.name])).get(),
          builder: (context, snapshot) {
            return CustomScrollView(
              slivers: [
                if (snapshot.connectionState != ConnectionState.done) const SliverFillRemaining(child: Center(child: CircularProgressIndicator(value: null)))
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
                        final artist = snapshot.data ?? const ArtistMetadata(name: "Loading...");
                        return ArtistWidget(artist);
                      },
                    ),
                    childCount: snapshot.data?.length ?? 0
                  )
                ),
              ],
            );
          }
        );
      }
    );
  }
}