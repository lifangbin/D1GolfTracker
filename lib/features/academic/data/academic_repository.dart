import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants/app_constants.dart';
import '../domain/academic_record.dart';

class AcademicRepository {
  final _supabase = Supabase.instance.client;

  /// Get all course grades for a player
  Future<List<CourseGrade>> getCourseGrades(String playerId) async {
    final response = await _supabase
        .from(TableNames.academicRecords)
        .select()
        .eq('player_id', playerId)
        .order('year', ascending: false)
        .order('term', ascending: true);

    return (response as List).map((json) => _parseCourseGrade(json)).toList();
  }

  /// Get grades for a specific year
  Future<List<CourseGrade>> getGradesForYear(
    String playerId,
    int year,
  ) async {
    final response = await _supabase
        .from(TableNames.academicRecords)
        .select()
        .eq('player_id', playerId)
        .eq('year', year)
        .order('term', ascending: true);

    return (response as List).map((json) => _parseCourseGrade(json)).toList();
  }

  /// Add a new course grade
  Future<CourseGrade> addCourseGrade({
    required String playerId,
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
    final data = {
      'player_id': playerId,
      'course_name': courseName,
      'category': category.name,
      'grade_level': gradeLevel.value,
      'year': year,
      'term': term.name,
      'grade': grade.label,
      if (percentageScore != null) 'percentage_score': percentageScore,
      if (creditHours != null) 'credit_hours': creditHours,
      if (isApHonors != null) 'is_ap_honors': isApHonors,
      if (isWeighted != null) 'is_weighted': isWeighted,
      if (teacherName != null) 'teacher_name': teacherName,
      if (notes != null) 'notes': notes,
    };

    final response = await _supabase
        .from(TableNames.academicRecords)
        .insert(data)
        .select()
        .single();

    return _parseCourseGrade(response);
  }

  /// Update a course grade
  Future<CourseGrade> updateCourseGrade({
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
    final data = <String, dynamic>{};
    if (courseName != null) data['course_name'] = courseName;
    if (category != null) data['category'] = category.name;
    if (grade != null) data['grade'] = grade.label;
    if (percentageScore != null) data['percentage_score'] = percentageScore;
    if (creditHours != null) data['credit_hours'] = creditHours;
    if (isApHonors != null) data['is_ap_honors'] = isApHonors;
    if (isWeighted != null) data['is_weighted'] = isWeighted;
    if (teacherName != null) data['teacher_name'] = teacherName;
    if (notes != null) data['notes'] = notes;
    data['updated_at'] = DateTime.now().toIso8601String();

    final response = await _supabase
        .from(TableNames.academicRecords)
        .update(data)
        .eq('id', gradeId)
        .select()
        .single();

    return _parseCourseGrade(response);
  }

  /// Delete a course grade
  Future<void> deleteCourseGrade(String gradeId) async {
    await _supabase
        .from(TableNames.academicRecords)
        .delete()
        .eq('id', gradeId);
  }

  /// Calculate GPA for all courses
  Future<AcademicProfile> getAcademicProfile(String playerId) async {
    final grades = await getCourseGrades(playerId);

    if (grades.isEmpty) {
      return AcademicProfile(
        playerId: playerId,
        cumulativeGpa: 0.0,
        weightedGpa: 0.0,
        totalCredits: 0,
        yearSummaries: [],
      );
    }

    // Group by year
    final gradesByYear = <int, List<CourseGrade>>{};
    for (final grade in grades) {
      gradesByYear.putIfAbsent(grade.year, () => []).add(grade);
    }

    // Calculate year summaries
    final yearSummaries = <AcademicYearSummary>[];
    double totalGpaPoints = 0;
    double totalWeightedPoints = 0;
    double totalCredits = 0;

    for (final entry in gradesByYear.entries) {
      final yearGrades = entry.value;
      final year = entry.key;

      double yearGpaPoints = 0;
      double yearWeightedPoints = 0;
      double yearCredits = 0;
      final categoryPoints = <SubjectCategory, List<double>>{};

      for (final grade in yearGrades) {
        final credits = grade.creditHours ?? 1.0;
        yearGpaPoints += grade.grade.gpaValue * credits;
        yearWeightedPoints += grade.gpaPoints;
        yearCredits += credits;

        categoryPoints
            .putIfAbsent(grade.category, () => [])
            .add(grade.grade.gpaValue);
      }

      final yearGpa = yearCredits > 0 ? yearGpaPoints / yearCredits : 0.0;
      final yearWeightedGpa =
          yearCredits > 0 ? yearWeightedPoints / yearCredits : 0.0;

      final categoryAverages = <SubjectCategory, double>{};
      for (final cat in categoryPoints.entries) {
        categoryAverages[cat.key] =
            cat.value.reduce((a, b) => a + b) / cat.value.length;
      }

      yearSummaries.add(AcademicYearSummary(
        year: year,
        gradeLevel: yearGrades.first.gradeLevel,
        gpa: yearGpa,
        weightedGpa: yearWeightedGpa,
        totalCourses: yearGrades.length,
        categoryAverages: categoryAverages,
        courses: yearGrades,
      ));

      totalGpaPoints += yearGpaPoints;
      totalWeightedPoints += yearWeightedPoints;
      totalCredits += yearCredits;
    }

    yearSummaries.sort((a, b) => b.year.compareTo(a.year));

    return AcademicProfile(
      playerId: playerId,
      cumulativeGpa: totalCredits > 0 ? totalGpaPoints / totalCredits : 0.0,
      weightedGpa: totalCredits > 0 ? totalWeightedPoints / totalCredits : 0.0,
      totalCredits: totalCredits.round(),
      yearSummaries: yearSummaries,
    );
  }

  CourseGrade _parseCourseGrade(Map<String, dynamic> json) {
    return CourseGrade(
      id: json['id'] as String,
      playerId: json['player_id'] as String,
      courseName: json['course_name'] as String,
      category: SubjectCategory.values.firstWhere(
        (c) => c.name == json['category'],
        orElse: () => SubjectCategory.other,
      ),
      gradeLevel: GradeLevel.fromValue(json['grade_level'] as int),
      year: json['year'] as int,
      term: AcademicTerm.values.firstWhere(
        (t) => t.name == json['term'],
        orElse: () => AcademicTerm.semester1,
      ),
      grade: LetterGrade.fromLabel(json['grade'] as String),
      percentageScore: (json['percentage_score'] as num?)?.toDouble(),
      creditHours: (json['credit_hours'] as num?)?.toDouble(),
      isApHonors: json['is_ap_honors'] as bool?,
      isWeighted: json['is_weighted'] as bool?,
      teacherName: json['teacher_name'] as String?,
      notes: json['notes'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }
}
