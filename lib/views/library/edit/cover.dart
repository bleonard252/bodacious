// stateful dialog widget with landscape and portrait versions

import 'dart:io';

import 'package:bodacious/main.dart';
import 'package:bodacious/src/online/lastfm.dart';
import 'package:dio/dio.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flinq/flinq.dart';
import 'package:flutter/material.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';
import 'package:lastfm/lastfm.dart';
import 'package:simple_icons/simple_icons.dart';
import 'package:spotify/spotify.dart' hide Image;
import 'package:xml/xml.dart';

import '../../../widgets/cover_placeholder.dart';

/// The type of item to apply the cover to.
enum BoType { track, album, artist, playlist }

class CoverEditorDialog extends StatefulWidget {
  final BoType type;
  final String id;
  final Uri? coverUri;
  final List<String> albumIds;
  final List<String> artistIds;
  final List<String> trackIds;
  const CoverEditorDialog({
    super.key,
    required this.type,
    required this.id,
    this.coverUri,
    this.albumIds = const [],
    this.artistIds = const [],
    this.trackIds = const [],
  });

  @override
  State<CoverEditorDialog> createState() => _CoverEditorDialogState();

  /// Get the cover image URIs of each listed album.
  static Future<List<Uri>> getCoverFromAlbums(List<String> ids) async {
    final List<Uri> covers = [];
    for (final String id in ids) {
      final album = await db.tryGetAlbumById(id);
      if (album?.coverUri == null) continue;
      covers.add(album!.coverUri!);
    }
    return covers.notNull.distinct;
  }

  static Future<List<Uri>> getCoverFromTracks(List<String> ids) async {
    final List<Uri> covers = [];
    for (final String id in ids) {
      final track = await db.tryGetTrackById(id);
      if (track == null) continue;
      if (track.coverUri != null) {
        covers.add(track.coverUri!);
      } else if (track.albumId != null) {
        final album = await db.tryGetAlbumById(track.albumId!);
        if (album?.coverUri != null) covers.add(album!.coverUri!);
      }
    }
    return covers.notNull.distinct;
  }

  static Future<List<Uri>> getCoverFromArtists(List<String> ids) async {
    final List<Uri> covers = [];
    for (final String id in ids) {
      final artist = await db.tryGetArtistById(id);
      if (artist == null) continue;
      if (artist.coverUri != null) {
        covers.add(artist.coverUri!);
      } else {
        final albums = await (db.select(db.albumTable)..where((tbl) => tbl.artistId.equals(id))).get();
        for (final album in albums) {
          if (album.coverUri != null) {
            covers.add(album.coverUri!);
          }
        }
      }
    }
    return covers.notNull.distinct;
  }

  static Future<List<Uri>> getCoverFromNetwork(BoType type, String id) async {
    switch (type) {
      case BoType.album:
        //return await getCoverFromAlbums([id]);
        final album = await db.tryGetAlbumById(id);
        if (album == null) return [];
        final covers = <Uri>[];
        if (config.lastFmIntegration && apiKeys.lastfmApiKey != null) {
          final lastfm = LastFMUnauthorized(apiKeys.lastfmApiKey!, null, "Bodacious/v0.10.0 <https://github.com/bleonard252/bodacious>");
          final response = await lastfm.read("album.getInfo", {"artist": album.artistName, "album": album.name, "autocorrect": "1"});
          final _covers = response.rootElement.firstElementChild?.findElements("image");
          if (_covers != null && _covers.isNotEmpty) {
            try {
              final cover = _covers.firstWhere((e) => e.getAttribute("size") == "large").text;
              covers.add(Uri.parse(cover));
            } catch (e) {
              try {
                final cover = _covers.firstWhere((e) => e.getAttribute("size") == "extralarge").text;
                covers.add(Uri.parse(cover));
              } catch (e) {
                try {
                  final cover = _covers.firstWhere((e) => e.getAttribute("size") == "mega").text;
                  covers.add(Uri.parse(cover));
                } catch (e) {
                  try {
                    final cover = _covers.firstWhere((e) => e.getAttribute("size") == "medium").text;
                    covers.add(Uri.parse(cover));
                  } catch (e) {
                    try {
                      final cover = _covers.firstWhere((e) => e.getAttribute("size") == "small").text;
                      covers.add(Uri.parse(cover));
                    } catch (e) {
                      try {
                        final cover = _covers.firstWhere((e) => e.getAttribute("size") == "extrasmall").text;
                        covers.add(Uri.parse(cover));
                      } catch (e) {
                        try {
                          final cover = _covers.firstWhere((e) => e.getAttribute("size") == "original").text;
                          covers.add(Uri.parse(cover));
                        } catch (e) {
                          try {
                            final cover = _covers.first.text;
                            covers.add(Uri.parse(cover));
                          // ignore: empty_catches
                          } catch (e) {}
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
        if (config.spotifyIntegration && apiKeys.spotifyClientId != null && apiKeys.spotifySecret != null) {
          final spcred = SpotifyApiCredentials(apiKeys.spotifyClientId, apiKeys.spotifySecret);
          final spotify = SpotifyApi(spcred);

          if (album.spotifyId?.isNotEmpty != true) {
            final entry = await spotify.search.get(album.name+" artist:"+album.artistName, types: [SearchType.album]).first();
            final AlbumSimple? _album = entry.first.items?.firstWhere((element) => ratio(element.name.toLowerCase(), album.name.toLowerCase()) >= 85, orElse: () => null);
            if (_album != null) {
              final _cover = _album.images?.first.url;
              if (_cover != null) covers.add(Uri.parse(_cover));
            }
          } else {
            final response = await spotify.albums.get(album.spotifyId!);
            if (response.images?.firstOrNull?.url != null) covers.add(Uri.parse(response.images!.first.url!));
          }
        }
        return covers;
      case BoType.artist:
        //return await getCoverFromArtists([id]);
        final artist = await db.tryGetArtistById(id);
        if (artist == null) return [];
        final covers = <Uri>[];
        if (config.spotifyIntegration && apiKeys.spotifyClientId != null && apiKeys.spotifySecret != null && artist.spotifyId?.isNotEmpty == true) {
          final spcred = SpotifyApiCredentials(apiKeys.spotifyClientId, apiKeys.spotifySecret);
          final spotify = SpotifyApi(spcred);

          final response = await spotify.artists.get(artist.spotifyId!);
          if (response.images?.firstOrNull?.url != null) {
            for (var element in response.images!) {
              covers.add(Uri.parse(element.url!));
            }
          }
        }
        if (config.wikipediaIntegration) {
          var client = Dio();
          final response = await client.get("https://commons.wikimedia.org/w/api.php?action=query&format=json&prop=&list=categorymembers&titles=&formatversion=2&cmtitle=Category%3A${Uri.encodeQueryComponent(artist.name)}&cmtype=file");
          if (response.statusCode == 200) {
            response.data["query"]["categorymembers"].forEach((element) {
              covers.add(Uri.parse("https://commons.wikimedia.org/wiki/Special:Redirect/file/${element["title"]}"));
            });
          }
        }
        return covers;
      case BoType.track:
        //return await getCoverFromTracks([id]);
        final track = await db.tryGetTrackById(id);
        if (track == null) return [];
        final covers = <Uri>[];
        if (config.lastFmIntegration && apiKeys.lastfmApiKey != null && track.artistName?.isNotEmpty == true && track.title?.isNotEmpty == true) {
          final lastfm = LastFMUnauthorized(apiKeys.lastfmApiKey!, null, "Bodacious/v0.10.0 <https://github.com/bleonard252/bodacious>");
          final response = await lastfm.read("track.getInfo", {"artist": track.artistName!, "track": track.title!, "autocorrect": "1"});
          final _covers = response.rootElement.firstElementChild?.getElement("album")?.findElements("image");
          if (_covers != null && _covers.isNotEmpty) {
            try {
              final cover = _covers.firstWhere((e) => e.getAttribute("size") == "large").text;
              covers.add(Uri.parse(cover));
            } catch (e) {
              try {
                final cover = _covers.firstWhere((e) => e.getAttribute("size") == "extralarge").text;
                covers.add(Uri.parse(cover));
              } catch (e) {
                try {
                  final cover = _covers.firstWhere((e) => e.getAttribute("size") == "mega").text;
                  covers.add(Uri.parse(cover));
                } catch (e) {
                  try {
                    final cover = _covers.firstWhere((e) => e.getAttribute("size") == "medium").text;
                    covers.add(Uri.parse(cover));
                  } catch (e) {
                    try {
                      final cover = _covers.firstWhere((e) => e.getAttribute("size") == "small").text;
                      covers.add(Uri.parse(cover));
                    } catch (e) {
                      try {
                        final cover = _covers.firstWhere((e) => e.getAttribute("size") == "extrasmall").text;
                        covers.add(Uri.parse(cover));
                      } catch (e) {
                        try {
                          final cover = _covers.firstWhere((e) => e.getAttribute("size") == "original").text;
                          covers.add(Uri.parse(cover));
                        } catch (e) {
                          try {
                            final cover = _covers.first.text;
                            covers.add(Uri.parse(cover));
                          // ignore: empty_catches
                          } catch (e) {}
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
        return covers;
      default:
        return [];
    }
  }
}

class _CoverEditorDialogState extends State<CoverEditorDialog> {
  late Uri? selectedCover = widget.coverUri;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          if (MediaQuery.of(context).orientation == Orientation.landscape) Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  buildCoverImage(),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 256, maxWidth: 320),
                  child: buildPicker()
                ),
              ),
            ],
          )
          else Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildCoverImage(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 256, maxWidth: 320),
                  child: buildPicker()
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Cancel'),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Apply'),
                  ),
                  onPressed: () => applyCover(context),
                ),
              ),
            ],
          ),
        ]
      ),
    );
  }

  Widget buildCoverImage() {
    if (selectedCover == null) {
      return const CoverPlaceholder(size: 196);
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: widget.type == BoType.artist ? BorderRadius.circular(196) : BorderRadius.zero,
        child: Image(
          image: (selectedCover!.scheme == "file" ? FileImage(File.fromUri(selectedCover!))
            : NetworkImage(selectedCover.toString())) as ImageProvider,
          width: 196, height: 196,
          fit: BoxFit.fitHeight,
          errorBuilder: (context, e, s) => const CoverPlaceholder(size: 196),
        ),
      )
    );
  }

  Widget buildPicker() {
    Widget buildOption(Uri coverUri, [bool artist = false]) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        child: TextButton(
          child: SizedBox(
            width: 48,
            height: 48,
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: artist ? BorderRadius.circular(48) : BorderRadius.zero,
                    child: Image(
                      image: (coverUri.scheme == "file" ? FileImage(File.fromUri(coverUri))
                        : NetworkImage(coverUri.toString())) as ImageProvider,
                      width: 48, height: 48,
                      fit: BoxFit.fitHeight,
                      errorBuilder: (context, e, s) => const CoverPlaceholder(size: 48),
                    ),
                  ),
                ),
                if (coverUri.remoteSource == RemoteCoverSource.wikipedia) Positioned(
                  right: 0, bottom: 0,
                  child: ClipOval(
                    child: Container(
                      width: 16, height: 16,
                      color: Colors.white,
                      child: const Icon(SimpleIcons.wikipedia, color: Colors.black, size: 12),
                    ),
                  )
                ) else if (coverUri.remoteSource == RemoteCoverSource.lastfm) Positioned(
                  right: 0, bottom: 0,
                  child: ClipOval(
                    child: Container(
                      width: 16, height: 16,
                      color: const Color(0xFFD51007),
                      child: const Icon(SimpleIcons.lastdotfm, color: Colors.white, size: 12),
                    ),
                  )
                ) else if (coverUri.remoteSource == RemoteCoverSource.spotify) Positioned(
                  right: 0, bottom: 0,
                  child: ClipOval(
                    child: Container(
                      width: 16, height: 16,
                      color: Colors.black,
                      child: const Icon(SimpleIcons.spotify, color: Color(0xFF1DB954), size: 12),
                    ),
                  )
                ),
              ],
            ),
          ),
          onPressed: () => setState(() => selectedCover = coverUri),
        ),
      );
    }
    Widget buildAlbumsList() {
      return FutureBuilder<List<Uri>>(
        future: CoverEditorDialog.getCoverFromAlbums(widget.albumIds),
        builder: (context, snapshot) {
          return SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: snapshot.hasData && snapshot.data!.isEmpty ? [] : <Widget>[
                Text("From albums", style: Theme.of(context).textTheme.headlineSmall),
                if (snapshot.hasData) SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: snapshot.data?.map((e) => buildOption(e)).toList() ?? [],
                  ),
                )
                else if (snapshot.hasError) Text(snapshot.error.toString(), style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.red))
                else const LinearProgressIndicator(),
                const Divider(),
              ],
            ),
          );
        }
      );
    }
    Widget buildTracksList() {
      return FutureBuilder<List<Uri>>(
        future: CoverEditorDialog.getCoverFromTracks(widget.trackIds),
        builder: (context, snapshot) {
          return SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: snapshot.hasData && snapshot.data!.isEmpty ? [] : <Widget>[
                Text("From tracks", style: Theme.of(context).textTheme.headlineSmall),
                if (snapshot.hasData) SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: snapshot.data?.map((e) => buildOption(e)).toList() ?? [],
                  ),
                )
                else if (snapshot.hasError) Text(snapshot.error.toString(), style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.red))
                else const LinearProgressIndicator(),
                const Divider(),
              ],
            ),
          );
        }
      );
    }
    Widget buildArtistsList() {
      return FutureBuilder<List<Uri>>(
        future: CoverEditorDialog.getCoverFromArtists(widget.artistIds),
        builder: (context, snapshot) {
          return SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: snapshot.hasData && snapshot.data!.isEmpty ? [] : <Widget>[
                Text("From artists", style: Theme.of(context).textTheme.headlineSmall),
                if (snapshot.hasData) SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: snapshot.data?.map((e) => buildOption(e, true)).toList() ?? [],
                  ),
                )
                else if (snapshot.hasError) Text(snapshot.error.toString(), style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.red))
                else const LinearProgressIndicator(),
                const Divider(),
              ],
            ),
          );
        }
      );
    }
    return CustomScrollView(
      slivers: <Widget>[
        // cover image picker
        if (widget.type == BoType.album) ...[
          buildAlbumsList(),
          buildTracksList(),
          buildArtistsList(),
        ] else if (widget.type == BoType.track || widget.type == BoType.playlist) ...[
          buildTracksList(),
          buildAlbumsList(),
          buildArtistsList(),
        ] else if (widget.type == BoType.artist) ...[
          buildArtistsList(),
          buildAlbumsList(),
          buildTracksList(),
        ],
        // online covers
        FutureBuilder<List<Uri>>(
          future: CoverEditorDialog.getCoverFromNetwork(widget.type, widget.id),
          builder: (context, snapshot) {
            return SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: snapshot.hasData && snapshot.data!.isEmpty ? [] : <Widget>[
                  if (snapshot.hasData) Text("From the Internet", style: Theme.of(context).textTheme.headlineSmall),
                  if (snapshot.hasData) SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: snapshot.data?.map((e) => buildOption(e)).toList() ?? [],
                    ),
                  )
                  else if (snapshot.hasError) Text(snapshot.error.toString(), style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.red))
                  else const LinearProgressIndicator(),
                  const Divider(),
                ],
              ),
            );
          }
        )
      ],
    );
  }

  Future<void> applyCover(BuildContext context) async {
    //
    Navigator.pop(context);
  }
}

enum RemoteCoverSource { spotify, lastfm, discogs, wikipedia, genius }

class RemoteCoverChoice {
  final Uri uri;
  final RemoteCoverSource source;
  const RemoteCoverChoice(this.uri, this.source);
}

extension on Uri {
  RemoteCoverSource? get remoteSource => {
    "i.scdn.co": RemoteCoverSource.spotify,
    "spotify.com": RemoteCoverSource.spotify,
    "lastfm-img2.akamaized.net": RemoteCoverSource.lastfm,
    "lastfm.freetls.fastly.net": RemoteCoverSource.lastfm,
    "lastfm-img2-ak.mirrors.tds.net": RemoteCoverSource.lastfm,
    "api-img.discogs.com": RemoteCoverSource.discogs,
    "upload.wikimedia.org": RemoteCoverSource.wikipedia,
    "en.wikipedia.org": RemoteCoverSource.wikipedia,
    "images.genius.com": RemoteCoverSource.genius,
  }[host];
}