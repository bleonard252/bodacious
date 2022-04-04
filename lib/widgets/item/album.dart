import 'dart:io';

import 'package:bodacious/models/album_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../cover_placeholder.dart';

class AlbumWidget extends ConsumerWidget {
  final AlbumMetadata album;
  final Function()? onTap;
  final bool hideArtist;
  const AlbumWidget(this.album, {
    Key? key,
    this.onTap,
    this.hideArtist = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: hideArtist ? 64.0 : 72.0,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: album.coverUri?.scheme == "file" ? Image(
          image: (album.coverUri?.scheme == "file" ? FileImage(File.fromUri(album.coverUri!))
            : NetworkImage(album.coverUri.toString())) as ImageProvider,
          width: 48,
          height: 48,
          fit: BoxFit.cover,
          errorBuilder: (context, e, s) => const CoverPlaceholder(size: 48, iconSize: 24),
        ) : const CoverPlaceholder(size: 48, iconSize: 24),
        title: Text.rich(TextSpan(children: [
          WidgetSpan(
            child: Icon(MdiIcons.album, size: Theme.of(context).textTheme.subtitle1?.fontSize),
            alignment: PlaceholderAlignment.middle
          ),
          const WidgetSpan(child: SizedBox(width: 6)),
          TextSpan(text: album.name)
        ])),
        subtitle: hideArtist ? null : Text.rich(TextSpan(children: [
          // const WidgetSpan(child: Icon(MdiIcons.spotify)),
          // const WidgetSpan(child: SizedBox(width: 6)),
          TextSpan(text: album.artistName),
          //if (album.year != null) TextSpan(text: album.year.toString())
        ])),
        onTap: onTap ?? () {
          context.go("/library/albums/"+Uri.encodeComponent(album.artistName)+"/"+Uri.encodeComponent(album.name), extra: album);
        },
      ),
    );
  }
}