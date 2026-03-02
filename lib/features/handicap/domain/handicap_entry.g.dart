// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'handicap_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HandicapEntryImpl _$$HandicapEntryImplFromJson(Map<String, dynamic> json) =>
    _$HandicapEntryImpl(
      id: json['id'] as String,
      playerId: json['playerId'] as String,
      handicapIndex: (json['handicapIndex'] as num).toDouble(),
      lowHandicap: (json['lowHandicap'] as num?)?.toDouble(),
      effectiveDate: DateTime.parse(json['effectiveDate'] as String),
      source: json['source'] as String? ?? 'manual',
      roundsCounted: (json['roundsCounted'] as num?)?.toInt(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$HandicapEntryImplToJson(_$HandicapEntryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'playerId': instance.playerId,
      'handicapIndex': instance.handicapIndex,
      'lowHandicap': instance.lowHandicap,
      'effectiveDate': instance.effectiveDate.toIso8601String(),
      'source': instance.source,
      'roundsCounted': instance.roundsCounted,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
