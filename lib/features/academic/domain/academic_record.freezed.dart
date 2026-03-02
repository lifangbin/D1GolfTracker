// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'academic_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CourseGrade _$CourseGradeFromJson(Map<String, dynamic> json) {
  return _CourseGrade.fromJson(json);
}

/// @nodoc
mixin _$CourseGrade {
  String get id => throw _privateConstructorUsedError;
  String get playerId => throw _privateConstructorUsedError;
  String get courseName => throw _privateConstructorUsedError;
  SubjectCategory get category => throw _privateConstructorUsedError;
  GradeLevel get gradeLevel => throw _privateConstructorUsedError;
  int get year => throw _privateConstructorUsedError;
  AcademicTerm get term => throw _privateConstructorUsedError;
  LetterGrade get grade => throw _privateConstructorUsedError;
  double? get percentageScore => throw _privateConstructorUsedError;
  double? get creditHours => throw _privateConstructorUsedError;
  bool? get isApHonors => throw _privateConstructorUsedError;
  bool? get isWeighted => throw _privateConstructorUsedError;
  String? get teacherName => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this CourseGrade to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CourseGrade
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CourseGradeCopyWith<CourseGrade> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CourseGradeCopyWith<$Res> {
  factory $CourseGradeCopyWith(
    CourseGrade value,
    $Res Function(CourseGrade) then,
  ) = _$CourseGradeCopyWithImpl<$Res, CourseGrade>;
  @useResult
  $Res call({
    String id,
    String playerId,
    String courseName,
    SubjectCategory category,
    GradeLevel gradeLevel,
    int year,
    AcademicTerm term,
    LetterGrade grade,
    double? percentageScore,
    double? creditHours,
    bool? isApHonors,
    bool? isWeighted,
    String? teacherName,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$CourseGradeCopyWithImpl<$Res, $Val extends CourseGrade>
    implements $CourseGradeCopyWith<$Res> {
  _$CourseGradeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CourseGrade
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? playerId = null,
    Object? courseName = null,
    Object? category = null,
    Object? gradeLevel = null,
    Object? year = null,
    Object? term = null,
    Object? grade = null,
    Object? percentageScore = freezed,
    Object? creditHours = freezed,
    Object? isApHonors = freezed,
    Object? isWeighted = freezed,
    Object? teacherName = freezed,
    Object? notes = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            playerId: null == playerId
                ? _value.playerId
                : playerId // ignore: cast_nullable_to_non_nullable
                      as String,
            courseName: null == courseName
                ? _value.courseName
                : courseName // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as SubjectCategory,
            gradeLevel: null == gradeLevel
                ? _value.gradeLevel
                : gradeLevel // ignore: cast_nullable_to_non_nullable
                      as GradeLevel,
            year: null == year
                ? _value.year
                : year // ignore: cast_nullable_to_non_nullable
                      as int,
            term: null == term
                ? _value.term
                : term // ignore: cast_nullable_to_non_nullable
                      as AcademicTerm,
            grade: null == grade
                ? _value.grade
                : grade // ignore: cast_nullable_to_non_nullable
                      as LetterGrade,
            percentageScore: freezed == percentageScore
                ? _value.percentageScore
                : percentageScore // ignore: cast_nullable_to_non_nullable
                      as double?,
            creditHours: freezed == creditHours
                ? _value.creditHours
                : creditHours // ignore: cast_nullable_to_non_nullable
                      as double?,
            isApHonors: freezed == isApHonors
                ? _value.isApHonors
                : isApHonors // ignore: cast_nullable_to_non_nullable
                      as bool?,
            isWeighted: freezed == isWeighted
                ? _value.isWeighted
                : isWeighted // ignore: cast_nullable_to_non_nullable
                      as bool?,
            teacherName: freezed == teacherName
                ? _value.teacherName
                : teacherName // ignore: cast_nullable_to_non_nullable
                      as String?,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CourseGradeImplCopyWith<$Res>
    implements $CourseGradeCopyWith<$Res> {
  factory _$$CourseGradeImplCopyWith(
    _$CourseGradeImpl value,
    $Res Function(_$CourseGradeImpl) then,
  ) = __$$CourseGradeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String playerId,
    String courseName,
    SubjectCategory category,
    GradeLevel gradeLevel,
    int year,
    AcademicTerm term,
    LetterGrade grade,
    double? percentageScore,
    double? creditHours,
    bool? isApHonors,
    bool? isWeighted,
    String? teacherName,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$CourseGradeImplCopyWithImpl<$Res>
    extends _$CourseGradeCopyWithImpl<$Res, _$CourseGradeImpl>
    implements _$$CourseGradeImplCopyWith<$Res> {
  __$$CourseGradeImplCopyWithImpl(
    _$CourseGradeImpl _value,
    $Res Function(_$CourseGradeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CourseGrade
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? playerId = null,
    Object? courseName = null,
    Object? category = null,
    Object? gradeLevel = null,
    Object? year = null,
    Object? term = null,
    Object? grade = null,
    Object? percentageScore = freezed,
    Object? creditHours = freezed,
    Object? isApHonors = freezed,
    Object? isWeighted = freezed,
    Object? teacherName = freezed,
    Object? notes = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$CourseGradeImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        playerId: null == playerId
            ? _value.playerId
            : playerId // ignore: cast_nullable_to_non_nullable
                  as String,
        courseName: null == courseName
            ? _value.courseName
            : courseName // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as SubjectCategory,
        gradeLevel: null == gradeLevel
            ? _value.gradeLevel
            : gradeLevel // ignore: cast_nullable_to_non_nullable
                  as GradeLevel,
        year: null == year
            ? _value.year
            : year // ignore: cast_nullable_to_non_nullable
                  as int,
        term: null == term
            ? _value.term
            : term // ignore: cast_nullable_to_non_nullable
                  as AcademicTerm,
        grade: null == grade
            ? _value.grade
            : grade // ignore: cast_nullable_to_non_nullable
                  as LetterGrade,
        percentageScore: freezed == percentageScore
            ? _value.percentageScore
            : percentageScore // ignore: cast_nullable_to_non_nullable
                  as double?,
        creditHours: freezed == creditHours
            ? _value.creditHours
            : creditHours // ignore: cast_nullable_to_non_nullable
                  as double?,
        isApHonors: freezed == isApHonors
            ? _value.isApHonors
            : isApHonors // ignore: cast_nullable_to_non_nullable
                  as bool?,
        isWeighted: freezed == isWeighted
            ? _value.isWeighted
            : isWeighted // ignore: cast_nullable_to_non_nullable
                  as bool?,
        teacherName: freezed == teacherName
            ? _value.teacherName
            : teacherName // ignore: cast_nullable_to_non_nullable
                  as String?,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CourseGradeImpl extends _CourseGrade {
  const _$CourseGradeImpl({
    required this.id,
    required this.playerId,
    required this.courseName,
    required this.category,
    required this.gradeLevel,
    required this.year,
    required this.term,
    required this.grade,
    this.percentageScore,
    this.creditHours,
    this.isApHonors,
    this.isWeighted,
    this.teacherName,
    this.notes,
    this.createdAt,
    this.updatedAt,
  }) : super._();

  factory _$CourseGradeImpl.fromJson(Map<String, dynamic> json) =>
      _$$CourseGradeImplFromJson(json);

  @override
  final String id;
  @override
  final String playerId;
  @override
  final String courseName;
  @override
  final SubjectCategory category;
  @override
  final GradeLevel gradeLevel;
  @override
  final int year;
  @override
  final AcademicTerm term;
  @override
  final LetterGrade grade;
  @override
  final double? percentageScore;
  @override
  final double? creditHours;
  @override
  final bool? isApHonors;
  @override
  final bool? isWeighted;
  @override
  final String? teacherName;
  @override
  final String? notes;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'CourseGrade(id: $id, playerId: $playerId, courseName: $courseName, category: $category, gradeLevel: $gradeLevel, year: $year, term: $term, grade: $grade, percentageScore: $percentageScore, creditHours: $creditHours, isApHonors: $isApHonors, isWeighted: $isWeighted, teacherName: $teacherName, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CourseGradeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId) &&
            (identical(other.courseName, courseName) ||
                other.courseName == courseName) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.gradeLevel, gradeLevel) ||
                other.gradeLevel == gradeLevel) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.term, term) || other.term == term) &&
            (identical(other.grade, grade) || other.grade == grade) &&
            (identical(other.percentageScore, percentageScore) ||
                other.percentageScore == percentageScore) &&
            (identical(other.creditHours, creditHours) ||
                other.creditHours == creditHours) &&
            (identical(other.isApHonors, isApHonors) ||
                other.isApHonors == isApHonors) &&
            (identical(other.isWeighted, isWeighted) ||
                other.isWeighted == isWeighted) &&
            (identical(other.teacherName, teacherName) ||
                other.teacherName == teacherName) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    playerId,
    courseName,
    category,
    gradeLevel,
    year,
    term,
    grade,
    percentageScore,
    creditHours,
    isApHonors,
    isWeighted,
    teacherName,
    notes,
    createdAt,
    updatedAt,
  );

  /// Create a copy of CourseGrade
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CourseGradeImplCopyWith<_$CourseGradeImpl> get copyWith =>
      __$$CourseGradeImplCopyWithImpl<_$CourseGradeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CourseGradeImplToJson(this);
  }
}

abstract class _CourseGrade extends CourseGrade {
  const factory _CourseGrade({
    required final String id,
    required final String playerId,
    required final String courseName,
    required final SubjectCategory category,
    required final GradeLevel gradeLevel,
    required final int year,
    required final AcademicTerm term,
    required final LetterGrade grade,
    final double? percentageScore,
    final double? creditHours,
    final bool? isApHonors,
    final bool? isWeighted,
    final String? teacherName,
    final String? notes,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _$CourseGradeImpl;
  const _CourseGrade._() : super._();

  factory _CourseGrade.fromJson(Map<String, dynamic> json) =
      _$CourseGradeImpl.fromJson;

  @override
  String get id;
  @override
  String get playerId;
  @override
  String get courseName;
  @override
  SubjectCategory get category;
  @override
  GradeLevel get gradeLevel;
  @override
  int get year;
  @override
  AcademicTerm get term;
  @override
  LetterGrade get grade;
  @override
  double? get percentageScore;
  @override
  double? get creditHours;
  @override
  bool? get isApHonors;
  @override
  bool? get isWeighted;
  @override
  String? get teacherName;
  @override
  String? get notes;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of CourseGrade
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CourseGradeImplCopyWith<_$CourseGradeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AcademicYearSummary {
  int get year => throw _privateConstructorUsedError;
  GradeLevel get gradeLevel => throw _privateConstructorUsedError;
  double get gpa => throw _privateConstructorUsedError;
  double get weightedGpa => throw _privateConstructorUsedError;
  int get totalCourses => throw _privateConstructorUsedError;
  Map<SubjectCategory, double> get categoryAverages =>
      throw _privateConstructorUsedError;
  List<CourseGrade> get courses => throw _privateConstructorUsedError;

  /// Create a copy of AcademicYearSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AcademicYearSummaryCopyWith<AcademicYearSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AcademicYearSummaryCopyWith<$Res> {
  factory $AcademicYearSummaryCopyWith(
    AcademicYearSummary value,
    $Res Function(AcademicYearSummary) then,
  ) = _$AcademicYearSummaryCopyWithImpl<$Res, AcademicYearSummary>;
  @useResult
  $Res call({
    int year,
    GradeLevel gradeLevel,
    double gpa,
    double weightedGpa,
    int totalCourses,
    Map<SubjectCategory, double> categoryAverages,
    List<CourseGrade> courses,
  });
}

/// @nodoc
class _$AcademicYearSummaryCopyWithImpl<$Res, $Val extends AcademicYearSummary>
    implements $AcademicYearSummaryCopyWith<$Res> {
  _$AcademicYearSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AcademicYearSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? gradeLevel = null,
    Object? gpa = null,
    Object? weightedGpa = null,
    Object? totalCourses = null,
    Object? categoryAverages = null,
    Object? courses = null,
  }) {
    return _then(
      _value.copyWith(
            year: null == year
                ? _value.year
                : year // ignore: cast_nullable_to_non_nullable
                      as int,
            gradeLevel: null == gradeLevel
                ? _value.gradeLevel
                : gradeLevel // ignore: cast_nullable_to_non_nullable
                      as GradeLevel,
            gpa: null == gpa
                ? _value.gpa
                : gpa // ignore: cast_nullable_to_non_nullable
                      as double,
            weightedGpa: null == weightedGpa
                ? _value.weightedGpa
                : weightedGpa // ignore: cast_nullable_to_non_nullable
                      as double,
            totalCourses: null == totalCourses
                ? _value.totalCourses
                : totalCourses // ignore: cast_nullable_to_non_nullable
                      as int,
            categoryAverages: null == categoryAverages
                ? _value.categoryAverages
                : categoryAverages // ignore: cast_nullable_to_non_nullable
                      as Map<SubjectCategory, double>,
            courses: null == courses
                ? _value.courses
                : courses // ignore: cast_nullable_to_non_nullable
                      as List<CourseGrade>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AcademicYearSummaryImplCopyWith<$Res>
    implements $AcademicYearSummaryCopyWith<$Res> {
  factory _$$AcademicYearSummaryImplCopyWith(
    _$AcademicYearSummaryImpl value,
    $Res Function(_$AcademicYearSummaryImpl) then,
  ) = __$$AcademicYearSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int year,
    GradeLevel gradeLevel,
    double gpa,
    double weightedGpa,
    int totalCourses,
    Map<SubjectCategory, double> categoryAverages,
    List<CourseGrade> courses,
  });
}

/// @nodoc
class __$$AcademicYearSummaryImplCopyWithImpl<$Res>
    extends _$AcademicYearSummaryCopyWithImpl<$Res, _$AcademicYearSummaryImpl>
    implements _$$AcademicYearSummaryImplCopyWith<$Res> {
  __$$AcademicYearSummaryImplCopyWithImpl(
    _$AcademicYearSummaryImpl _value,
    $Res Function(_$AcademicYearSummaryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AcademicYearSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? gradeLevel = null,
    Object? gpa = null,
    Object? weightedGpa = null,
    Object? totalCourses = null,
    Object? categoryAverages = null,
    Object? courses = null,
  }) {
    return _then(
      _$AcademicYearSummaryImpl(
        year: null == year
            ? _value.year
            : year // ignore: cast_nullable_to_non_nullable
                  as int,
        gradeLevel: null == gradeLevel
            ? _value.gradeLevel
            : gradeLevel // ignore: cast_nullable_to_non_nullable
                  as GradeLevel,
        gpa: null == gpa
            ? _value.gpa
            : gpa // ignore: cast_nullable_to_non_nullable
                  as double,
        weightedGpa: null == weightedGpa
            ? _value.weightedGpa
            : weightedGpa // ignore: cast_nullable_to_non_nullable
                  as double,
        totalCourses: null == totalCourses
            ? _value.totalCourses
            : totalCourses // ignore: cast_nullable_to_non_nullable
                  as int,
        categoryAverages: null == categoryAverages
            ? _value._categoryAverages
            : categoryAverages // ignore: cast_nullable_to_non_nullable
                  as Map<SubjectCategory, double>,
        courses: null == courses
            ? _value._courses
            : courses // ignore: cast_nullable_to_non_nullable
                  as List<CourseGrade>,
      ),
    );
  }
}

/// @nodoc

class _$AcademicYearSummaryImpl extends _AcademicYearSummary {
  const _$AcademicYearSummaryImpl({
    required this.year,
    required this.gradeLevel,
    required this.gpa,
    required this.weightedGpa,
    required this.totalCourses,
    required final Map<SubjectCategory, double> categoryAverages,
    required final List<CourseGrade> courses,
  }) : _categoryAverages = categoryAverages,
       _courses = courses,
       super._();

  @override
  final int year;
  @override
  final GradeLevel gradeLevel;
  @override
  final double gpa;
  @override
  final double weightedGpa;
  @override
  final int totalCourses;
  final Map<SubjectCategory, double> _categoryAverages;
  @override
  Map<SubjectCategory, double> get categoryAverages {
    if (_categoryAverages is EqualUnmodifiableMapView) return _categoryAverages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_categoryAverages);
  }

  final List<CourseGrade> _courses;
  @override
  List<CourseGrade> get courses {
    if (_courses is EqualUnmodifiableListView) return _courses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_courses);
  }

  @override
  String toString() {
    return 'AcademicYearSummary(year: $year, gradeLevel: $gradeLevel, gpa: $gpa, weightedGpa: $weightedGpa, totalCourses: $totalCourses, categoryAverages: $categoryAverages, courses: $courses)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AcademicYearSummaryImpl &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.gradeLevel, gradeLevel) ||
                other.gradeLevel == gradeLevel) &&
            (identical(other.gpa, gpa) || other.gpa == gpa) &&
            (identical(other.weightedGpa, weightedGpa) ||
                other.weightedGpa == weightedGpa) &&
            (identical(other.totalCourses, totalCourses) ||
                other.totalCourses == totalCourses) &&
            const DeepCollectionEquality().equals(
              other._categoryAverages,
              _categoryAverages,
            ) &&
            const DeepCollectionEquality().equals(other._courses, _courses));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    year,
    gradeLevel,
    gpa,
    weightedGpa,
    totalCourses,
    const DeepCollectionEquality().hash(_categoryAverages),
    const DeepCollectionEquality().hash(_courses),
  );

  /// Create a copy of AcademicYearSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AcademicYearSummaryImplCopyWith<_$AcademicYearSummaryImpl> get copyWith =>
      __$$AcademicYearSummaryImplCopyWithImpl<_$AcademicYearSummaryImpl>(
        this,
        _$identity,
      );
}

abstract class _AcademicYearSummary extends AcademicYearSummary {
  const factory _AcademicYearSummary({
    required final int year,
    required final GradeLevel gradeLevel,
    required final double gpa,
    required final double weightedGpa,
    required final int totalCourses,
    required final Map<SubjectCategory, double> categoryAverages,
    required final List<CourseGrade> courses,
  }) = _$AcademicYearSummaryImpl;
  const _AcademicYearSummary._() : super._();

  @override
  int get year;
  @override
  GradeLevel get gradeLevel;
  @override
  double get gpa;
  @override
  double get weightedGpa;
  @override
  int get totalCourses;
  @override
  Map<SubjectCategory, double> get categoryAverages;
  @override
  List<CourseGrade> get courses;

  /// Create a copy of AcademicYearSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AcademicYearSummaryImplCopyWith<_$AcademicYearSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AcademicProfile {
  String get playerId => throw _privateConstructorUsedError;
  double get cumulativeGpa => throw _privateConstructorUsedError;
  double get weightedGpa => throw _privateConstructorUsedError;
  int get totalCredits => throw _privateConstructorUsedError;
  List<AcademicYearSummary> get yearSummaries =>
      throw _privateConstructorUsedError;
  String? get schoolName => throw _privateConstructorUsedError;
  String? get satScore => throw _privateConstructorUsedError;
  String? get actScore => throw _privateConstructorUsedError;
  String? get classRank => throw _privateConstructorUsedError;
  String? get classSize => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Create a copy of AcademicProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AcademicProfileCopyWith<AcademicProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AcademicProfileCopyWith<$Res> {
  factory $AcademicProfileCopyWith(
    AcademicProfile value,
    $Res Function(AcademicProfile) then,
  ) = _$AcademicProfileCopyWithImpl<$Res, AcademicProfile>;
  @useResult
  $Res call({
    String playerId,
    double cumulativeGpa,
    double weightedGpa,
    int totalCredits,
    List<AcademicYearSummary> yearSummaries,
    String? schoolName,
    String? satScore,
    String? actScore,
    String? classRank,
    String? classSize,
    String? notes,
  });
}

/// @nodoc
class _$AcademicProfileCopyWithImpl<$Res, $Val extends AcademicProfile>
    implements $AcademicProfileCopyWith<$Res> {
  _$AcademicProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AcademicProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerId = null,
    Object? cumulativeGpa = null,
    Object? weightedGpa = null,
    Object? totalCredits = null,
    Object? yearSummaries = null,
    Object? schoolName = freezed,
    Object? satScore = freezed,
    Object? actScore = freezed,
    Object? classRank = freezed,
    Object? classSize = freezed,
    Object? notes = freezed,
  }) {
    return _then(
      _value.copyWith(
            playerId: null == playerId
                ? _value.playerId
                : playerId // ignore: cast_nullable_to_non_nullable
                      as String,
            cumulativeGpa: null == cumulativeGpa
                ? _value.cumulativeGpa
                : cumulativeGpa // ignore: cast_nullable_to_non_nullable
                      as double,
            weightedGpa: null == weightedGpa
                ? _value.weightedGpa
                : weightedGpa // ignore: cast_nullable_to_non_nullable
                      as double,
            totalCredits: null == totalCredits
                ? _value.totalCredits
                : totalCredits // ignore: cast_nullable_to_non_nullable
                      as int,
            yearSummaries: null == yearSummaries
                ? _value.yearSummaries
                : yearSummaries // ignore: cast_nullable_to_non_nullable
                      as List<AcademicYearSummary>,
            schoolName: freezed == schoolName
                ? _value.schoolName
                : schoolName // ignore: cast_nullable_to_non_nullable
                      as String?,
            satScore: freezed == satScore
                ? _value.satScore
                : satScore // ignore: cast_nullable_to_non_nullable
                      as String?,
            actScore: freezed == actScore
                ? _value.actScore
                : actScore // ignore: cast_nullable_to_non_nullable
                      as String?,
            classRank: freezed == classRank
                ? _value.classRank
                : classRank // ignore: cast_nullable_to_non_nullable
                      as String?,
            classSize: freezed == classSize
                ? _value.classSize
                : classSize // ignore: cast_nullable_to_non_nullable
                      as String?,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AcademicProfileImplCopyWith<$Res>
    implements $AcademicProfileCopyWith<$Res> {
  factory _$$AcademicProfileImplCopyWith(
    _$AcademicProfileImpl value,
    $Res Function(_$AcademicProfileImpl) then,
  ) = __$$AcademicProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String playerId,
    double cumulativeGpa,
    double weightedGpa,
    int totalCredits,
    List<AcademicYearSummary> yearSummaries,
    String? schoolName,
    String? satScore,
    String? actScore,
    String? classRank,
    String? classSize,
    String? notes,
  });
}

/// @nodoc
class __$$AcademicProfileImplCopyWithImpl<$Res>
    extends _$AcademicProfileCopyWithImpl<$Res, _$AcademicProfileImpl>
    implements _$$AcademicProfileImplCopyWith<$Res> {
  __$$AcademicProfileImplCopyWithImpl(
    _$AcademicProfileImpl _value,
    $Res Function(_$AcademicProfileImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AcademicProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerId = null,
    Object? cumulativeGpa = null,
    Object? weightedGpa = null,
    Object? totalCredits = null,
    Object? yearSummaries = null,
    Object? schoolName = freezed,
    Object? satScore = freezed,
    Object? actScore = freezed,
    Object? classRank = freezed,
    Object? classSize = freezed,
    Object? notes = freezed,
  }) {
    return _then(
      _$AcademicProfileImpl(
        playerId: null == playerId
            ? _value.playerId
            : playerId // ignore: cast_nullable_to_non_nullable
                  as String,
        cumulativeGpa: null == cumulativeGpa
            ? _value.cumulativeGpa
            : cumulativeGpa // ignore: cast_nullable_to_non_nullable
                  as double,
        weightedGpa: null == weightedGpa
            ? _value.weightedGpa
            : weightedGpa // ignore: cast_nullable_to_non_nullable
                  as double,
        totalCredits: null == totalCredits
            ? _value.totalCredits
            : totalCredits // ignore: cast_nullable_to_non_nullable
                  as int,
        yearSummaries: null == yearSummaries
            ? _value._yearSummaries
            : yearSummaries // ignore: cast_nullable_to_non_nullable
                  as List<AcademicYearSummary>,
        schoolName: freezed == schoolName
            ? _value.schoolName
            : schoolName // ignore: cast_nullable_to_non_nullable
                  as String?,
        satScore: freezed == satScore
            ? _value.satScore
            : satScore // ignore: cast_nullable_to_non_nullable
                  as String?,
        actScore: freezed == actScore
            ? _value.actScore
            : actScore // ignore: cast_nullable_to_non_nullable
                  as String?,
        classRank: freezed == classRank
            ? _value.classRank
            : classRank // ignore: cast_nullable_to_non_nullable
                  as String?,
        classSize: freezed == classSize
            ? _value.classSize
            : classSize // ignore: cast_nullable_to_non_nullable
                  as String?,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$AcademicProfileImpl extends _AcademicProfile {
  const _$AcademicProfileImpl({
    required this.playerId,
    required this.cumulativeGpa,
    required this.weightedGpa,
    required this.totalCredits,
    required final List<AcademicYearSummary> yearSummaries,
    this.schoolName,
    this.satScore,
    this.actScore,
    this.classRank,
    this.classSize,
    this.notes,
  }) : _yearSummaries = yearSummaries,
       super._();

  @override
  final String playerId;
  @override
  final double cumulativeGpa;
  @override
  final double weightedGpa;
  @override
  final int totalCredits;
  final List<AcademicYearSummary> _yearSummaries;
  @override
  List<AcademicYearSummary> get yearSummaries {
    if (_yearSummaries is EqualUnmodifiableListView) return _yearSummaries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_yearSummaries);
  }

  @override
  final String? schoolName;
  @override
  final String? satScore;
  @override
  final String? actScore;
  @override
  final String? classRank;
  @override
  final String? classSize;
  @override
  final String? notes;

  @override
  String toString() {
    return 'AcademicProfile(playerId: $playerId, cumulativeGpa: $cumulativeGpa, weightedGpa: $weightedGpa, totalCredits: $totalCredits, yearSummaries: $yearSummaries, schoolName: $schoolName, satScore: $satScore, actScore: $actScore, classRank: $classRank, classSize: $classSize, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AcademicProfileImpl &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId) &&
            (identical(other.cumulativeGpa, cumulativeGpa) ||
                other.cumulativeGpa == cumulativeGpa) &&
            (identical(other.weightedGpa, weightedGpa) ||
                other.weightedGpa == weightedGpa) &&
            (identical(other.totalCredits, totalCredits) ||
                other.totalCredits == totalCredits) &&
            const DeepCollectionEquality().equals(
              other._yearSummaries,
              _yearSummaries,
            ) &&
            (identical(other.schoolName, schoolName) ||
                other.schoolName == schoolName) &&
            (identical(other.satScore, satScore) ||
                other.satScore == satScore) &&
            (identical(other.actScore, actScore) ||
                other.actScore == actScore) &&
            (identical(other.classRank, classRank) ||
                other.classRank == classRank) &&
            (identical(other.classSize, classSize) ||
                other.classSize == classSize) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    playerId,
    cumulativeGpa,
    weightedGpa,
    totalCredits,
    const DeepCollectionEquality().hash(_yearSummaries),
    schoolName,
    satScore,
    actScore,
    classRank,
    classSize,
    notes,
  );

  /// Create a copy of AcademicProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AcademicProfileImplCopyWith<_$AcademicProfileImpl> get copyWith =>
      __$$AcademicProfileImplCopyWithImpl<_$AcademicProfileImpl>(
        this,
        _$identity,
      );
}

abstract class _AcademicProfile extends AcademicProfile {
  const factory _AcademicProfile({
    required final String playerId,
    required final double cumulativeGpa,
    required final double weightedGpa,
    required final int totalCredits,
    required final List<AcademicYearSummary> yearSummaries,
    final String? schoolName,
    final String? satScore,
    final String? actScore,
    final String? classRank,
    final String? classSize,
    final String? notes,
  }) = _$AcademicProfileImpl;
  const _AcademicProfile._() : super._();

  @override
  String get playerId;
  @override
  double get cumulativeGpa;
  @override
  double get weightedGpa;
  @override
  int get totalCredits;
  @override
  List<AcademicYearSummary> get yearSummaries;
  @override
  String? get schoolName;
  @override
  String? get satScore;
  @override
  String? get actScore;
  @override
  String? get classRank;
  @override
  String? get classSize;
  @override
  String? get notes;

  /// Create a copy of AcademicProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AcademicProfileImplCopyWith<_$AcademicProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
