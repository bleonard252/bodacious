// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AlbumMetadata _$$_AlbumMetadataFromJson(Map<String, dynamic> json) =>
    _$_AlbumMetadata(
      id: json['id'] as String? ?? "",
      artistName: json['artistName'] as String,
      artistId: json['artistId'] as String?,
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
      trackCount: json['trackCount'] as int?,
      year: json['year'] as int?,
      releaseDate: json['releaseDate'] == null
          ? null
          : DateTime.parse(json['releaseDate'] as String),
      spotifyId: json['spotifyId'] as String?,
      metadataSource: json['metadataSource'] as String?,
    );

Map<String, dynamic> _$$_AlbumMetadataToJson(_$_AlbumMetadata instance) =>
    <String, dynamic>{
      'id': instance.id,
      'artistName': instance.artistName,
      'artistId': instance.artistId,
      'name': instance.name,
      'coverUri': instance.coverUri?.toString(),
      'coverUriRemote': instance.coverUriRemote?.toString(),
      'coverSource': instance.coverSource,
      'description': instance.description,
      'descriptionSource': instance.descriptionSource,
      'trackCount': instance.trackCount,
      'year': instance.year,
      'releaseDate': instance.releaseDate?.toIso8601String(),
      'spotifyId': instance.spotifyId,
      'metadataSource': instance.metadataSource,
    };
