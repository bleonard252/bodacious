// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PlaylistMetadata _$$_PlaylistMetadataFromJson(Map<String, dynamic> json) =>
    _$_PlaylistMetadata(
      id: json['id'] as String? ?? "",
      name: json['name'] as String,
      coverUri: json['coverUri'] == null
          ? null
          : Uri.parse(json['coverUri'] as String),
      coverSource: json['coverSource'] as String?,
      description: json['description'] as String?,
      trackCount: json['trackCount'] as int?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      index: json['index'] as int?,
    );

Map<String, dynamic> _$$_PlaylistMetadataToJson(_$_PlaylistMetadata instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'coverUri': instance.coverUri?.toString(),
      'coverSource': instance.coverSource,
      'description': instance.description,
      'trackCount': instance.trackCount,
      'createdAt': instance.createdAt?.toIso8601String(),
      'index': instance.index,
    };
