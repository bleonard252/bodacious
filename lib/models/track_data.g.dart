// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TrackMetadata _$$_TrackMetadataFromJson(Map<String, dynamic> json) =>
    _$_TrackMetadata(
      id: json['id'] as String? ?? "",
      title: json['title'] as String?,
      artistName: json['artistName'] as String?,
      albumArtistName: json['albumArtistName'] as String?,
      albumArtistId: json['albumArtistId'] as String? ?? "",
      trackArtistId: json['trackArtistId'] as String? ?? "",
      albumName: json['albumName'] as String?,
      albumId: json['albumId'] as String? ?? "",
      trackNo: json['trackNo'] as int?,
      discNo: json['discNo'] as int? ?? 0,
      description: json['description'] as String?,
      descriptionSource: json['descriptionSource'] as String?,
      uri: Uri.parse(json['uri'] as String),
      coverUri: json['coverUri'] == null
          ? null
          : Uri.parse(json['coverUri'] as String),
      coverUriRemote: json['coverUriRemote'] == null
          ? null
          : Uri.parse(json['coverUriRemote'] as String),
      coverSource: json['coverSource'] as String? ?? "album",
      duration: json['duration'] == null
          ? null
          : Duration(microseconds: json['duration'] as int),
      year: json['year'] as int?,
      releaseDate: json['releaseDate'] == null
          ? null
          : DateTime.parse(json['releaseDate'] as String),
      available: json['available'] as bool? ?? true,
      spotifyId: json['spotifyId'] as String?,
      source: json['source'] as String? ?? "local",
      metadataSource: json['metadataSource'] as String?,
    );

Map<String, dynamic> _$$_TrackMetadataToJson(_$_TrackMetadata instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'artistName': instance.artistName,
      'albumArtistName': instance.albumArtistName,
      'albumArtistId': instance.albumArtistId,
      'trackArtistId': instance.trackArtistId,
      'albumName': instance.albumName,
      'albumId': instance.albumId,
      'trackNo': instance.trackNo,
      'discNo': instance.discNo,
      'description': instance.description,
      'descriptionSource': instance.descriptionSource,
      'uri': instance.uri.toString(),
      'coverUri': instance.coverUri?.toString(),
      'coverUriRemote': instance.coverUriRemote?.toString(),
      'coverSource': instance.coverSource,
      'duration': instance.duration?.inMicroseconds,
      'year': instance.year,
      'releaseDate': instance.releaseDate?.toIso8601String(),
      'available': instance.available,
      'spotifyId': instance.spotifyId,
      'source': instance.source,
      'metadataSource': instance.metadataSource,
    };
