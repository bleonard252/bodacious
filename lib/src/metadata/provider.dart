import 'package:bodacious/models/track_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NowPlayingNotifier extends StateNotifier<TrackMetadata> {
  NowPlayingNotifier(): super(TrackMetadata.empty());

  changeTrack(TrackMetadata metadata) => state = metadata;
}