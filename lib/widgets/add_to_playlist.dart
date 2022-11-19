import 'package:bodacious/drift/database.dart';
import 'package:bodacious/drift/playlist_data.dart';
import 'package:bodacious/main.dart';
import 'package:bodacious/models/playlist_data.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AddToPlaylistDialog extends StatelessWidget {
  final String id;
  final bool isAlbum;
  const AddToPlaylistDialog({super.key, required this.id, this.isAlbum = false});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: FutureBuilder(
        future: (db.select(db.playlistTable)).get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text(snapshot.error.toString());
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator(value: null));
          final playlists = snapshot.data as List<PlaylistMetadata>;
          return ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 660,
              maxWidth: 320,
            ),
            child: CustomScrollView(
              shrinkWrap: true,
              slivers: [
                SliverList(delegate: SliverChildListDelegate.fixed([
                  ListTile(
                    title: const Text("Do not add to a playlist"),
                    leading: const Icon(MdiIcons.close),
                    onTap: () => Navigator.of(context).pop(),
                  )
                ])),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final playlist = playlists[index];
                      return ListTile(
                        title: Text(playlists[index].name),
                        onTap: () async {
                          await addToPlaylist(playlists[index].id);
                          Navigator.of(context).pop();
                        },
                      );
                    },
                    childCount: playlists.length,
                  ),
                ),
                SliverList(delegate: SliverChildListDelegate.fixed([
                  ListTile(
                    title: const Text("Create new playlist"),
                    leading: const Icon(MdiIcons.plus),
                    onTap: () async {
                      final playlistId = await showDialog<String?>(
                        context: context,
                        builder: (context) => const CreatePlaylistDialog()
                      );
                      if (playlistId != null) {
                        await addToPlaylist(playlistId);
                        Navigator.of(context).pop();
                      }
                    }
                  )
                ]))
              ],
            ),
          );
        },
      ),
    );
  }
  
  addToPlaylist(String playlistId) async {
    final length = (await (db.select(db.playlistEntries)..where((tbl) => tbl.playlist.equals(playlistId))).get()).length;
    if (!isAlbum) {
      return db.transaction(() async {
        await db.into(db.playlistEntries).insert(PlaylistEntriesCompanion(
          playlist: Value(playlistId),
          track: Value(id),
          added: Value(DateTime.now()),
          index: Value(length)
        ));
        await (db.update(db.playlistTable)..whereSamePrimaryKey(PlaylistMetadata(id: playlistId, name: ''))).write(PlaylistTableCompanion(
          trackCount: Value(length + 1)
        ));
      });
    } else {
      final tracks = await db.tryGetAlbumTracksById(id);
      final now = DateTime.now();
      return db.transaction(() async {
        for (int i = 0; i < tracks.length; i++) {
          await db.into(db.playlistEntries).insert(PlaylistEntriesCompanion(
            playlist: Value(playlistId),
            track: Value(tracks[i].id),
            added: Value(now),
            index: Value(length + i)
          ));
        }
      });
    }
  }
}

class CreatePlaylistDialog extends StatefulWidget {
  const CreatePlaylistDialog({super.key});

  @override
  State<CreatePlaylistDialog> createState() => _CreatePlaylistDialogState();
}

class _CreatePlaylistDialogState extends State<CreatePlaylistDialog> {
  final TextEditingController _controller = TextEditingController();

  // Prevents playlist creation spam.
  bool isCreating = false;

  String? playlistId;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Create a playlist"),
      content: TextField(
        controller: _controller,
        autofocus: true,
        decoration: const InputDecoration(
          labelText: "Playlist name",
          border: UnderlineInputBorder()
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            Navigator.pop(context, null);
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Cancel"),
          ),
        ),
        TextButton(
          onPressed: isCreating ? null : () async {
            if (isCreating) return;
            if (_controller.text.isEmpty) return;
            setState(() {isCreating = true;});
            await createPlaylist();
            Navigator.pop(context, playlistId);
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Create"),
          ),
        ),
      ],
    );
  }

  Future<String> createPlaylist() async {
    final newEntry = await db.into(db.playlistTable).insertReturning(PlaylistTableCompanion(
      name: Value(_controller.text),
      createdAt: Value(DateTime.now()),
    ));
    playlistId = newEntry.id;
    return newEntry.id;
  }
}