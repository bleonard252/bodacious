// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ArtistMetadata _$$_ArtistMetadataFromJson(Map<String, dynamic> json) =>
    _$_ArtistMetadata(
      name: json['name'] as String,
      coverUri: json['coverUri'] == null
          ? null
          : Uri.parse(json['coverUri'] as String),
      albumCount: json['albumCount'] as int?,
      trackCount: json['trackCount'] as int?,
    );

Map<String, dynamic> _$$_ArtistMetadataToJson(_$_ArtistMetadata instance) =>
    <String, dynamic>{
      'name': instance.name,
      'coverUri': instance.coverUri?.toString(),
      'albumCount': instance.albumCount,
      'trackCount': instance.trackCount,
    };
