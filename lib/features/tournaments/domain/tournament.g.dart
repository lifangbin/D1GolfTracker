// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tournament.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TournamentImpl _$$TournamentImplFromJson(Map<String, dynamic> json) =>
    _$TournamentImpl(
      id: json['id'] as String,
      playerId: json['playerId'] as String,
      name: json['name'] as String,
      tournamentType: json['tournamentType'] as String?,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      courseName: json['courseName'] as String,
      courseCity: json['courseCity'] as String?,
      courseState: json['courseState'] as String?,
      courseCountry: json['courseCountry'] as String? ?? 'Australia',
      coursePar: (json['coursePar'] as num?)?.toInt(),
      courseSlope: (json['courseSlope'] as num?)?.toDouble(),
      courseRating: (json['courseRating'] as num?)?.toDouble(),
      totalScore: (json['totalScore'] as num?)?.toInt(),
      position: (json['position'] as num?)?.toInt(),
      fieldSize: (json['fieldSize'] as num?)?.toInt(),
      scoreToPar: (json['scoreToPar'] as num?)?.toInt(),
      notes: json['notes'] as String?,
      weatherConditions: json['weatherConditions'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$TournamentImplToJson(_$TournamentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'playerId': instance.playerId,
      'name': instance.name,
      'tournamentType': instance.tournamentType,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'courseName': instance.courseName,
      'courseCity': instance.courseCity,
      'courseState': instance.courseState,
      'courseCountry': instance.courseCountry,
      'coursePar': instance.coursePar,
      'courseSlope': instance.courseSlope,
      'courseRating': instance.courseRating,
      'totalScore': instance.totalScore,
      'position': instance.position,
      'fieldSize': instance.fieldSize,
      'scoreToPar': instance.scoreToPar,
      'notes': instance.notes,
      'weatherConditions': instance.weatherConditions,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_$RoundImpl _$$RoundImplFromJson(Map<String, dynamic> json) => _$RoundImpl(
  id: json['id'] as String,
  tournamentId: json['tournamentId'] as String?,
  playerId: json['playerId'] as String,
  roundNumber: (json['roundNumber'] as num?)?.toInt() ?? 1,
  roundDate: DateTime.parse(json['roundDate'] as String),
  courseName: json['courseName'] as String?,
  teePlayed: json['teePlayed'] as String?,
  coursePar: (json['coursePar'] as num?)?.toInt(),
  courseSlope: (json['courseSlope'] as num?)?.toDouble(),
  courseRating: (json['courseRating'] as num?)?.toDouble(),
  grossScore: (json['grossScore'] as num).toInt(),
  netScore: (json['netScore'] as num?)?.toInt(),
  playingHandicap: (json['playingHandicap'] as num?)?.toDouble(),
  differential: (json['differential'] as num?)?.toDouble(),
  fairwaysHit: (json['fairwaysHit'] as num?)?.toInt(),
  fairwaysTotal: (json['fairwaysTotal'] as num?)?.toInt(),
  greensInRegulation: (json['greensInRegulation'] as num?)?.toInt(),
  putts: (json['putts'] as num?)?.toInt(),
  penalties: (json['penalties'] as num?)?.toInt() ?? 0,
  isPractice: json['isPractice'] as bool? ?? false,
  isCountedForHandicap: json['isCountedForHandicap'] as bool? ?? true,
  notes: json['notes'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$$RoundImplToJson(_$RoundImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tournamentId': instance.tournamentId,
      'playerId': instance.playerId,
      'roundNumber': instance.roundNumber,
      'roundDate': instance.roundDate.toIso8601String(),
      'courseName': instance.courseName,
      'teePlayed': instance.teePlayed,
      'coursePar': instance.coursePar,
      'courseSlope': instance.courseSlope,
      'courseRating': instance.courseRating,
      'grossScore': instance.grossScore,
      'netScore': instance.netScore,
      'playingHandicap': instance.playingHandicap,
      'differential': instance.differential,
      'fairwaysHit': instance.fairwaysHit,
      'fairwaysTotal': instance.fairwaysTotal,
      'greensInRegulation': instance.greensInRegulation,
      'putts': instance.putts,
      'penalties': instance.penalties,
      'isPractice': instance.isPractice,
      'isCountedForHandicap': instance.isCountedForHandicap,
      'notes': instance.notes,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
