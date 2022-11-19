
import 'package:bodacious/drift/album_data.dart';
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
    //final Expression<bool?> Function(AlbumTable tbl) _onlyAlbumArtistsFilter = config.onlyAlbumArtists ? (tbl) => tbl.albumCount.isBiggerThanValue(0) : (tbl) => tbl.albumCount.isNotNull() | tbl.albumCount.isNull();
    return StreamBuilder<int>(
      stream: (db.selectOnly(db.artistTable)
        ..where(config.onlyAlbumArtists ? db.artistTable.albumCount.isBiggerThanValue(0) : db.artistTable.albumCount.isNotNull() | db.artistTable.albumCount.isNull())
        ..addColumns([db.artistTable.id])
      ).watch().map(((value) => value.length)),
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
                          child: const Text("No artists found. Add a music folder in Settings > Library.", textAlign: TextAlign.center)
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
                (context, index) => FutureBuilder<ArtistMetadata>(
                  future: (
                    db.select(db.artistTable)
                    ..orderBy([
                      (tbl) => OrderingTerm.asc(tbl.name)
                    ])
                    ..where(config.onlyAlbumArtists ? (tbl) => tbl.albumCount.isBiggerThanValue(0) : (tbl) => tbl.albumCount.isNotNull() | tbl.albumCount.isNull())
                    ..limit(1, offset: index)
                  ).getSingle(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data == null) return Container(height: 72);
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