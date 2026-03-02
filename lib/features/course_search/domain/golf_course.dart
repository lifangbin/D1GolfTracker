import 'package:freezed_annotation/freezed_annotation.dart';

part 'golf_course.freezed.dart';
part 'golf_course.g.dart';

/// Golf course model for search results
@freezed
class GolfCourse with _$GolfCourse {
  const factory GolfCourse({
    required String id,
    required String name,
    String? city,
    String? state,
    @Default('Australia') String country,
    String? address,
    double? latitude,
    double? longitude,
    int? par,
    double? slopeRating,
    double? courseRating,
    String? phoneNumber,
    String? website,
    String? placeId, // Google Places ID for additional details
  }) = _GolfCourse;

  factory GolfCourse.fromJson(Map<String, dynamic> json) =>
      _$GolfCourseFromJson(json);
}

/// Extension for display helpers
extension GolfCourseX on GolfCourse {
  String get locationDisplay {
    final parts = <String>[];
    if (city != null) parts.add(city!);
    if (state != null) parts.add(state!);
    if (parts.isEmpty && country.isNotEmpty) parts.add(country);
    return parts.join(', ');
  }

  String get fullAddress {
    if (address != null) return address!;
    return locationDisplay;
  }
}
