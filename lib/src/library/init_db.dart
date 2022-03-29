import 'package:bodacious/models/track_data.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

Future<Database> loadDatabase() async {
  late final DatabaseFactory factory;
  late final String dbPath;
  if (kIsWeb) {
    throw UnsupportedError("Web is not supported at this time.");
  } else {
    factory = databaseFactoryIo;
  }
  try {
    dbPath = (await getLibraryDirectory()).absolute.path+"/_boLibrary";
  } catch(_) {
    try {
      dbPath = (await getApplicationSupportDirectory()).absolute.path+"/_boLibrary";
    } catch(_) {
      dbPath = (await getApplicationDocumentsDirectory()).absolute.path+"/_boLibrary";
    }
  }
  return await factory.openDatabase(dbPath);
}

/// The [Store] that will contain settings and the library root list.
final configStore = StoreRef<String, Map<String, dynamic>>.main();
/// Maps normalized artist names to (partial) ArtistMetadata objects.
final artistStore = StoreRef<String, dynamic>("artists");
/// Maps normalized artist name ` - ` normalized album name to (partial) AlbumMetadata objects.
final albumStore = StoreRef<String, dynamic>("albums");
/// Maps normalized artist name ` - ` normalized track name to (partial) TrackMetadata objects.
final songStore = StoreRef<String, TrackMetadata>("songs");
/// Maps playlist names to lists of tracks.
final playlistStore = StoreRef<String, List<TrackMetadata>>("playlists");