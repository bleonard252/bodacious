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
      uri: json['uri'] == null ? null : Uri.parse(json['uri'] as String),
      coverUri: json['coverUri'] == null
          ? null
          : Uri.parse(json['coverUri'] as String),
    );

Map<String, dynamic> _$$_TrackMetadataToJson(_$_TrackMetadata instance) =>
    <String, dynamic>{
      'title': instance.title,
      'artistName': instance.artistName,
      'albumName': instance.albumName,
      'uri': instance.uri?.toString(),
      'coverUri': instance.coverUri?.toString(),
    };
