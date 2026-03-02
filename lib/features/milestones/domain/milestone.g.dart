// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'milestone.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MilestoneDefinitionImpl _$$MilestoneDefinitionImplFromJson(
  Map<String, dynamic> json,
) => _$MilestoneDefinitionImpl(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  phase: (json['phase'] as num).toInt(),
  category: $enumDecode(_$MilestoneCategoryEnumMap, json['category']),
  sortOrder: (json['sortOrder'] as num).toInt(),
  targetValue: json['targetValue'] as String?,
  unit: json['unit'] as String?,
);

Map<String, dynamic> _$$MilestoneDefinitionImplToJson(
  _$MilestoneDefinitionImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'phase': instance.phase,
  'category': _$MilestoneCategoryEnumMap[instance.category]!,
  'sortOrder': instance.sortOrder,
  'targetValue': instance.targetValue,
  'unit': instance.unit,
};

const _$MilestoneCategoryEnumMap = {
  MilestoneCategory.handicap: 'handicap',
  MilestoneCategory.tournament: 'tournament',
  MilestoneCategory.training: 'training',
  MilestoneCategory.skill: 'skill',
  MilestoneCategory.academic: 'academic',
  MilestoneCategory.recruiting: 'recruiting',
};

_$PlayerMilestoneImpl _$$PlayerMilestoneImplFromJson(
  Map<String, dynamic> json,
) => _$PlayerMilestoneImpl(
  id: json['id'] as String,
  playerId: json['playerId'] as String,
  milestoneId: json['milestoneId'] as String,
  isCompleted: json['isCompleted'] as bool? ?? false,
  completedAt: json['completedAt'] == null
      ? null
      : DateTime.parse(json['completedAt'] as String),
  notes: json['notes'] as String?,
  mediaUrl: json['mediaUrl'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$$PlayerMilestoneImplToJson(
  _$PlayerMilestoneImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'playerId': instance.playerId,
  'milestoneId': instance.milestoneId,
  'isCompleted': instance.isCompleted,
  'completedAt': instance.completedAt?.toIso8601String(),
  'notes': instance.notes,
  'mediaUrl': instance.mediaUrl,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};
