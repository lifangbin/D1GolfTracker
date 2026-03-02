// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hole_score.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HoleScoreImpl _$$HoleScoreImplFromJson(Map<String, dynamic> json) =>
    _$HoleScoreImpl(
      id: json['id'] as String,
      roundId: json['roundId'] as String,
      holeNumber: (json['holeNumber'] as num).toInt(),
      par: (json['par'] as num).toInt(),
      strokeIndex: (json['strokeIndex'] as num?)?.toInt(),
      strokes: (json['strokes'] as num).toInt(),
      putts: (json['putts'] as num?)?.toInt(),
      fairwayHit: json['fairwayHit'] as bool?,
      greenInRegulation: json['greenInRegulation'] as bool?,
      sandSave: json['sandSave'] as bool?,
      upAndDown: json['upAndDown'] as bool?,
      penaltyStrokes: (json['penaltyStrokes'] as num?)?.toInt() ?? 0,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$HoleScoreImplToJson(_$HoleScoreImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'roundId': instance.roundId,
      'holeNumber': instance.holeNumber,
      'par': instance.par,
      'strokeIndex': instance.strokeIndex,
      'strokes': instance.strokes,
      'putts': instance.putts,
      'fairwayHit': instance.fairwayHit,
      'greenInRegulation': instance.greenInRegulation,
      'sandSave': instance.sandSave,
      'upAndDown': instance.upAndDown,
      'penaltyStrokes': instance.penaltyStrokes,
      'notes': instance.notes,
    };
