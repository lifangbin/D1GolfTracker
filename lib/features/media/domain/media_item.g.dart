// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MediaItemImpl _$$MediaItemImplFromJson(Map<String, dynamic> json) =>
    _$MediaItemImpl(
      id: json['id'] as String,
      playerId: json['playerId'] as String,
      tournamentId: json['tournamentId'] as String?,
      roundId: json['roundId'] as String?,
      holeNumber: json['holeNumber'] as String?,
      mediaType: $enumDecode(_$MediaTypeEnumMap, json['mediaType']),
      category:
          $enumDecodeNullable(_$MediaCategoryEnumMap, json['category']) ??
          MediaCategory.other,
      storagePath: json['storagePath'] as String,
      thumbnailPath: json['thumbnailPath'] as String?,
      originalFilename: json['originalFilename'] as String,
      url: json['url'] as String?,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      caption: json['caption'] as String?,
      description: json['description'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
      isHighlight: json['isHighlight'] as bool? ?? false,
      highlightNotes: json['highlightNotes'] as String?,
      durationSeconds: (json['durationSeconds'] as num?)?.toInt(),
      fileSizeBytes: (json['fileSizeBytes'] as num?)?.toInt(),
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
      capturedAt: json['capturedAt'] == null
          ? null
          : DateTime.parse(json['capturedAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$MediaItemImplToJson(_$MediaItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'playerId': instance.playerId,
      'tournamentId': instance.tournamentId,
      'roundId': instance.roundId,
      'holeNumber': instance.holeNumber,
      'mediaType': _$MediaTypeEnumMap[instance.mediaType]!,
      'category': _$MediaCategoryEnumMap[instance.category]!,
      'storagePath': instance.storagePath,
      'thumbnailPath': instance.thumbnailPath,
      'originalFilename': instance.originalFilename,
      'url': instance.url,
      'thumbnailUrl': instance.thumbnailUrl,
      'caption': instance.caption,
      'description': instance.description,
      'tags': instance.tags,
      'isHighlight': instance.isHighlight,
      'highlightNotes': instance.highlightNotes,
      'durationSeconds': instance.durationSeconds,
      'fileSizeBytes': instance.fileSizeBytes,
      'width': instance.width,
      'height': instance.height,
      'capturedAt': instance.capturedAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$MediaTypeEnumMap = {MediaType.photo: 'photo', MediaType.video: 'video'};

const _$MediaCategoryEnumMap = {
  MediaCategory.swing: 'swing',
  MediaCategory.tournament: 'tournament',
  MediaCategory.practice: 'practice',
  MediaCategory.course: 'course',
  MediaCategory.milestone: 'milestone',
  MediaCategory.other: 'other',
};
