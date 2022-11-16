import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:bodacious/main.dart';
import 'package:bodacious/models/album_data.dart';
import 'package:bodacious/models/artist_data.dart';
import 'package:bodacious/models/track_data.dart';
import 'package:bodacious/widgets/cover_placeholder.dart';
import 'package:bodacious/widgets/frame_size.dart';
import 'package:bodacious/widgets/item/artist.dart';
import 'package:bodacious/widgets/item/song.dart';
import 'package:drift/drift.dart' hide Column, Table;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../widgets/item/album.dart';

class TrackDetailsWrapper extends StatelessWidget {
  final String id;
  final dynamic data;
  const TrackDetailsWrapper({ Key? key, this.data, required this.id }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TrackMetadata?>(
      initialData: data is TrackMetadata ? data : null,
      future: data is TrackMetadata ? null : (db.select(db.trackTable)
      ..where((tbl) => tbl.id.equals(id))
      ).getSingleOrNull(),
      builder: (context, snapshot) =>
      snapshot.hasError ? Material(
        color: Colors.black,
        child: Center(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(MdiIcons.alertCircle, color: Colors.red),
              ),
              Text(snapshot.error.toString(), textAlign: TextAlign.center, style: const TextStyle(color: Colors.red))
            ]
          )
        ),
      ) : snapshot.hasData ? TrackDetailsView(track: snapshot.data!)
      : snapshot.connectionState == ConnectionState.done ? Material(
        color: Colors.black,
        child: Center(
          child: Column(
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(MdiIcons.ghost, color: Colors.blue),
              ),
              Text("No track found", textAlign: TextAlign.center, style: TextStyle(color: Colors.blue))
            ]
          )
        )
      ) : const Material(
        color: Colors.black,
        child: Center(child: CircularProgressIndicator(value: null))
      )
    );
  }
}

class TrackDetailsView extends StatefulWidget {
  final TrackMetadata track;
  const TrackDetailsView({ Key? key, required this.track }) : super(key: key);

  @override
  State<TrackDetailsView> createState() => TrackDetailsViewState();
}

class TrackDetailsViewState extends State<TrackDetailsView> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    double _lastOffset = 0.0;
    controller.addListener(() {
      if (controller.positions.isEmpty) return;
      if (_lastOffset < 256 && controller.offset >= 256) {
        setState(() {});
      } else if (_lastOffset > 256 && controller.offset <= 256) {
        setState(() {});
      } else if (controller.position.atEdge) {
        setState(() {});
      }
      _lastOffset = controller.offset;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TrackMetadata?>(
      future: db.tryGetTrackFromUri(widget.track.uri),
      initialData: widget.track,
      builder: (context, snapshot) {
        final TrackMetadata track = snapshot.data ?? widget.track;
        return FutureBuilder<AlbumMetadata?>(
          future: track.albumId?.isNotEmpty == true ?
            db.tryGetAlbumById(track.albumId!)
            : Future.value(AlbumMetadata(artistName: track.artistName ?? "Unknown Artist", name: track.albumName ?? "Unknown Album")),
          builder: (context, snapshot) {
            final AlbumMetadata? album = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                scrolledUnderElevation: 0,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.5),
                title: (controller.positions.isNotEmpty && controller.offset >= 256) ? Text(widget.track.title ?? widget.track.uri.pathSegments.last) : null,
              ),
              extendBody: true,
              extendBodyBehindAppBar: true,
              body: CustomScrollView(
                controller: controller,
                slivers: [
                  const SliverToBoxAdapter(child: SizedBox(height: 72)),
                  SliverToBoxAdapter(child: (FrameSize.of(context)) ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        if ((track.coverUri ?? album?.coverUri)?.scheme == "file") Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image(
                            image: ((track.coverUri ?? album?.coverUri)?.scheme == "file" ? FileImage(File.fromUri(track.coverUri ?? album!.coverUri!))
                              : NetworkImage((track.coverUri ?? album!.coverUri!).toString())) as ImageProvider,
                            width: 196, height: 196,
                            fit: BoxFit.fitHeight,
                            errorBuilder: (context, e, s) => const CoverPlaceholder(size: 196),
                          ),
                        )
                        else const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CoverPlaceholder(size: 196),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0).add(const EdgeInsets.symmetric(vertical: 12)),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  track.title ?? track.uri.pathSegments.last,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                                Text(track.artistName ?? "Unknown Artist",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.headline6
                                ),
                                // Text(track.albumName ?? "Unknown Album",
                                //   maxLines: 1,
                                //   overflow: TextOverflow.ellipsis,
                                //   style: Theme.of(context).textTheme.headline6
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ]
                    ),
                  ) : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if ((track.coverUri ?? album?.coverUri)?.scheme == "file") Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image(
                            image: ((track.coverUri ?? album?.coverUri)?.scheme == "file" ? FileImage(File.fromUri(track.coverUri ?? album!.coverUri!))
                              : NetworkImage((track.coverUri ?? album!.coverUri!).toString())) as ImageProvider,
                            width: 196, height: 196,
                            fit: BoxFit.fitHeight,
                            errorBuilder: (context, e, s) => const CoverPlaceholder(size: 196),
                          ),
                        )
                        else const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CoverPlaceholder(size: 196),
                        ),
                        Text(
                          track.title ?? track.uri.pathSegments.last,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headline5,
                          textAlign: TextAlign.center,
                        ),
                        Text(track.artistName ?? "Unknown Artist",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headline6,
                          textAlign: TextAlign.center,
                        ),
                      ]
                    ),
                  )),
                  if (track.albumId?.isNotEmpty == true && album != null) SliverToBoxAdapter(child: AlbumWidget(
                      album,
                      //hideDetails: true,
                      hideArtist: true,
                      subtitle: const TextSpan(text: "On album"),
                    )
                  ),
                  if (track.trackArtistId?.isNotEmpty == true) FutureBuilder<ArtistMetadata?>(
                    future: db.tryGetArtistById(track.trackArtistId!),
                    builder: (context, snapshot) => snapshot.hasData ? SliverToBoxAdapter(child: ArtistWidget(
                      snapshot.data!,
                      hideDetails: true,
                      subtitle: const TextSpan(text: "Artist"),
                    )) 
                    : SliverToBoxAdapter(child: Container())
                  ),
                  if (track.albumArtistId?.isNotEmpty == true && track.trackArtistId != track.albumArtistId) FutureBuilder<ArtistMetadata?>(
                    future: db.tryGetArtistById(track.albumArtistId!),
                    builder: (context, snapshot) => snapshot.hasData ? SliverToBoxAdapter(child: ArtistWidget(
                      snapshot.data!,
                      hideDetails: true,
                      subtitle: const TextSpan(text: "Album artist"),
                    )) 
                    : SliverToBoxAdapter(child: Container())
                  ),
                  if (track.year != null) SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: Text.rich(TextSpan(children: [
                          TextSpan(text: "Details", style: Theme.of(context).textTheme.headline6),
                          if (track.year != null) TextSpan(children: [
                            const TextSpan(text: "\nYear: ", style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: track.year.toString())
                          ]),
                        ]))
                    ),
                  ),
                ]
              ),
            );
          }
        );
      }
    );
  }
}