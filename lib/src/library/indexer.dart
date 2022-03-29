import 'dart:io';
import 'dart:isolate';

import 'package:bodacious/src/library/init_db.dart';
import 'package:flutter/foundation.dart';
import 'package:mime/mime.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

import '../../models/track_data.dart';

abstract class TheIndexer {
  // Isolate main logic
  static final ReceivePort progressReceiver = ReceivePort("The Indexer's Progress Receiver");
  static Stream<IndexerProgressReport>? _progress;
  static Stream<IndexerProgressReport> get progress => _progress ??=
  progressReceiver.asBroadcastStream(
    onCancel: (controller) {
      controller.pause();
    },
    onListen: (controller) async {
      if (controller.isPaused) {
        controller.resume();
      }
    },
  ) as Stream<IndexerProgressReport>;

  static late final Isolate indexerIsolate;
  
  /// Don't try to touch the isolate before this aight
  static Future<void> spawn() async {
    indexerIsolate = await Isolate.spawn((dynamic message) => _IndexerIsolate()(message), progressReceiver);
  }
}

class _IndexerIsolate {
  late final Database db;
  // These are copied straight from the static metadata thing, just for safe keeping.
  final configStore = StoreRef<String, dynamic>.main();
  final artistStore = StoreRef<String, dynamic>("artists");
  final albumStore = StoreRef<String, dynamic>("albums");
  final songStore = StoreRef<String, TrackMetadata>("songs");

  /// This makes this class function as a function.
  /// And gee I wonder why I did that.
  Future<void> call(SendPort sendProgressReport) async {
    if (kDebugMode) {
      print("This is not complete and may appear to hang");
    } else {
      throw UnimplementedError("The Indexer doesn't work yet.");
    }
    db = await loadDatabase();
    sendProgressReport.send(const IndexerProgressReport(state: IndexerState.STARTING));
    // == STARTING PHASE == //
    List<File> validFiles = [];
    final List<String> _dbfolders = configStore.record("libraries").get(db) as List<String>? ?? [];
    for (final f in _dbfolders) {
      if (!await Directory(f).exists()) {
        if (kDebugMode) {print("INDEXER ERROR: `"+f+"` does not exist!");}
        continue; //we're in a for loop. so go to the next thing (or break if you're at the end)
      }
      await for (final d in Directory(f).list(recursive: true)) {
        if (d is! File) continue;
        if (MimeTypeResolver().lookup(d.uri.pathSegments.last)?.startsWith("audio/") != true) continue;
        validFiles.add(d);
        sendProgressReport.send(IndexerProgressReport(
          state: IndexerState.STARTING,
          max: validFiles.length,
          currentFilename: f
        ));
      }
    }
    sendProgressReport.send(IndexerProgressReport(
      state: IndexerState.SCANNING,
      max: validFiles.length,
      value: 0
    ));
    
    // == GET THE METADATA == //
    // The plan for this is to read the metadata,
    // including covers and lyrics, for each file.
    // This includes checking adjacent files under
    // .lrc or .mse extensions, or `cover.png` for
    // cover art.
    // It'll check for MSEs first, but if it can't
    // find the file it'll then check for tags in
    // the file, then the file's context (filename
    // and parent dir names).
    // The metadata will be partial as it will be
    // stored as JSON in the database, which drops
    // some values, such as artist and album, data
    // for the cover itself, and album tracklists.
    for (final file in validFiles) {

    }
  }
}

class IndexerProgressReport {
  final int value;
  final int max;
  final String? currentFilename;
  final IndexerState state;
  const IndexerProgressReport({
    this.value = 0,
    this.max = 0,
    this.currentFilename,
    required this.state
  }) : assert(value <= max, "Invalid [value]");
}
enum IndexerState {
  /// Performing the initial filesystem scan.
  STARTING,
  /// Importing metadata from the files.
  SCANNING,
  /// Cleaning up metadata for removed library entries
  /// (or missing files in certain circumstances).
  CLEANING,
  /// The indexing is almost complete.
  FINISHING,
  /// The indexer stopped early and did not finish.
  STOPPED,
  /// The indexer has finished and exited.
  FINISHED
}