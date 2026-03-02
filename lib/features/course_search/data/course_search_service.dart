import 'dart:convert';
import 'package:http/http.dart' as http;
import '../domain/golf_course.dart';

/// Service for searching golf courses using Google Places API
class CourseSearchService {
  final String _apiKey;
  static const String _baseUrl = 'https://maps.googleapis.com/maps/api/place';

  CourseSearchService({required String apiKey}) : _apiKey = apiKey;

  /// Search for golf courses by name/query
  /// Returns a list of matching golf courses
  Future<List<GolfCourse>> searchCourses(String query, {String? country}) async {
    if (query.trim().length < 2) return [];

    // Add "golf course" to improve search results
    final searchQuery = query.toLowerCase().contains('golf')
        ? query
        : '$query golf course';

    final uri = Uri.parse('$_baseUrl/textsearch/json').replace(
      queryParameters: {
        'query': searchQuery,
        'type': 'establishment',
        'key': _apiKey,
        if (country != null) 'region': country.toLowerCase(),
      },
    );

    try {
      final response = await http.get(uri);

      if (response.statusCode != 200) {
        throw Exception('Failed to search courses: ${response.statusCode}');
      }

      final data = json.decode(response.body) as Map<String, dynamic>;
      final results = data['results'] as List<dynamic>? ?? [];

      // Filter to only include golf-related results
      final golfResults = results.where((r) {
        final types = (r['types'] as List<dynamic>?) ?? [];
        final name = (r['name'] as String?)?.toLowerCase() ?? '';
        return types.contains('golf_course') ||
            name.contains('golf') ||
            name.contains('country club') ||
            name.contains('links');
      }).toList();

      return golfResults.map((result) => _parsePlace(result)).toList();
    } catch (e) {
      print('Error searching courses: $e');
      rethrow;
    }
  }

  /// Get detailed information about a specific course
  Future<GolfCourse?> getCourseDetails(String placeId) async {
    final uri = Uri.parse('$_baseUrl/details/json').replace(
      queryParameters: {
        'place_id': placeId,
        'fields': 'place_id,name,formatted_address,geometry,formatted_phone_number,website,address_components',
        'key': _apiKey,
      },
    );

    try {
      final response = await http.get(uri);

      if (response.statusCode != 200) {
        throw Exception('Failed to get course details: ${response.statusCode}');
      }

      final data = json.decode(response.body) as Map<String, dynamic>;
      final result = data['result'] as Map<String, dynamic>?;

      if (result == null) return null;

      return _parsePlaceDetails(result);
    } catch (e) {
      print('Error getting course details: $e');
      return null;
    }
  }

  GolfCourse _parsePlace(Map<String, dynamic> result) {
    final geometry = result['geometry'] as Map<String, dynamic>?;
    final location = geometry?['location'] as Map<String, dynamic>?;

    // Parse address components if available
    String? city;
    String? state;
    String? country;

    final addressComponents = result['address_components'] as List<dynamic>?;
    if (addressComponents != null) {
      for (final component in addressComponents) {
        final types = (component['types'] as List<dynamic>?) ?? [];
        if (types.contains('locality')) {
          city = component['long_name'] as String?;
        } else if (types.contains('administrative_area_level_1')) {
          state = component['short_name'] as String?;
        } else if (types.contains('country')) {
          country = component['long_name'] as String?;
        }
      }
    }

    // Try to extract city/state from formatted address if not in components
    final formattedAddress = result['formatted_address'] as String?;
    if (formattedAddress != null && (city == null || state == null)) {
      final parts = formattedAddress.split(',').map((s) => s.trim()).toList();
      if (parts.length >= 2) {
        if (city == null) city = parts[parts.length - 3];
        if (state == null && parts.length >= 3) {
          // State is often in format "NSW 2000"
          final statePart = parts[parts.length - 2];
          state = statePart.split(' ').first;
        }
      }
    }

    return GolfCourse(
      id: result['place_id'] as String? ?? '',
      name: result['name'] as String? ?? 'Unknown Course',
      city: city,
      state: state,
      country: country ?? 'Australia',
      address: formattedAddress,
      latitude: location?['lat'] as double?,
      longitude: location?['lng'] as double?,
      placeId: result['place_id'] as String?,
    );
  }

  GolfCourse _parsePlaceDetails(Map<String, dynamic> result) {
    final geometry = result['geometry'] as Map<String, dynamic>?;
    final location = geometry?['location'] as Map<String, dynamic>?;

    String? city;
    String? state;
    String? country;

    final addressComponents = result['address_components'] as List<dynamic>?;
    if (addressComponents != null) {
      for (final component in addressComponents) {
        final types = (component['types'] as List<dynamic>?) ?? [];
        if (types.contains('locality')) {
          city = component['long_name'] as String?;
        } else if (types.contains('administrative_area_level_1')) {
          state = component['short_name'] as String?;
        } else if (types.contains('country')) {
          country = component['long_name'] as String?;
        }
      }
    }

    return GolfCourse(
      id: result['place_id'] as String? ?? '',
      name: result['name'] as String? ?? 'Unknown Course',
      city: city,
      state: state,
      country: country ?? 'Australia',
      address: result['formatted_address'] as String?,
      latitude: location?['lat'] as double?,
      longitude: location?['lng'] as double?,
      phoneNumber: result['formatted_phone_number'] as String?,
      website: result['website'] as String?,
      placeId: result['place_id'] as String?,
    );
  }
}
