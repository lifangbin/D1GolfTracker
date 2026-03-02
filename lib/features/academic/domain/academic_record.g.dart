// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'academic_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CourseGradeImpl _$$CourseGradeImplFromJson(Map<String, dynamic> json) =>
    _$CourseGradeImpl(
      id: json['id'] as String,
      playerId: json['playerId'] as String,
      courseName: json['courseName'] as String,
      category: $enumDecode(_$SubjectCategoryEnumMap, json['category']),
      gradeLevel: $enumDecode(_$GradeLevelEnumMap, json['gradeLevel']),
      year: (json['year'] as num).toInt(),
      term: $enumDecode(_$AcademicTermEnumMap, json['term']),
      grade: $enumDecode(_$LetterGradeEnumMap, json['grade']),
      percentageScore: (json['percentageScore'] as num?)?.toDouble(),
      creditHours: (json['creditHours'] as num?)?.toDouble(),
      isApHonors: json['isApHonors'] as bool?,
      isWeighted: json['isWeighted'] as bool?,
      teacherName: json['teacherName'] as String?,
      notes: json['notes'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$CourseGradeImplToJson(_$CourseGradeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'playerId': instance.playerId,
      'courseName': instance.courseName,
      'category': _$SubjectCategoryEnumMap[instance.category]!,
      'gradeLevel': _$GradeLevelEnumMap[instance.gradeLevel]!,
      'year': instance.year,
      'term': _$AcademicTermEnumMap[instance.term]!,
      'grade': _$LetterGradeEnumMap[instance.grade]!,
      'percentageScore': instance.percentageScore,
      'creditHours': instance.creditHours,
      'isApHonors': instance.isApHonors,
      'isWeighted': instance.isWeighted,
      'teacherName': instance.teacherName,
      'notes': instance.notes,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$SubjectCategoryEnumMap = {
  SubjectCategory.english: 'english',
  SubjectCategory.mathematics: 'mathematics',
  SubjectCategory.science: 'science',
  SubjectCategory.socialStudies: 'socialStudies',
  SubjectCategory.foreignLanguage: 'foreignLanguage',
  SubjectCategory.arts: 'arts',
  SubjectCategory.physicalEducation: 'physicalEducation',
  SubjectCategory.elective: 'elective',
  SubjectCategory.apHonors: 'apHonors',
  SubjectCategory.other: 'other',
};

const _$GradeLevelEnumMap = {
  GradeLevel.grade7: 'grade7',
  GradeLevel.grade8: 'grade8',
  GradeLevel.grade9: 'grade9',
  GradeLevel.grade10: 'grade10',
  GradeLevel.grade11: 'grade11',
  GradeLevel.grade12: 'grade12',
};

const _$AcademicTermEnumMap = {
  AcademicTerm.semester1: 'semester1',
  AcademicTerm.semester2: 'semester2',
  AcademicTerm.term1: 'term1',
  AcademicTerm.term2: 'term2',
  AcademicTerm.term3: 'term3',
  AcademicTerm.term4: 'term4',
  AcademicTerm.fullYear: 'fullYear',
};

const _$LetterGradeEnumMap = {
  LetterGrade.aPlus: 'aPlus',
  LetterGrade.a: 'a',
  LetterGrade.aMinus: 'aMinus',
  LetterGrade.bPlus: 'bPlus',
  LetterGrade.b: 'b',
  LetterGrade.bMinus: 'bMinus',
  LetterGrade.cPlus: 'cPlus',
  LetterGrade.c: 'c',
  LetterGrade.cMinus: 'cMinus',
  LetterGrade.dPlus: 'dPlus',
  LetterGrade.d: 'd',
  LetterGrade.dMinus: 'dMinus',
  LetterGrade.f: 'f',
};
