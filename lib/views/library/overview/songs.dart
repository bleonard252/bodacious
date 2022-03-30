import 'dart:io';
import 'dart:typed_data';

import 'package:bodacious/main.dart';
import 'package:bodacious/models/track_data.dart';
import 'package:bodacious/src/library/init_db.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sembast/sembast.dart';

import '../../../widgets/cover_placeholder.dart';

class SongLibraryList extends ConsumerWidget {
  const SongLibraryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<int>(
      future: songStore.count(db),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) return Container();
        return ListView.builder(
          itemBuilder: (context, index) => FutureBuilder<Map<String, dynamic>?>(
            future: songStore.findFirst(db, finder: Finder(offset: index, limit: 1, sortOrders: [SortOrder('title')])).then((value) => value?.value),
            builder: (context, snapshot) {
              final track = TrackMetadata.fromJson(snapshot.data ?? {});
              return ListTile(
                leading: track.coverBytes != null || track.coverUri?.scheme == "file" ? Image(
                  image: (track.coverBytes != null ? MemoryImage(Uint8List.fromList(track.coverBytes!))
                    : track.coverUri?.scheme == "file" ? FileImage(File.fromUri(track.coverUri!))
                    : NetworkImage(track.coverUri.toString())) as ImageProvider,
                  width: 36,
                  height: 36,
                  fit: BoxFit.cover,
                  errorBuilder: (context, e, s) => const CoverPlaceholder(size: 36, iconSize: 24),
                ) : const CoverPlaceholder(size: 36, iconSize: 24),
                title: Text(track.title ?? track.uri?.pathSegments.last ?? "Unknown track"),
                onTap: () {
                  player.setFilePath(track.uri!.toFilePath());
                  ref.read(nowPlayingProvider.notifier).changeTrack(track);
                  player.play();
                },
              );
            },
          
          ),
          itemCount: snapshot.data
        );
      }
    );
  }
}