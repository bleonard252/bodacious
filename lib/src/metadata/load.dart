// TODO: read id3 metadata using that package
//       and probably use Riverpod to update the Now Playing track data

import 'dart:convert';
import 'dart:typed_data';

import 'package:bodacious/models/track_data.dart';
import 'package:flutter/foundation.dart';
import 'package:id3/id3.dart';
import 'dart:ui' as ui;

Future<TrackMetadata> loadID3FromBytes(List<int> bytes) async {
  final mp3 = MP3Instance(bytes);
  mp3.parseTagsSync();
  final rawTags = mp3.getMetaTags() ?? {};
  if (kDebugMode) {
    print(rawTags);
  }
  
  // Decode images
  //ui.ImageDescriptor.encoded(rawTags["APIC"])
  //base64Decode(source)
  final apic = rawTags["APIC"]?["base64"];
  ui.ImageDescriptor? descriptor;
  ByteData? coverBytes;
  if (apic != null) {
    descriptor = await ui.ImageDescriptor.encoded(await ui.ImmutableBuffer.fromUint8List(base64Decode(apic)));
    coverBytes = await (await (await descriptor.instantiateCodec()).getNextFrame()).image.toByteData(format: ui.ImageByteFormat.png);
  }

  // Output
  return TrackMetadata(
    title: rawTags["Title"],
    artistName: rawTags["Artist"],
    albumName: rawTags["Album"],
    coverData: descriptor,
    coverBytes: coverBytes?.buffer.asUint8List()
  );
}