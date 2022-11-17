
import 'dart:async';

import 'package:bodacious/main.dart';
import 'package:bodacious/models/artist_data.dart';
import 'package:bodacious/widgets/item/album.dart';
import 'package:bodacious/widgets/item/artist.dart';
import 'package:bodacious/widgets/item/song.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:woozy_search/woozy_search.dart';

import '../../models/album_data.dart';
import '../../models/search_result.dart';
import '../../models/track_data.dart';

final searchEngine = FutureProvider.family<List<SearchResult>, String>((ref, query) async {
  final logger = appLogger.independentChild("searchEngine");
  logger.debug("Searching for: $query");
  final tracksFuture = db.select(db.trackTable).get();
  final albumsFuture = db.select(db.albumTable).get();
  final artistsFuture = db.select(db.artistTable).get();
  final theFutureIsNow = await Future.wait([tracksFuture, albumsFuture, artistsFuture]);
  final List<TrackMetadata> tracks = theFutureIsNow[0] as dynamic;
  final List<AlbumMetadata> albums = theFutureIsNow[1] as dynamic;
  final List<ArtistMetadata> artists = theFutureIsNow[2] as dynamic;
  const limit = 0.5;
  final finder = Woozy<SearchResult>(limit: double.maxFinite.truncate());
  //query = query.replaceAll(r' ?is:\w+', '');
  final typeFilter = query.split(" ").contains("is:track") ? "track"
  : query.split(" ").contains("is:song") ? "track"
  : query.split(" ").contains("is:album") ? "album"
  : query.split(" ").contains("is:artist") ? "artist"
  : null;
  query = query.replaceAll(RegExp(r'\s?is\:\w+'), '');
  if ((typeFilter??"track") == "track") for (var element in tracks) {if (element.title != null) finder.addEntry(element.title!, value: SearchResult.track(element));}
  if ((typeFilter??"album") == "album") for (var element in albums) {finder.addEntry(element.name, value: SearchResult.album(element));}
  if ((typeFilter??"artist") == "artist") for (var element in artists) {finder.addEntry(element.name, value: SearchResult.artist(element));}
  return finder.search(query).map((e) => e.value!.withAccuracy(e.score)).takeWhile((value) => value.accuracy >= limit).toList();
});

/// This widget should be rendered in the Home view,
/// in place of the recommendations.
// ignore: must_be_immutable
class SearchResultsView extends ConsumerWidget {
  final FutureOr<void> Function(String newQuery) reSearch;
  final String query;
  SearchResultsView({super.key, required this.query, required this.reSearch});
  SearchResult? _topResult;
  //String? filterTo;

  bool isFiltered({String? to = ""}) {
    final typeFilter = getFilter();
    if (to == "") return typeFilter != null;
    return typeFilter == to;
  }

  String? getFilter() {
    final typeFilter = query.split(" ").contains("is:track") ? "track"
    : query.split(" ").contains("is:song") ? "track"
    : query.split(" ").contains("is:album") ? "album"
    : query.split(" ").contains("is:artist") ? "artist"
    : null;
    return typeFilter;
  }

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

    if (results.valueOrNull?.isEmpty == true || results.valueOrNull == null) {
      return Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(MdiIcons.ghost, color: Colors.blue),
            ),
            Text("No results for your search", textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.blue, shadows: [const Shadow(blurRadius: 2, color: Colors.black)]))
          ]
        )
      );
    }


    return Material(
      color: Colors.transparent,
      child: CustomScrollView(
        primary: false,
        slivers: [
          if (results.isRefreshing || results.isLoading) SliverToBoxAdapter(child: ConstrainedBox(
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

          if ((getFilter() == "track" || !isFiltered()) && (results.valueOrNull ?? []).any((element) => element.isTrack)) SliverToBoxAdapter(child: Padding(
            padding: const EdgeInsets.all(16.0) + const EdgeInsets.only(top: 32),
            child: Text("Tracks", style: Theme.of(context).textTheme.headline5),
          )),
          Builder(
            builder: (context) {
              late final Iterable<SearchResult> list;
              if (isFiltered(to: "track")) {
                list = (results.valueOrNull ?? []).where((element) => element.isTrack);
              } else {
                list = (results.valueOrNull ?? []).where((element) => element.isTrack).take(5);
              }
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
          if (!isFiltered() && (results.valueOrNull ?? []).where((element) => element.isTrack).length > 5) SliverToBoxAdapter(child: Container(
            constraints: const BoxConstraints.expand(height: 48),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(onPressed: () => reSearch(query+" is:track"), child: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text("See all tracks"),
                ))
              ],
            ),
          )),

          if ((getFilter() == "album" || !isFiltered()) && (results.valueOrNull ?? []).any((element) => element.isAlbum)) SliverToBoxAdapter(child: Padding(
            padding: const EdgeInsets.all(16.0) + const EdgeInsets.only(top: 32),
            child: Text("Albums", style: Theme.of(context).textTheme.headline5),
          )),
          if (getFilter() == "album" || !isFiltered()) Builder(
            builder: (context) {
              //final list = (results.valueOrNull ?? []).where((element) => element.isAlbum).take(5);
              late final Iterable<SearchResult> list;
              if (isFiltered(to: "album")) {
                list = (results.valueOrNull ?? []).where((element) => element.isAlbum);
              } else {
                list = (results.valueOrNull ?? []).where((element) => element.isAlbum).take(5);
              }
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
          if (!isFiltered() && (results.valueOrNull ?? []).where((element) => element.isAlbum).length > 5) SliverToBoxAdapter(child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(onPressed: () => reSearch(query+" is:album"), child: const Padding(
                padding: EdgeInsets.all(4.0),
                child: Text("See all albums"),
              ))
            ],
          )),

          if ((getFilter() == "artist" || !isFiltered()) && (results.valueOrNull ?? []).any((element) => element.isArtist)) SliverToBoxAdapter(child: Padding(
            padding: const EdgeInsets.all(16.0) + const EdgeInsets.only(top: 32),
            child: Text("Artists", style: Theme.of(context).textTheme.headline5),
          )),
          if (getFilter() == "artist" || !isFiltered()) Builder(
            builder: (context) {
              //final list = (results.valueOrNull ?? []).where((element) => element.isArtist).take(5);
              late final Iterable<SearchResult> list;
              if (isFiltered(to: "artist")) {
                list = (results.valueOrNull ?? []).where((element) => element.isArtist);
              } else {
                list = (results.valueOrNull ?? []).where((element) => element.isArtist).take(5);
              }
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
          if (!isFiltered() && (results.valueOrNull ?? []).where((element) => element.isArtist).length > 5) SliverToBoxAdapter(child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(onPressed: () => reSearch(query+" is:artist"), child: const Padding(
                padding: EdgeInsets.all(4.0),
                child: Text("See all artists"),
              ))
            ],
          )),
        ],
      ),
    );
  }
}