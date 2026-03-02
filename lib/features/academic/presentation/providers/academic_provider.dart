import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/player_provider.dart';
import '../../data/academic_repository.dart';
import '../../domain/academic_record.dart';

/// Repository provider
final academicRepositoryProvider = Provider<AcademicRepository>((ref) {
  return AcademicRepository();
});

/// Academic profile provider
final academicProfileProvider =
    FutureProvider.autoDispose<AcademicProfile>((ref) async {
  final player = ref.watch(playerNotifierProvider).valueOrNull;
  if (player == null) {
    return AcademicProfile(
      playerId: '',
      cumulativeGpa: 0.0,
      weightedGpa: 0.0,
      totalCredits: 0,
      yearSummaries: [],
    );
  }

  final repository = ref.watch(academicRepositoryProvider);
  return repository.getAcademicProfile(player.id);
});

/// All course grades provider
final courseGradesProvider =
    FutureProvider.autoDispose<List<CourseGrade>>((ref) async {
  final player = ref.watch(playerNotifierProvider).valueOrNull;
  if (player == null) return [];

  final repository = ref.watch(academicRepositoryProvider);
  return repository.getCourseGrades(player.id);
});

/// Grades for a specific year
final gradesForYearProvider =
    FutureProvider.autoDispose.family<List<CourseGrade>, int>((ref, year) async {
  final player = ref.watch(playerNotifierProvider).valueOrNull;
  if (player == null) return [];

  final repository = ref.watch(academicRepositoryProvider);
  return repository.getGradesForYear(player.id, year);
});

/// Academic notifier for mutations
final academicNotifierProvider =
    StateNotifierProvider<AcademicNotifier, AsyncValue<void>>((ref) {
  return AcademicNotifier(ref);
});

class AcademicNotifier extends StateNotifier<AsyncValue<void>> {
  final Ref _ref;

  AcademicNotifier(this._ref) : super(const AsyncValue.data(null));

  Future<void> addCourseGrade({
    required String courseName,
    required SubjectCategory category,
    required GradeLevel gradeLevel,
    required int year,
    required AcademicTerm term,
    required LetterGrade grade,
    double? percentageScore,
    double? creditHours,
    bool? isApHonors,
    bool? isWeighted,
    String? teacherName,
    String? notes,
  }) async {
    final player = _ref.read(playerNotifierProvider).valueOrNull;
    if (player == null) return;

    state = const AsyncValue.loading();
    try {
      final repository = _ref.read(academicRepositoryProvider);
      await repository.addCourseGrade(
        playerId: player.id,
        courseName: courseName,
        category: category,
        gradeLevel: gradeLevel,
        year: year,
        term: term,
        grade: grade,
        percentageScore: percentageScore,
        creditHours: creditHours,
        isApHonors: isApHonors,
        isWeighted: isWeighted,
        teacherName: teacherName,
        notes: notes,
      );

      // Invalidate providers
      _ref.invalidate(academicProfileProvider);
      _ref.invalidate(courseGradesProvider);

      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateCourseGrade({
    required String gradeId,
    String? courseName,
    SubjectCategory? category,
    LetterGrade? grade,
    double? percentageScore,
    double? creditHours,
    bool? isApHonors,
    bool? isWeighted,
    String? teacherName,
    String? notes,
  }) async {
    state = const AsyncValue.loading();
    try {
      final repository = _ref.read(academicRepositoryProvider);
      await repository.updateCourseGrade(
        gradeId: gradeId,
        courseName: courseName,
        category: category,
        grade: grade,
        percentageScore: percentageScore,
        creditHours: creditHours,
        isApHonors: isApHonors,
        isWeighted: isWeighted,
        teacherName: teacherName,
        notes: notes,
      );

      // Invalidate providers
      _ref.invalidate(academicProfileProvider);
      _ref.invalidate(courseGradesProvider);

      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteCourseGrade(String gradeId) async {
    state = const AsyncValue.loading();
    try {
      final repository = _ref.read(academicRepositoryProvider);
      await repository.deleteCourseGrade(gradeId);

      // Invalidate providers
      _ref.invalidate(academicProfileProvider);
      _ref.invalidate(courseGradesProvider);

      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
