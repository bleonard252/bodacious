import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bodacious/models/track_data.dart';
import 'package:bodacious/src/library/cache_dir.dart';
import 'package:bodacious/src/metadata/infer.dart';
import 'package:flac_metadata/flacstream.dart';
import 'package:flac_metadata/metadata.dart';
import 'package:flutter/foundation.dart';
import 'package:id3/id3.dart';

import 'package:mime/mime.dart';

Future<TrackMetadata> loadID3FromBytes(List<int> bytes, File file, {String? cacheDir}) async {
  final mp3 = MP3Instance(bytes);
  if (bytes.length > 3) {
    mp3.parseTagsSync();
  }
  final rawTags = mp3.getMetaTags() ?? {};
  // if (kDebugMode) {
  //   print(rawTags);
  // }
  final flac = await FlacInfo(file).readMetadatas();
  
  // Decode images
  //ui.ImageDescriptor.encoded(rawTags["APIC"])
  //base64Decode(source)
  final apic = rawTags["APIC"]?["base64"];
  //ui.ImageDescriptor? descriptor;
  //ByteData? coverBytes;
  Uint8List? coverBytes2;
  String? coverMime2;
  if (apic != null) {
    //descriptor = await ui.ImageDescriptor.encoded(await ui.ImmutableBuffer.fromUint8List(base64Decode(apic)));
    //coverBytes = await (await (await descriptor.instantiateCodec()).getNextFrame()).image.toByteData(format: ui.ImageByteFormat.png);
    coverMime2 = rawTags["APIC"]["mime"];
    coverBytes2 = base64Decode(apic);
    // if (rawTags["APIC"]["mime"] == "image/jpeg") {
    //   coverBytes2 = base64Decode(apic);//img.decodeJpg(base64Decode(apic))?.getBytes(format: img.Format.argb);
    // } else if (rawTags["APIC"]["mime"] == "image/gif") {
    //   coverBytes2 = Uint8List.fromList(base64Decode(apic)); // let Flutter do the decoding
    // } else if (rawTags["APIC"]["mime"] == "image/png") {
    //   coverBytes2 = img.decodePng(base64Decode(apic))?.getBytes(format: img.Format.argb); // let Flutter do the decoding
    // } else {
    //   coverBytes2 = img.decodeImage(base64Decode(apic))?.getBytes(format: img.Format.argb);
    // }
  }
  
  final Map<String, dynamic> flacdata = {};
  for (final block in flac) {
    switch (block.blockType) {
      case BlockType.VORBIS_COMMENT:
        for (var element in (block as VorbisComment).comments) {
          if (element.startsWith("TITLE=")) flacdata.putIfAbsent("title", () => element.replaceFirst("TITLE=", ""));
          if (element.startsWith("ARTIST=")) flacdata.putIfAbsent("artist", () => element.replaceFirst("ARTIST=", ""));
          if (element.startsWith("ALBUM=")) flacdata.putIfAbsent("album", () => element.replaceFirst("ALBUM=", ""));
          if (element.startsWith("TRACKNUMBER=")) flacdata.putIfAbsent("track", () => element.replaceFirst("TRACKNUMBER=", ""));
          if (element.startsWith("DISCNUMBER=")) flacdata.putIfAbsent("disc", () => element.replaceFirst("DISCNUMBER=", ""));
          //if (element.startsWith("ORIGINALDATE=")) flacdata.putIfAbsent("date", () => element.replaceFirst("ORIGINALDATE=", ""));
          if (element.startsWith("ORIGINALYEAR=")) flacdata.putIfAbsent("year", () => element.replaceFirst("ORIGINALYEAR=", ""));
        }
        break;
      case BlockType.PICTURE:
        if ((block as Picture).pictureType == 3) { // Cover (front)
          //descriptor = await ui.ImageDescriptor.encoded(await ui.ImmutableBuffer.fromUint8List(block.image));
          // if (block.mimeString == "image/jpeg") {
          //   coverBytes2 = img.decodeJpg(block.image)?.getBytes();
          // } else {
          //   coverBytes2 = img.decodeImage(block.image)?.getBytes();
          // }
          coverMime2 = block.mimeString;
          coverBytes2 = block.image;
        }
        break;
      default:
    }
  }

  // cache the image if there isn't an adjacent one
  FileSystemEntity? coverFile;
  if (coverBytes2 != null) {
    // Use the file's built-in cover if it's there.
    final _dir = cacheDir != null ? cacheDir+"/album_covers" : await getCacheDirectory("album_covers");
    final _b = coverBytes2; //?? coverBytes!.buffer.asUint8List();
    final _x = extensionFromMime(coverMime2 ?? MimeTypeResolver().lookup("cover", headerBytes: _b.sublist(0,20)) ?? "image/bmp");
    coverFile = File(_dir+"/"+base64Encode((flacdata["artist"] ?? rawTags["Artist"]).codeUnits)+"."+base64Encode((flacdata["album"] ?? rawTags["Album"]).codeUnits)+"."+_x);
    if (/*!await coverFile.exists()*/true) {
      if (kDebugMode) {
        print("Caching non-adjacent cover!");
      }
      await Directory(_dir).create();
      await (coverFile as File).writeAsBytes(_b);
      //await coverFile.copy("/storage/emulated/0/Downloads/"+coverFile.uri.pathSegments.last);
    }
  }
  coverFile ??= await inferCoverFile(file);

  // Output
  return TrackMetadata(
    title: flacdata["title"] ?? rawTags["Title"],
    artistName: flacdata["artist"] ?? rawTags["Artist"],
    albumName: flacdata["album"] ?? rawTags["Album"],
    year: int.tryParse(flacdata["year"] ?? rawTags["Year"] ?? ""),
    //coverData: descriptor,
    trackNo: int.tryParse((flacdata["track"] ?? rawTags["Track"] ?? "").replaceFirst(RegExp(r"\/[0-9]*"), "")),
    discNo: int.tryParse((flacdata["disc"]?.toString() ?? rawTags["Disc"] ?? "").replaceFirst(RegExp(r"\/[0-9]*"), "")) ?? 0,
    uri: file.absolute.uri,
    coverBytes: coverBytes2, //?? coverBytes?.buffer.asUint8List(),
    coverUri: coverFile?.absolute.uri
  );
}