import 'package:flutter/widgets.dart';
import 'package:just_audio/just_audio.dart';

class NowPlayingData extends InheritedWidget {
  final AudioPlayer? player;
  // final TrackMetadata? metadata;
  const NowPlayingData({
    Key? key, 
    this.player,
    //this.metadata,
    required Widget child
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant NowPlayingData oldWidget) {
    return player != oldWidget.player;
  }

  static NowPlayingData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<NowPlayingData>();
  }
}