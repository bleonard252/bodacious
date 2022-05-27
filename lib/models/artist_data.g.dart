// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ArtistMetadata _$$_ArtistMetadataFromJson(Map<String, dynamic> json) =>
    _$_ArtistMetadata(
      id: json['id'] as String? ?? "",
      name: json['name'] as String,
      coverUri: json['coverUri'] == null
          ? null
          : Uri.parse(json['coverUri'] as String),
      coverUriRemote: json['coverUriRemote'] == null
          ? null
          : Uri.parse(json['coverUriRemote'] as String),
      coverSource: json['coverSource'] as String?,
      description: json['description'] as String?,
      descriptionSource: json['descriptionSource'] as String?,
      albumCount: json['albumCount'] as int?,
      trackCount: json['trackCount'] as int?,
      spotifyId: json['spotifyId'] as String?,
      metadataSource: json['metadataSource'] as String?,
    );

Map<String, dynamic> _$$_ArtistMetadataToJson(_$_ArtistMetadata instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'coverUri': instance.coverUri?.toString(),
      'coverUriRemote': instance.coverUriRemote?.toString(),
      'coverSource': instance.coverSource,
      'description': instance.description,
      'descriptionSource': instance.descriptionSource,
      'albumCount': instance.albumCount,
      'trackCount': instance.trackCount,
      'spotifyId': instance.spotifyId,
      'metadataSource': instance.metadataSource,
    };
