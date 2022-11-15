import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bodacious/models/track_data.dart';
import 'package:bodacious/src/library/cache_dir.dart';
import 'package:bodacious/src/metadata/infer.dart';
import 'package:flac_metadata/flacstream.dart';
// ignore: library_prefixes
import 'package:flac_metadata/metadata.dart' as FLAC;
import 'package:flinq/flinq.dart';
import 'package:id3tag/id3tag.dart' as id3;
//import 'package:id3/id3.dart';

import 'package:mime/mime.dart';
import 'package:pinelogger/pinelogger.dart';

Future<TrackMetadata> loadID3Metadata(File file, {String? cacheDir, Pinelogger? logger}) async {
  logger ??= Pinelogger("IndexerFallback");
  logger = logger.child("loadID3Metadata");
  late final id3.ID3Tag mp3Tag;
  late final List<FLAC.Metadata> flac;
  try {
    final mp3 = id3.ID3TagReader(file);
    mp3Tag = await mp3.readTag();
  } catch(e) {
    logger.error("Failed to load ID3 tag", error: e);
  }
  try {
    flac = await FlacInfo(file).readMetadatas();
  } catch(e) {
    logger.error("Failed to load FLAC metadata", error: e);
  }

  final apic = mp3Tag.pictures.firstOrNullWhere((e) => e.picType == 'FrontCover');//rawTags["APIC"]?["base64"];
  Uint8List? coverBytes2;
  String? coverMime2;
  if (apic != null) {
    coverMime2 = apic.mime;
    coverBytes2 = Uint8List.fromList(apic.imageData);
  }
  
  final Map<String, dynamic> flacdata = {};
  for (final block in flac) {
    switch (block.blockType) {
      case FLAC.BlockType.VORBIS_COMMENT:
        for (var element in (block as FLAC.VorbisComment).comments) {
          if (element.startsWith("TITLE=")) flacdata.putIfAbsent("title", () => element.replaceFirst("TITLE=", ""));
          if (element.startsWith("ARTIST=")) flacdata.putIfAbsent("artist", () => element.replaceFirst("ARTIST=", ""));
          if (element.startsWith("ALBUMARTIST=")) flacdata.putIfAbsent("albumartist", () => element.replaceFirst("ALBUMARTIST=", ""));
          if (element.startsWith("ALBUM=")) flacdata.putIfAbsent("album", () => element.replaceFirst("ALBUM=", ""));
          if (element.startsWith("TRACKNUMBER=")) flacdata.putIfAbsent("track", () => element.replaceFirst("TRACKNUMBER=", ""));
          if (element.startsWith("DISCNUMBER=")) flacdata.putIfAbsent("disc", () => element.replaceFirst("DISCNUMBER=", ""));
          //if (element.startsWith("ORIGINALDATE=")) flacdata.putIfAbsent("date", () => element.replaceFirst("ORIGINALDATE=", ""));
          if (element.startsWith("ORIGINALYEAR=")) flacdata.putIfAbsent("year", () => element.replaceFirst("ORIGINALYEAR=", ""));
        }
        break;
      case FLAC.BlockType.PICTURE:
        if ((block as FLAC.Picture).pictureType == 3) { // Cover (front)
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
    coverFile = File(_dir+"/"+base64Encode(utf8.encode(flacdata["artist"] ?? mp3Tag.artist))+"."+base64Encode(utf8.encode(flacdata["album"] ?? mp3Tag.album ?? ""))+"."+_x);
    if (!await coverFile.exists()) {
      // if (kDebugMode) {
      //   print("Caching non-adjacent cover!");
      // }
      await Directory(_dir).create();
      await (coverFile as File).writeAsBytes(_b);
      //await coverFile.copy("/storage/emulated/0/Downloads/"+coverFile.uri.pathSegments.last);
    }
  }
  coverFile ??= await inferCoverFile(file);


  // Output
  return TrackMetadata(
    title: flacdata["title"] ?? mp3Tag.title,
    artistName: flacdata["artist"] ?? mp3Tag.artist,
    albumName: flacdata["album"] ?? mp3Tag.album,
    albumArtistName: flacdata["albumartist"] ?? mp3Tag.albumArtist,
    year: int.tryParse(flacdata["year"] ?? mp3Tag.year ?? ""),
    //coverData: descriptor,
    trackNo: int.tryParse((flacdata["track"] ?? mp3Tag.trackNumber ?? "").replaceFirst(RegExp(r"\/[0-9]*"), "")),
    discNo: int.tryParse((flacdata["disc"]?.toString() ?? mp3Tag.discNumber ?? "").replaceFirst(RegExp(r"\/[0-9]*"), "")) ?? 0,
    uri: file.absolute.uri,
    coverBytes: coverBytes2, //?? coverBytes?.buffer.asUint8List(),
    coverUri: coverFile?.absolute.uri
  );
}

extension on id3.ID3Tag {
  get albumArtist => frameWithTypeAndName<id3.TextInformation>("TPE2")?.value;
  get year => frameWithTypeAndName<id3.TextInformation>("TYER")?.value;
  get discNumber => frameWithTypeAndName<id3.TextInformation>("TPOS")?.value.replaceAll(RegExp(r"/.*"), "");
}