// TODO: read id3 metadata using that package
//       and probably use Riverpod to update the Now Playing track data

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bodacious/models/track_data.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flac_metadata/flacstream.dart';
import 'package:flac_metadata/metadata.dart';
import 'package:flutter/foundation.dart';
import 'package:id3/id3.dart';
import 'dart:ui' as ui;

Future<TrackMetadata> loadID3FromBytes(List<int> bytes, File file) async {
  final mp3 = MP3Instance(bytes);
  mp3.parseTagsSync();
  final rawTags = mp3.getMetaTags() ?? {};
  if (kDebugMode) {
    print(rawTags);
  }
  final flac = await FlacInfo(file).readMetadatas();
  
  // Decode images
  //ui.ImageDescriptor.encoded(rawTags["APIC"])
  //base64Decode(source)
  final apic = rawTags["APIC"]?["base64"];
  ui.ImageDescriptor? descriptor;
  ByteData? coverBytes;
  Uint8List? coverBytes2;
  if (apic != null) {
    descriptor = await ui.ImageDescriptor.encoded(await ui.ImmutableBuffer.fromUint8List(base64Decode(apic)));
    coverBytes = await (await (await descriptor.instantiateCodec()).getNextFrame()).image.toByteData(format: ui.ImageByteFormat.png);
  }
  
  final Map<String, dynamic> flacdata = {};
  for (final block in flac) {
    switch (block.blockType) {
      case BlockType.VORBIS_COMMENT:
        for (var element in (block as VorbisComment).comments) {
          if (element.startsWith("TITLE=")) flacdata.putIfAbsent("title", () => element.replaceFirst("TITLE=", ""));
          if (element.startsWith("ARTIST=")) flacdata.putIfAbsent("artist", () => element.replaceFirst("ARTIST=", ""));
          if (element.startsWith("ALBUM=")) flacdata.putIfAbsent("album", () => element.replaceFirst("ALBUM=", ""));
        }
        break;
      case BlockType.PICTURE:
        if ((block as Picture).pictureType == 3) {// Cover (front)
          descriptor = await ui.ImageDescriptor.encoded(await ui.ImmutableBuffer.fromUint8List(block.image));
          coverBytes2 = block.image;
        }
        break;
      default:
    }
  }

  // Output
  return TrackMetadata(
    title: flacdata["title"] ?? rawTags["Title"],
    artistName: flacdata["artist"] ?? rawTags["Artist"],
    albumName: flacdata["album"] ?? rawTags["Album"],
    coverData: descriptor,
    coverBytes: coverBytes2 ?? coverBytes?.buffer.asUint8List()
  );
}