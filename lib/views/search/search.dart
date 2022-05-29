
import 'dart:math';

import 'package:bodacious/main.dart';
import 'package:bodacious/models/artist_data.dart';
import 'package:bodacious/widgets/item/album.dart';
import 'package:bodacious/widgets/item/artist.dart';
import 'package:bodacious/widgets/item/song.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart' as fuzzy;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:woozy_search/woozy_search.dart';

import '../../models/album_data.dart';
import '../../models/search_result.dart';
import '../../models/track_data.dart';

final searchEngine = FutureProvider.family<List<SearchResult>, String>((ref, query) async {
  if (kDebugMode) {
    print("Searching for: $query");
  }
  final tracksFuture = db.select(db.trackTable).get();
  final albumsFuture = db.select(db.albumTable).get();
  final artistsFuture = db.select(db.artistTable).get();
  final theFutureIsNow = await Future.wait([tracksFuture, albumsFuture, artistsFuture]);
  final List<TrackMetadata> tracks = theFutureIsNow[0] as dynamic;
  final List<AlbumMetadata> albums = theFutureIsNow[1] as dynamic;
  final List<ArtistMetadata> artists = theFutureIsNow[2] as dynamic;
  // double ratio(String str) => fuzzy.partialRatio(query, str) / 100;
  // const limit = 0.4;
  // final trackResults = tracks.where((element) => element.title != null && ratio(element.title!) >= limit).map((e) => SearchResult.track(e, accuracy: ratio(e.title!)));
  // final albumResults = albums.where((element) => ratio(element.name) >= limit).map((e) => SearchResult.album(e, accuracy: ratio(e.name)));
  // final artistResults = artists.where((element) => ratio(element.name) >= limit).map((e) => SearchResult.artist(e, accuracy: ratio(e.name)));
  // final results = [...trackResults, ...albumResults, ...artistResults];
  // results.sort((a, b) => b.accuracy.compareTo(a.accuracy));
  // return results;
  final finder = Woozy<SearchResult>(limit: double.maxFinite.truncate());
  for (var element in tracks) {if (element.title != null) finder.addEntry(element.title!, value: SearchResult.track(element));}
  for (var element in albums) {finder.addEntry(element.name, value: SearchResult.album(element));}
  for (var element in artists) {finder.addEntry(element.name, value: SearchResult.artist(element));}
  return finder.search(query).map((e) => e.value!.withAccuracy(e.score)).toList();
});

/// This widget should be rendered in the Home view,
/// in place of the recommendations.
// ignore: must_be_immutable
class SearchResultsView extends ConsumerWidget {
  final String query;
  SearchResultsView({super.key, required this.query});
  SearchResult? _topResult;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final results = ref.watch(searchEngine.call(query));

    if (results.isLoading) return const Center(child: CircularProgressIndicator(value: null));
    if (results.hasError) {
      return Center(
        child: Container(
          color: Colors.red,
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(MdiIcons.alertCircle, color: Colors.white),
              ),
              Text(results.error.toString(), textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.white))
            ]
          ),
        )
      );
    }

    if (results.valueOrNull?.isEmpty == true && results.valueOrNull == null) {
      return Center(
        child: Column(
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(MdiIcons.ghost, color: Colors.blue),
            ),
            Text("No results for your search", textAlign: TextAlign.center, style: TextStyle(color: Colors.blue))
          ]
        )
      );
    }


    return Material(
      color: Colors.transparent,
      child: CustomScrollView(
        slivers: [
          if (results.isRefreshing) SliverToBoxAdapter(child: ConstrainedBox(
            constraints: const BoxConstraints.expand(height: 64),
            child: const Center(child: CircularProgressIndicator(value: null)),
          )),
          if ((results.valueOrNull ?? []).take(3).any((element) => element.accuracy > 0.8)) SliverToBoxAdapter(child: Padding(
            padding: const EdgeInsets.all(16.0) + const EdgeInsets.only(top: 32),
            child: Text("Top Result", style: Theme.of(context).textTheme.headline5),
          )),
          if ((results.valueOrNull ?? []).take(3).any((element) => element.accuracy > 0.8)) Builder(
            builder: (context) {
              final result = (results.valueOrNull ?? []).take(3).where((element) => element.accuracy > 0.8).first;
              _topResult = result;
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (result.isTrack) {
                      return SongWidget(
                        result.get(),
                        onTap: () async {
                          //player.prepareFromTrackMetadata(track);
                          player.stop();
                          await player.updateQueue([result.get<TrackMetadata>().asMediaItem()], 0);
                          await player.play();
                        }
                      );
                    } else if (result.isAlbum) {
                      return AlbumWidget(result.get());
                    } else if (result.isArtist) {
                      return ArtistWidget(result.get());
                    } else {
                      return Container(
                        padding: const EdgeInsets.all(8),
                        constraints: const BoxConstraints.expand(height: 64),
                        color: Colors.red,
                        child: const Text("Type does not match", style: TextStyle(color: Colors.white)),
                      );
                    }
                  },
                  childCount: ((results.value ?? []).take(3).any((element) => element.accuracy > 0.8)) ? 1 : 0
                )
              );
            }
          ),

          if ((results.valueOrNull ?? []).any((element) => element.isTrack)) SliverToBoxAdapter(child: Padding(
            padding: const EdgeInsets.all(16.0) + const EdgeInsets.only(top: 32),
            child: Text("Tracks", style: Theme.of(context).textTheme.headline5),
          )),
          Builder(
            builder: (context) {
              final list = (results.valueOrNull ?? []).where((element) => element.isTrack).take(5);
              return SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final result = list.elementAt(index);
                  if (result == _topResult) {
                    return Container();
                  } else if (result.isTrack) {
                    return SongWidget(
                      result.get(),
                      onTap: () async {
                        //player.prepareFromTrackMetadata(track);
                        player.stop();
                        await player.updateQueue([result.get().asMediaItem()], 0);
                        await player.play();
                      },
                    );
                  } else {
                    return Container(
                      padding: const EdgeInsets.all(8),
                      constraints: const BoxConstraints.expand(height: 64),
                      color: Colors.red,
                      child: const Text("Type does not match", style: TextStyle(color: Colors.white)),
                    );
                  }
                }, childCount: list.length)
              );
            }
          ),

          if ((results.valueOrNull ?? []).any((element) => element.isAlbum)) SliverToBoxAdapter(child: Padding(
            padding: const EdgeInsets.all(16.0) + const EdgeInsets.only(top: 32),
            child: Text("Albums", style: Theme.of(context).textTheme.headline5),
          )),
          Builder(
            builder: (context) {
              final list = (results.valueOrNull ?? []).where((element) => element.isAlbum).take(5);
              return SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final result = list.elementAt(index);
                  if (result == _topResult) {
                    return Container();
                  } else if (result.isAlbum) {
                    return AlbumWidget(result.get());
                  } else {
                    return Container(
                      padding: const EdgeInsets.all(8),
                      constraints: const BoxConstraints.expand(height: 64),
                      color: Colors.red,
                      child: const Text("Type does not match", style: TextStyle(color: Colors.white)),
                    );
                  }
                }, childCount: list.length)
              );
            }
          ),

          if ((results.valueOrNull ?? []).any((element) => element.isArtist)) SliverToBoxAdapter(child: Padding(
            padding: const EdgeInsets.all(16.0) + const EdgeInsets.only(top: 32),
            child: Text("Artists", style: Theme.of(context).textTheme.headline5),
          )),
          Builder(
            builder: (context) {
              final list = (results.valueOrNull ?? []).where((element) => element.isArtist).take(5);
              return SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final result = list.elementAt(index);
                  if (result == _topResult) {
                    return Container();
                  } else if (result.isArtist) {
                    return ArtistWidget(result.get());
                  } else {
                    return Container(
                      padding: const EdgeInsets.all(8),
                      constraints: const BoxConstraints.expand(height: 64),
                      color: Colors.red,
                      child: const Text("Type does not match", style: TextStyle(color: Colors.white)),
                    );
                  }
                }, childCount: list.length)
              );
            }
          ),
        ],
      ),
    );
  }
}