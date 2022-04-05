import 'dart:async';
import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:bodacious/drift/database.dart';
import 'package:bodacious/main.dart';
import 'package:dart_vlc/dart_vlc.dart' as vlc;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:just_audio/just_audio.dart' as just;
import 'package:mime/mime.dart';
import 'package:rxdart/src/subjects/behavior_subject.dart';

import '../../models/track_data.dart';

part 'just_audio.dart';
part 'vlc.dart';

/// The audio handler for all of Bodacious.
abstract class BodaciousAudioHandler extends BaseAudioHandler with SeekHandler {
  /// The current playback position.
  Duration get position => playbackState.value.position;
  Duration? get duration => mediaItem.value?.duration;
  bool get hasPrevious => false;
  bool get hasNext => false;
  /// The position of the playing item in the queue.
  int? get currentIndex => 0;

  Future<void> prepareFromTrackMetadata(TrackMetadata trackMetadata) async {
    queue.add([
      // reset the queue
      trackMetadata.asMediaItem()
    ]);
  }
  @override
  Future<BodaciousMediaItem?> getMediaItem(String mediaId) async {
    try {
      
      return (await db.tryGetTrackFromUri(Uri.file(mediaId)))?.asMediaItem();
    } catch(e) {
      return null;
    }
  }
}
