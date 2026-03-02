import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';
import '../../data/course_search_service.dart';
import '../../domain/golf_course.dart';

/// Provider for CourseSearchService
final courseSearchServiceProvider = Provider<CourseSearchService>((ref) {
  return CourseSearchService(apiKey: AppConstants.googlePlacesApiKey);
});

/// Provider for course search results
final courseSearchResultsProvider =
    StateNotifierProvider<CourseSearchNotifier, AsyncValue<List<GolfCourse>>>((ref) {
  final service = ref.watch(courseSearchServiceProvider);
  return CourseSearchNotifier(service);
});

/// StateNotifier for course search
class CourseSearchNotifier extends StateNotifier<AsyncValue<List<GolfCourse>>> {
  final CourseSearchService _service;

  CourseSearchNotifier(this._service) : super(const AsyncValue.data([]));

  Future<void> search(String query) async {
    if (query.trim().length < 2) {
      state = const AsyncValue.data([]);
      return;
    }

    state = const AsyncValue.loading();

    try {
      final results = await _service.searchCourses(query);
      state = AsyncValue.data(results);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<GolfCourse?> getDetails(String placeId) async {
    try {
      return await _service.getCourseDetails(placeId);
    } catch (e) {
      return null;
    }
  }

  void clear() {
    state = const AsyncValue.data([]);
  }
}

/// Provider for selected course
final selectedCourseProvider = StateProvider<GolfCourse?>((ref) => null);
