import 'package:freezed_annotation/freezed_annotation.dart';

part 'academic_record.freezed.dart';
part 'academic_record.g.dart';

/// Grade levels
enum GradeLevel {
  grade7('Grade 7', 7),
  grade8('Grade 8', 8),
  grade9('Grade 9', 9),
  grade10('Grade 10', 10),
  grade11('Grade 11', 11),
  grade12('Grade 12', 12);

  final String label;
  final int value;
  const GradeLevel(this.label, this.value);

  static GradeLevel fromValue(int value) {
    return GradeLevel.values.firstWhere(
      (g) => g.value == value,
      orElse: () => GradeLevel.grade7,
    );
  }
}

/// Academic term/semester
enum AcademicTerm {
  semester1('Semester 1', 1),
  semester2('Semester 2', 2),
  term1('Term 1', 1),
  term2('Term 2', 2),
  term3('Term 3', 3),
  term4('Term 4', 4),
  fullYear('Full Year', 0);

  final String label;
  final int value;
  const AcademicTerm(this.label, this.value);
}

/// Subject categories
enum SubjectCategory {
  english('English'),
  mathematics('Mathematics'),
  science('Science'),
  socialStudies('Social Studies'),
  foreignLanguage('Foreign Language'),
  arts('Arts'),
  physicalEducation('Physical Education'),
  elective('Elective'),
  apHonors('AP/Honors'),
  other('Other');

  final String label;
  const SubjectCategory(this.label);
}

/// Grade values for GPA calculation
enum LetterGrade {
  aPlus('A+', 4.0),
  a('A', 4.0),
  aMinus('A-', 3.7),
  bPlus('B+', 3.3),
  b('B', 3.0),
  bMinus('B-', 2.7),
  cPlus('C+', 2.3),
  c('C', 2.0),
  cMinus('C-', 1.7),
  dPlus('D+', 1.3),
  d('D', 1.0),
  dMinus('D-', 0.7),
  f('F', 0.0);

  final String label;
  final double gpaValue;
  const LetterGrade(this.label, this.gpaValue);

  static LetterGrade fromLabel(String label) {
    return LetterGrade.values.firstWhere(
      (g) => g.label == label,
      orElse: () => LetterGrade.c,
    );
  }
}

/// Individual course/subject grade
@freezed
class CourseGrade with _$CourseGrade {
  const CourseGrade._();

  const factory CourseGrade({
    required String id,
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
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _CourseGrade;

  factory CourseGrade.fromJson(Map<String, dynamic> json) =>
      _$CourseGradeFromJson(json);

  /// GPA points for this course
  double get gpaPoints {
    double base = grade.gpaValue;
    if (isWeighted == true && isApHonors == true) {
      base += 1.0; // Weighted GPA bonus
    }
    return base * (creditHours ?? 1.0);
  }
}

/// Academic year summary
@freezed
class AcademicYearSummary with _$AcademicYearSummary {
  const AcademicYearSummary._();

  const factory AcademicYearSummary({
    required int year,
    required GradeLevel gradeLevel,
    required double gpa,
    required double weightedGpa,
    required int totalCourses,
    required Map<SubjectCategory, double> categoryAverages,
    required List<CourseGrade> courses,
  }) = _AcademicYearSummary;

  /// GPA formatted to 2 decimal places
  String get formattedGpa => gpa.toStringAsFixed(2);
  String get formattedWeightedGpa => weightedGpa.toStringAsFixed(2);
}

/// Overall academic profile
@freezed
class AcademicProfile with _$AcademicProfile {
  const AcademicProfile._();

  const factory AcademicProfile({
    required String playerId,
    required double cumulativeGpa,
    required double weightedGpa,
    required int totalCredits,
    required List<AcademicYearSummary> yearSummaries,
    String? schoolName,
    String? satScore,
    String? actScore,
    String? classRank,
    String? classSize,
    String? notes,
  }) = _AcademicProfile;

  /// Academic eligibility check (good academic standing requires 2.3 GPA minimum)
  bool get meetsAcademicMinimum => cumulativeGpa >= 2.3;

  /// Formatted GPA
  String get formattedCumulativeGpa => cumulativeGpa.toStringAsFixed(2);
  String get formattedWeightedGpa => weightedGpa.toStringAsFixed(2);

  /// Class rank as percentage
  String? get classRankPercentile {
    if (classRank != null && classSize != null) {
      final rank = int.tryParse(classRank!);
      final size = int.tryParse(classSize!);
      if (rank != null && size != null && size > 0) {
        final percentile = ((size - rank) / size * 100).round();
        return 'Top ${100 - percentile}%';
      }
    }
    return null;
  }
}

/// Academic Standing Requirements
class AcademicStanding {
  AcademicStanding._();

  // Recommended core courses
  static const int requiredCoreCourses = 16;

  // Breakdown
  static const int englishCourses = 4;
  static const int mathCourses = 3; // Algebra I or higher
  static const int scienceCourses = 2; // Natural/physical science
  static const int additionalEnglishMathScience = 1;
  static const int socialScienceCourses = 2;
  static const int additionalCoreCourses = 4;

  // Minimum GPA for good standing
  static const double minimumCoreGpa = 2.3;
}
