// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlayerImpl _$$PlayerImplFromJson(Map<String, dynamic> json) => _$PlayerImpl(
  id: json['id'] as String,
  userId: json['userId'] as String,
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  dateOfBirth: DateTime.parse(json['dateOfBirth'] as String),
  gender: json['gender'] as String?,
  avatarUrl: json['avatarUrl'] as String?,
  gaNumber: json['gaNumber'] as String?,
  gaConnected: json['gaConnected'] as bool? ?? false,
  gaLastSync: json['gaLastSync'] == null
      ? null
      : DateTime.parse(json['gaLastSync'] as String),
  currentHandicap: (json['currentHandicap'] as num?)?.toDouble(),
  currentPhase: (json['currentPhase'] as num?)?.toInt() ?? 1,
  homeCourse: json['homeCourse'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$$PlayerImplToJson(_$PlayerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'dateOfBirth': instance.dateOfBirth.toIso8601String(),
      'gender': instance.gender,
      'avatarUrl': instance.avatarUrl,
      'gaNumber': instance.gaNumber,
      'gaConnected': instance.gaConnected,
      'gaLastSync': instance.gaLastSync?.toIso8601String(),
      'currentHandicap': instance.currentHandicap,
      'currentPhase': instance.currentPhase,
      'homeCourse': instance.homeCourse,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
