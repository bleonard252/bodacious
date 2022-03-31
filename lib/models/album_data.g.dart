// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AlbumMetadata _$$_AlbumMetadataFromJson(Map<String, dynamic> json) =>
    _$_AlbumMetadata(
      artistName: json['artistName'] as String,
      name: json['name'] as String,
      coverUri: json['coverUri'] == null
          ? null
          : Uri.parse(json['coverUri'] as String),
      trackCount: json['trackCount'] as int?,
      year: json['year'] as int?,
      releaseDate: json['releaseDate'] == null
          ? null
          : DateTime.parse(json['releaseDate'] as String),
    );

Map<String, dynamic> _$$_AlbumMetadataToJson(_$_AlbumMetadata instance) =>
    <String, dynamic>{
      'artistName': instance.artistName,
      'name': instance.name,
      'coverUri': instance.coverUri?.toString(),
      'trackCount': instance.trackCount,
      'year': instance.year,
      'releaseDate': instance.releaseDate?.toIso8601String(),
    };
