import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:bodacious/src/media/audio_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show Colors, Key, Widget;
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

import '../main.dart';

// ignore: must_be_immutable
class NowPlayingData extends ConsumerWidget {
  // @Deprecated("Use the non-nullable global [player] instead")
  // final BodaciousAudioHandler? player;
  //final NowPlayingNotifier metadataProvider;
  //bool _hasInitialized = false;
  final Widget child;
  NowPlayingData({
    Key? key,
    required this.child
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //initialize(ref);
    return child;
  }
}