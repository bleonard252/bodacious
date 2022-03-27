import 'package:bodacious/models/track_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NowPlayingNotifier extends StateNotifier<TrackMetadata> {
  NowPlayingNotifier(): super(const TrackMetadata());

  changeTrack(TrackMetadata metadata) => state = metadata;
}