import 'package:flutter/widgets.dart';
import 'package:just_audio/just_audio.dart';

class NowPlayingData extends InheritedWidget {
  @Deprecated("Use the non-nullable global [player] instead")
  final AudioPlayer? player;
  //final NowPlayingNotifier metadataProvider;
  const NowPlayingData({
    Key? key, 
    this.player,
    //required this.metadataProvider,
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