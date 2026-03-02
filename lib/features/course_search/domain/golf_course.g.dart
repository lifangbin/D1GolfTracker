// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'golf_course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GolfCourseImpl _$$GolfCourseImplFromJson(Map<String, dynamic> json) =>
    _$GolfCourseImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String? ?? 'Australia',
      address: json['address'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      par: (json['par'] as num?)?.toInt(),
      slopeRating: (json['slopeRating'] as num?)?.toDouble(),
      courseRating: (json['courseRating'] as num?)?.toDouble(),
      phoneNumber: json['phoneNumber'] as String?,
      website: json['website'] as String?,
      placeId: json['placeId'] as String?,
    );

Map<String, dynamic> _$$GolfCourseImplToJson(_$GolfCourseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'par': instance.par,
      'slopeRating': instance.slopeRating,
      'courseRating': instance.courseRating,
      'phoneNumber': instance.phoneNumber,
      'website': instance.website,
      'placeId': instance.placeId,
    };
