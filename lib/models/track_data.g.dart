// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TrackMetadata _$$_TrackMetadataFromJson(Map<String, dynamic> json) =>
    _$_TrackMetadata(
      title: json['title'] as String?,
      artistName: json['artistName'] as String?,
      albumName: json['albumName'] as String?,
      trackNo: json['trackNo'] as int?,
      discNo: json['discNo'] as int? ?? 0,
      uri: Uri.parse(json['uri'] as String),
      coverUri: json['coverUri'] == null
          ? null
          : Uri.parse(json['coverUri'] as String),
      duration: json['duration'] == null
          ? null
          : Duration(microseconds: json['duration'] as int),
      year: json['year'] as int?,
      releaseDate: json['releaseDate'] == null
          ? null
          : DateTime.parse(json['releaseDate'] as String),
    );

Map<String, dynamic> _$$_TrackMetadataToJson(_$_TrackMetadata instance) =>
    <String, dynamic>{
      'title': instance.title,
      'artistName': instance.artistName,
      'albumName': instance.albumName,
      'trackNo': instance.trackNo,
      'discNo': instance.discNo,
      'uri': instance.uri.toString(),
      'coverUri': instance.coverUri?.toString(),
      'duration': instance.duration?.inMicroseconds,
      'year': instance.year,
      'releaseDate': instance.releaseDate?.toIso8601String(),
    };
