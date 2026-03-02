// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TrainingSessionImpl _$$TrainingSessionImplFromJson(
  Map<String, dynamic> json,
) => _$TrainingSessionImpl(
  id: json['id'] as String,
  playerId: json['playerId'] as String,
  date: DateTime.parse(json['date'] as String),
  type: $enumDecode(_$TrainingTypeEnumMap, json['type']),
  durationMinutes: (json['durationMinutes'] as num).toInt(),
  location: json['location'] as String?,
  intensity: $enumDecodeNullable(_$TrainingIntensityEnumMap, json['intensity']),
  focusAreas:
      (json['focusAreas'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$TrainingFocusEnumMap, e))
          .toList() ??
      const [],
  notes: json['notes'] as String?,
  coachName: json['coachName'] as String?,
  ballsHit: (json['ballsHit'] as num?)?.toInt(),
  puttsMade: (json['puttsMade'] as num?)?.toInt(),
  puttsAttempted: (json['puttsAttempted'] as num?)?.toInt(),
  rating: (json['rating'] as num?)?.toDouble(),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$$TrainingSessionImplToJson(
  _$TrainingSessionImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'playerId': instance.playerId,
  'date': instance.date.toIso8601String(),
  'type': _$TrainingTypeEnumMap[instance.type]!,
  'durationMinutes': instance.durationMinutes,
  'location': instance.location,
  'intensity': _$TrainingIntensityEnumMap[instance.intensity],
  'focusAreas': instance.focusAreas
      .map((e) => _$TrainingFocusEnumMap[e]!)
      .toList(),
  'notes': instance.notes,
  'coachName': instance.coachName,
  'ballsHit': instance.ballsHit,
  'puttsMade': instance.puttsMade,
  'puttsAttempted': instance.puttsAttempted,
  'rating': instance.rating,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};

const _$TrainingTypeEnumMap = {
  TrainingType.driving: 'driving',
  TrainingType.putting: 'putting',
  TrainingType.chipping: 'chipping',
  TrainingType.bunker: 'bunker',
  TrainingType.fullSwing: 'fullSwing',
  TrainingType.course: 'course',
  TrainingType.fitness: 'fitness',
  TrainingType.mentalGame: 'mentalGame',
  TrainingType.lesson: 'lesson',
  TrainingType.simulator: 'simulator',
};

const _$TrainingIntensityEnumMap = {
  TrainingIntensity.light: 'light',
  TrainingIntensity.moderate: 'moderate',
  TrainingIntensity.intense: 'intense',
};

const _$TrainingFocusEnumMap = {
  TrainingFocus.accuracy: 'accuracy',
  TrainingFocus.distance: 'distance',
  TrainingFocus.consistency: 'consistency',
  TrainingFocus.shortGame: 'shortGame',
  TrainingFocus.speed: 'speed',
  TrainingFocus.technique: 'technique',
  TrainingFocus.mentalGame: 'mentalGame',
  TrainingFocus.courseManagement: 'courseManagement',
};
