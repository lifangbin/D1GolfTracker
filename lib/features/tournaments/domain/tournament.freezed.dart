// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tournament.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Tournament _$TournamentFromJson(Map<String, dynamic> json) {
  return _Tournament.fromJson(json);
}

/// @nodoc
mixin _$Tournament {
  String get id => throw _privateConstructorUsedError;
  String get playerId => throw _privateConstructorUsedError; // Basic Info
  String get name => throw _privateConstructorUsedError;
  String? get tournamentType =>
      throw _privateConstructorUsedError; // local, regional, state, national, international
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError; // Location
  String get courseName => throw _privateConstructorUsedError;
  String? get courseCity => throw _privateConstructorUsedError;
  String? get courseState => throw _privateConstructorUsedError;
  String get courseCountry => throw _privateConstructorUsedError;
  int? get coursePar => throw _privateConstructorUsedError;
  double? get courseSlope => throw _privateConstructorUsedError;
  double? get courseRating => throw _privateConstructorUsedError; // Results
  int? get totalScore => throw _privateConstructorUsedError;
  int? get position => throw _privateConstructorUsedError;
  int? get fieldSize => throw _privateConstructorUsedError;
  int? get scoreToPar => throw _privateConstructorUsedError; // Notes
  String? get notes => throw _privateConstructorUsedError;
  String? get weatherConditions =>
      throw _privateConstructorUsedError; // Timestamps
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Tournament to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Tournament
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TournamentCopyWith<Tournament> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TournamentCopyWith<$Res> {
  factory $TournamentCopyWith(
    Tournament value,
    $Res Function(Tournament) then,
  ) = _$TournamentCopyWithImpl<$Res, Tournament>;
  @useResult
  $Res call({
    String id,
    String playerId,
    String name,
    String? tournamentType,
    DateTime startDate,
    DateTime? endDate,
    String courseName,
    String? courseCity,
    String? courseState,
    String courseCountry,
    int? coursePar,
    double? courseSlope,
    double? courseRating,
    int? totalScore,
    int? position,
    int? fieldSize,
    int? scoreToPar,
    String? notes,
    String? weatherConditions,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$TournamentCopyWithImpl<$Res, $Val extends Tournament>
    implements $TournamentCopyWith<$Res> {
  _$TournamentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Tournament
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? playerId = null,
    Object? name = null,
    Object? tournamentType = freezed,
    Object? startDate = null,
    Object? endDate = freezed,
    Object? courseName = null,
    Object? courseCity = freezed,
    Object? courseState = freezed,
    Object? courseCountry = null,
    Object? coursePar = freezed,
    Object? courseSlope = freezed,
    Object? courseRating = freezed,
    Object? totalScore = freezed,
    Object? position = freezed,
    Object? fieldSize = freezed,
    Object? scoreToPar = freezed,
    Object? notes = freezed,
    Object? weatherConditions = freezed,
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
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            tournamentType: freezed == tournamentType
                ? _value.tournamentType
                : tournamentType // ignore: cast_nullable_to_non_nullable
                      as String?,
            startDate: null == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            endDate: freezed == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            courseName: null == courseName
                ? _value.courseName
                : courseName // ignore: cast_nullable_to_non_nullable
                      as String,
            courseCity: freezed == courseCity
                ? _value.courseCity
                : courseCity // ignore: cast_nullable_to_non_nullable
                      as String?,
            courseState: freezed == courseState
                ? _value.courseState
                : courseState // ignore: cast_nullable_to_non_nullable
                      as String?,
            courseCountry: null == courseCountry
                ? _value.courseCountry
                : courseCountry // ignore: cast_nullable_to_non_nullable
                      as String,
            coursePar: freezed == coursePar
                ? _value.coursePar
                : coursePar // ignore: cast_nullable_to_non_nullable
                      as int?,
            courseSlope: freezed == courseSlope
                ? _value.courseSlope
                : courseSlope // ignore: cast_nullable_to_non_nullable
                      as double?,
            courseRating: freezed == courseRating
                ? _value.courseRating
                : courseRating // ignore: cast_nullable_to_non_nullable
                      as double?,
            totalScore: freezed == totalScore
                ? _value.totalScore
                : totalScore // ignore: cast_nullable_to_non_nullable
                      as int?,
            position: freezed == position
                ? _value.position
                : position // ignore: cast_nullable_to_non_nullable
                      as int?,
            fieldSize: freezed == fieldSize
                ? _value.fieldSize
                : fieldSize // ignore: cast_nullable_to_non_nullable
                      as int?,
            scoreToPar: freezed == scoreToPar
                ? _value.scoreToPar
                : scoreToPar // ignore: cast_nullable_to_non_nullable
                      as int?,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
            weatherConditions: freezed == weatherConditions
                ? _value.weatherConditions
                : weatherConditions // ignore: cast_nullable_to_non_nullable
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
abstract class _$$TournamentImplCopyWith<$Res>
    implements $TournamentCopyWith<$Res> {
  factory _$$TournamentImplCopyWith(
    _$TournamentImpl value,
    $Res Function(_$TournamentImpl) then,
  ) = __$$TournamentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String playerId,
    String name,
    String? tournamentType,
    DateTime startDate,
    DateTime? endDate,
    String courseName,
    String? courseCity,
    String? courseState,
    String courseCountry,
    int? coursePar,
    double? courseSlope,
    double? courseRating,
    int? totalScore,
    int? position,
    int? fieldSize,
    int? scoreToPar,
    String? notes,
    String? weatherConditions,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$TournamentImplCopyWithImpl<$Res>
    extends _$TournamentCopyWithImpl<$Res, _$TournamentImpl>
    implements _$$TournamentImplCopyWith<$Res> {
  __$$TournamentImplCopyWithImpl(
    _$TournamentImpl _value,
    $Res Function(_$TournamentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Tournament
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? playerId = null,
    Object? name = null,
    Object? tournamentType = freezed,
    Object? startDate = null,
    Object? endDate = freezed,
    Object? courseName = null,
    Object? courseCity = freezed,
    Object? courseState = freezed,
    Object? courseCountry = null,
    Object? coursePar = freezed,
    Object? courseSlope = freezed,
    Object? courseRating = freezed,
    Object? totalScore = freezed,
    Object? position = freezed,
    Object? fieldSize = freezed,
    Object? scoreToPar = freezed,
    Object? notes = freezed,
    Object? weatherConditions = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$TournamentImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        playerId: null == playerId
            ? _value.playerId
            : playerId // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        tournamentType: freezed == tournamentType
            ? _value.tournamentType
            : tournamentType // ignore: cast_nullable_to_non_nullable
                  as String?,
        startDate: null == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endDate: freezed == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        courseName: null == courseName
            ? _value.courseName
            : courseName // ignore: cast_nullable_to_non_nullable
                  as String,
        courseCity: freezed == courseCity
            ? _value.courseCity
            : courseCity // ignore: cast_nullable_to_non_nullable
                  as String?,
        courseState: freezed == courseState
            ? _value.courseState
            : courseState // ignore: cast_nullable_to_non_nullable
                  as String?,
        courseCountry: null == courseCountry
            ? _value.courseCountry
            : courseCountry // ignore: cast_nullable_to_non_nullable
                  as String,
        coursePar: freezed == coursePar
            ? _value.coursePar
            : coursePar // ignore: cast_nullable_to_non_nullable
                  as int?,
        courseSlope: freezed == courseSlope
            ? _value.courseSlope
            : courseSlope // ignore: cast_nullable_to_non_nullable
                  as double?,
        courseRating: freezed == courseRating
            ? _value.courseRating
            : courseRating // ignore: cast_nullable_to_non_nullable
                  as double?,
        totalScore: freezed == totalScore
            ? _value.totalScore
            : totalScore // ignore: cast_nullable_to_non_nullable
                  as int?,
        position: freezed == position
            ? _value.position
            : position // ignore: cast_nullable_to_non_nullable
                  as int?,
        fieldSize: freezed == fieldSize
            ? _value.fieldSize
            : fieldSize // ignore: cast_nullable_to_non_nullable
                  as int?,
        scoreToPar: freezed == scoreToPar
            ? _value.scoreToPar
            : scoreToPar // ignore: cast_nullable_to_non_nullable
                  as int?,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
        weatherConditions: freezed == weatherConditions
            ? _value.weatherConditions
            : weatherConditions // ignore: cast_nullable_to_non_nullable
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
class _$TournamentImpl implements _Tournament {
  const _$TournamentImpl({
    required this.id,
    required this.playerId,
    required this.name,
    this.tournamentType,
    required this.startDate,
    this.endDate,
    required this.courseName,
    this.courseCity,
    this.courseState,
    this.courseCountry = 'Australia',
    this.coursePar,
    this.courseSlope,
    this.courseRating,
    this.totalScore,
    this.position,
    this.fieldSize,
    this.scoreToPar,
    this.notes,
    this.weatherConditions,
    this.createdAt,
    this.updatedAt,
  });

  factory _$TournamentImpl.fromJson(Map<String, dynamic> json) =>
      _$$TournamentImplFromJson(json);

  @override
  final String id;
  @override
  final String playerId;
  // Basic Info
  @override
  final String name;
  @override
  final String? tournamentType;
  // local, regional, state, national, international
  @override
  final DateTime startDate;
  @override
  final DateTime? endDate;
  // Location
  @override
  final String courseName;
  @override
  final String? courseCity;
  @override
  final String? courseState;
  @override
  @JsonKey()
  final String courseCountry;
  @override
  final int? coursePar;
  @override
  final double? courseSlope;
  @override
  final double? courseRating;
  // Results
  @override
  final int? totalScore;
  @override
  final int? position;
  @override
  final int? fieldSize;
  @override
  final int? scoreToPar;
  // Notes
  @override
  final String? notes;
  @override
  final String? weatherConditions;
  // Timestamps
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Tournament(id: $id, playerId: $playerId, name: $name, tournamentType: $tournamentType, startDate: $startDate, endDate: $endDate, courseName: $courseName, courseCity: $courseCity, courseState: $courseState, courseCountry: $courseCountry, coursePar: $coursePar, courseSlope: $courseSlope, courseRating: $courseRating, totalScore: $totalScore, position: $position, fieldSize: $fieldSize, scoreToPar: $scoreToPar, notes: $notes, weatherConditions: $weatherConditions, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TournamentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.tournamentType, tournamentType) ||
                other.tournamentType == tournamentType) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.courseName, courseName) ||
                other.courseName == courseName) &&
            (identical(other.courseCity, courseCity) ||
                other.courseCity == courseCity) &&
            (identical(other.courseState, courseState) ||
                other.courseState == courseState) &&
            (identical(other.courseCountry, courseCountry) ||
                other.courseCountry == courseCountry) &&
            (identical(other.coursePar, coursePar) ||
                other.coursePar == coursePar) &&
            (identical(other.courseSlope, courseSlope) ||
                other.courseSlope == courseSlope) &&
            (identical(other.courseRating, courseRating) ||
                other.courseRating == courseRating) &&
            (identical(other.totalScore, totalScore) ||
                other.totalScore == totalScore) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.fieldSize, fieldSize) ||
                other.fieldSize == fieldSize) &&
            (identical(other.scoreToPar, scoreToPar) ||
                other.scoreToPar == scoreToPar) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.weatherConditions, weatherConditions) ||
                other.weatherConditions == weatherConditions) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    playerId,
    name,
    tournamentType,
    startDate,
    endDate,
    courseName,
    courseCity,
    courseState,
    courseCountry,
    coursePar,
    courseSlope,
    courseRating,
    totalScore,
    position,
    fieldSize,
    scoreToPar,
    notes,
    weatherConditions,
    createdAt,
    updatedAt,
  ]);

  /// Create a copy of Tournament
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TournamentImplCopyWith<_$TournamentImpl> get copyWith =>
      __$$TournamentImplCopyWithImpl<_$TournamentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TournamentImplToJson(this);
  }
}

abstract class _Tournament implements Tournament {
  const factory _Tournament({
    required final String id,
    required final String playerId,
    required final String name,
    final String? tournamentType,
    required final DateTime startDate,
    final DateTime? endDate,
    required final String courseName,
    final String? courseCity,
    final String? courseState,
    final String courseCountry,
    final int? coursePar,
    final double? courseSlope,
    final double? courseRating,
    final int? totalScore,
    final int? position,
    final int? fieldSize,
    final int? scoreToPar,
    final String? notes,
    final String? weatherConditions,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _$TournamentImpl;

  factory _Tournament.fromJson(Map<String, dynamic> json) =
      _$TournamentImpl.fromJson;

  @override
  String get id;
  @override
  String get playerId; // Basic Info
  @override
  String get name;
  @override
  String? get tournamentType; // local, regional, state, national, international
  @override
  DateTime get startDate;
  @override
  DateTime? get endDate; // Location
  @override
  String get courseName;
  @override
  String? get courseCity;
  @override
  String? get courseState;
  @override
  String get courseCountry;
  @override
  int? get coursePar;
  @override
  double? get courseSlope;
  @override
  double? get courseRating; // Results
  @override
  int? get totalScore;
  @override
  int? get position;
  @override
  int? get fieldSize;
  @override
  int? get scoreToPar; // Notes
  @override
  String? get notes;
  @override
  String? get weatherConditions; // Timestamps
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of Tournament
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TournamentImplCopyWith<_$TournamentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Round _$RoundFromJson(Map<String, dynamic> json) {
  return _Round.fromJson(json);
}

/// @nodoc
mixin _$Round {
  String get id => throw _privateConstructorUsedError;
  String? get tournamentId => throw _privateConstructorUsedError;
  String get playerId => throw _privateConstructorUsedError;
  int get roundNumber => throw _privateConstructorUsedError;
  DateTime get roundDate => throw _privateConstructorUsedError; // Course Info
  String? get courseName => throw _privateConstructorUsedError;
  String? get teePlayed => throw _privateConstructorUsedError;
  int? get coursePar => throw _privateConstructorUsedError;
  double? get courseSlope => throw _privateConstructorUsedError;
  double? get courseRating => throw _privateConstructorUsedError; // Scores
  int get grossScore => throw _privateConstructorUsedError;
  int? get netScore => throw _privateConstructorUsedError;
  double? get playingHandicap =>
      throw _privateConstructorUsedError; // The handicap used for this round
  double? get differential => throw _privateConstructorUsedError; // Stats
  int? get fairwaysHit => throw _privateConstructorUsedError;
  int? get fairwaysTotal => throw _privateConstructorUsedError;
  int? get greensInRegulation => throw _privateConstructorUsedError;
  int? get putts => throw _privateConstructorUsedError; // Penalties
  int get penalties => throw _privateConstructorUsedError; // Flags
  bool get isPractice => throw _privateConstructorUsedError;
  bool get isCountedForHandicap => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Round to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Round
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RoundCopyWith<Round> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoundCopyWith<$Res> {
  factory $RoundCopyWith(Round value, $Res Function(Round) then) =
      _$RoundCopyWithImpl<$Res, Round>;
  @useResult
  $Res call({
    String id,
    String? tournamentId,
    String playerId,
    int roundNumber,
    DateTime roundDate,
    String? courseName,
    String? teePlayed,
    int? coursePar,
    double? courseSlope,
    double? courseRating,
    int grossScore,
    int? netScore,
    double? playingHandicap,
    double? differential,
    int? fairwaysHit,
    int? fairwaysTotal,
    int? greensInRegulation,
    int? putts,
    int penalties,
    bool isPractice,
    bool isCountedForHandicap,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$RoundCopyWithImpl<$Res, $Val extends Round>
    implements $RoundCopyWith<$Res> {
  _$RoundCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Round
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tournamentId = freezed,
    Object? playerId = null,
    Object? roundNumber = null,
    Object? roundDate = null,
    Object? courseName = freezed,
    Object? teePlayed = freezed,
    Object? coursePar = freezed,
    Object? courseSlope = freezed,
    Object? courseRating = freezed,
    Object? grossScore = null,
    Object? netScore = freezed,
    Object? playingHandicap = freezed,
    Object? differential = freezed,
    Object? fairwaysHit = freezed,
    Object? fairwaysTotal = freezed,
    Object? greensInRegulation = freezed,
    Object? putts = freezed,
    Object? penalties = null,
    Object? isPractice = null,
    Object? isCountedForHandicap = null,
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
            tournamentId: freezed == tournamentId
                ? _value.tournamentId
                : tournamentId // ignore: cast_nullable_to_non_nullable
                      as String?,
            playerId: null == playerId
                ? _value.playerId
                : playerId // ignore: cast_nullable_to_non_nullable
                      as String,
            roundNumber: null == roundNumber
                ? _value.roundNumber
                : roundNumber // ignore: cast_nullable_to_non_nullable
                      as int,
            roundDate: null == roundDate
                ? _value.roundDate
                : roundDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            courseName: freezed == courseName
                ? _value.courseName
                : courseName // ignore: cast_nullable_to_non_nullable
                      as String?,
            teePlayed: freezed == teePlayed
                ? _value.teePlayed
                : teePlayed // ignore: cast_nullable_to_non_nullable
                      as String?,
            coursePar: freezed == coursePar
                ? _value.coursePar
                : coursePar // ignore: cast_nullable_to_non_nullable
                      as int?,
            courseSlope: freezed == courseSlope
                ? _value.courseSlope
                : courseSlope // ignore: cast_nullable_to_non_nullable
                      as double?,
            courseRating: freezed == courseRating
                ? _value.courseRating
                : courseRating // ignore: cast_nullable_to_non_nullable
                      as double?,
            grossScore: null == grossScore
                ? _value.grossScore
                : grossScore // ignore: cast_nullable_to_non_nullable
                      as int,
            netScore: freezed == netScore
                ? _value.netScore
                : netScore // ignore: cast_nullable_to_non_nullable
                      as int?,
            playingHandicap: freezed == playingHandicap
                ? _value.playingHandicap
                : playingHandicap // ignore: cast_nullable_to_non_nullable
                      as double?,
            differential: freezed == differential
                ? _value.differential
                : differential // ignore: cast_nullable_to_non_nullable
                      as double?,
            fairwaysHit: freezed == fairwaysHit
                ? _value.fairwaysHit
                : fairwaysHit // ignore: cast_nullable_to_non_nullable
                      as int?,
            fairwaysTotal: freezed == fairwaysTotal
                ? _value.fairwaysTotal
                : fairwaysTotal // ignore: cast_nullable_to_non_nullable
                      as int?,
            greensInRegulation: freezed == greensInRegulation
                ? _value.greensInRegulation
                : greensInRegulation // ignore: cast_nullable_to_non_nullable
                      as int?,
            putts: freezed == putts
                ? _value.putts
                : putts // ignore: cast_nullable_to_non_nullable
                      as int?,
            penalties: null == penalties
                ? _value.penalties
                : penalties // ignore: cast_nullable_to_non_nullable
                      as int,
            isPractice: null == isPractice
                ? _value.isPractice
                : isPractice // ignore: cast_nullable_to_non_nullable
                      as bool,
            isCountedForHandicap: null == isCountedForHandicap
                ? _value.isCountedForHandicap
                : isCountedForHandicap // ignore: cast_nullable_to_non_nullable
                      as bool,
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
abstract class _$$RoundImplCopyWith<$Res> implements $RoundCopyWith<$Res> {
  factory _$$RoundImplCopyWith(
    _$RoundImpl value,
    $Res Function(_$RoundImpl) then,
  ) = __$$RoundImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String? tournamentId,
    String playerId,
    int roundNumber,
    DateTime roundDate,
    String? courseName,
    String? teePlayed,
    int? coursePar,
    double? courseSlope,
    double? courseRating,
    int grossScore,
    int? netScore,
    double? playingHandicap,
    double? differential,
    int? fairwaysHit,
    int? fairwaysTotal,
    int? greensInRegulation,
    int? putts,
    int penalties,
    bool isPractice,
    bool isCountedForHandicap,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$RoundImplCopyWithImpl<$Res>
    extends _$RoundCopyWithImpl<$Res, _$RoundImpl>
    implements _$$RoundImplCopyWith<$Res> {
  __$$RoundImplCopyWithImpl(
    _$RoundImpl _value,
    $Res Function(_$RoundImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Round
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tournamentId = freezed,
    Object? playerId = null,
    Object? roundNumber = null,
    Object? roundDate = null,
    Object? courseName = freezed,
    Object? teePlayed = freezed,
    Object? coursePar = freezed,
    Object? courseSlope = freezed,
    Object? courseRating = freezed,
    Object? grossScore = null,
    Object? netScore = freezed,
    Object? playingHandicap = freezed,
    Object? differential = freezed,
    Object? fairwaysHit = freezed,
    Object? fairwaysTotal = freezed,
    Object? greensInRegulation = freezed,
    Object? putts = freezed,
    Object? penalties = null,
    Object? isPractice = null,
    Object? isCountedForHandicap = null,
    Object? notes = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$RoundImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        tournamentId: freezed == tournamentId
            ? _value.tournamentId
            : tournamentId // ignore: cast_nullable_to_non_nullable
                  as String?,
        playerId: null == playerId
            ? _value.playerId
            : playerId // ignore: cast_nullable_to_non_nullable
                  as String,
        roundNumber: null == roundNumber
            ? _value.roundNumber
            : roundNumber // ignore: cast_nullable_to_non_nullable
                  as int,
        roundDate: null == roundDate
            ? _value.roundDate
            : roundDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        courseName: freezed == courseName
            ? _value.courseName
            : courseName // ignore: cast_nullable_to_non_nullable
                  as String?,
        teePlayed: freezed == teePlayed
            ? _value.teePlayed
            : teePlayed // ignore: cast_nullable_to_non_nullable
                  as String?,
        coursePar: freezed == coursePar
            ? _value.coursePar
            : coursePar // ignore: cast_nullable_to_non_nullable
                  as int?,
        courseSlope: freezed == courseSlope
            ? _value.courseSlope
            : courseSlope // ignore: cast_nullable_to_non_nullable
                  as double?,
        courseRating: freezed == courseRating
            ? _value.courseRating
            : courseRating // ignore: cast_nullable_to_non_nullable
                  as double?,
        grossScore: null == grossScore
            ? _value.grossScore
            : grossScore // ignore: cast_nullable_to_non_nullable
                  as int,
        netScore: freezed == netScore
            ? _value.netScore
            : netScore // ignore: cast_nullable_to_non_nullable
                  as int?,
        playingHandicap: freezed == playingHandicap
            ? _value.playingHandicap
            : playingHandicap // ignore: cast_nullable_to_non_nullable
                  as double?,
        differential: freezed == differential
            ? _value.differential
            : differential // ignore: cast_nullable_to_non_nullable
                  as double?,
        fairwaysHit: freezed == fairwaysHit
            ? _value.fairwaysHit
            : fairwaysHit // ignore: cast_nullable_to_non_nullable
                  as int?,
        fairwaysTotal: freezed == fairwaysTotal
            ? _value.fairwaysTotal
            : fairwaysTotal // ignore: cast_nullable_to_non_nullable
                  as int?,
        greensInRegulation: freezed == greensInRegulation
            ? _value.greensInRegulation
            : greensInRegulation // ignore: cast_nullable_to_non_nullable
                  as int?,
        putts: freezed == putts
            ? _value.putts
            : putts // ignore: cast_nullable_to_non_nullable
                  as int?,
        penalties: null == penalties
            ? _value.penalties
            : penalties // ignore: cast_nullable_to_non_nullable
                  as int,
        isPractice: null == isPractice
            ? _value.isPractice
            : isPractice // ignore: cast_nullable_to_non_nullable
                  as bool,
        isCountedForHandicap: null == isCountedForHandicap
            ? _value.isCountedForHandicap
            : isCountedForHandicap // ignore: cast_nullable_to_non_nullable
                  as bool,
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
class _$RoundImpl implements _Round {
  const _$RoundImpl({
    required this.id,
    this.tournamentId,
    required this.playerId,
    this.roundNumber = 1,
    required this.roundDate,
    this.courseName,
    this.teePlayed,
    this.coursePar,
    this.courseSlope,
    this.courseRating,
    required this.grossScore,
    this.netScore,
    this.playingHandicap,
    this.differential,
    this.fairwaysHit,
    this.fairwaysTotal,
    this.greensInRegulation,
    this.putts,
    this.penalties = 0,
    this.isPractice = false,
    this.isCountedForHandicap = true,
    this.notes,
    this.createdAt,
    this.updatedAt,
  });

  factory _$RoundImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoundImplFromJson(json);

  @override
  final String id;
  @override
  final String? tournamentId;
  @override
  final String playerId;
  @override
  @JsonKey()
  final int roundNumber;
  @override
  final DateTime roundDate;
  // Course Info
  @override
  final String? courseName;
  @override
  final String? teePlayed;
  @override
  final int? coursePar;
  @override
  final double? courseSlope;
  @override
  final double? courseRating;
  // Scores
  @override
  final int grossScore;
  @override
  final int? netScore;
  @override
  final double? playingHandicap;
  // The handicap used for this round
  @override
  final double? differential;
  // Stats
  @override
  final int? fairwaysHit;
  @override
  final int? fairwaysTotal;
  @override
  final int? greensInRegulation;
  @override
  final int? putts;
  // Penalties
  @override
  @JsonKey()
  final int penalties;
  // Flags
  @override
  @JsonKey()
  final bool isPractice;
  @override
  @JsonKey()
  final bool isCountedForHandicap;
  @override
  final String? notes;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Round(id: $id, tournamentId: $tournamentId, playerId: $playerId, roundNumber: $roundNumber, roundDate: $roundDate, courseName: $courseName, teePlayed: $teePlayed, coursePar: $coursePar, courseSlope: $courseSlope, courseRating: $courseRating, grossScore: $grossScore, netScore: $netScore, playingHandicap: $playingHandicap, differential: $differential, fairwaysHit: $fairwaysHit, fairwaysTotal: $fairwaysTotal, greensInRegulation: $greensInRegulation, putts: $putts, penalties: $penalties, isPractice: $isPractice, isCountedForHandicap: $isCountedForHandicap, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoundImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.tournamentId, tournamentId) ||
                other.tournamentId == tournamentId) &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId) &&
            (identical(other.roundNumber, roundNumber) ||
                other.roundNumber == roundNumber) &&
            (identical(other.roundDate, roundDate) ||
                other.roundDate == roundDate) &&
            (identical(other.courseName, courseName) ||
                other.courseName == courseName) &&
            (identical(other.teePlayed, teePlayed) ||
                other.teePlayed == teePlayed) &&
            (identical(other.coursePar, coursePar) ||
                other.coursePar == coursePar) &&
            (identical(other.courseSlope, courseSlope) ||
                other.courseSlope == courseSlope) &&
            (identical(other.courseRating, courseRating) ||
                other.courseRating == courseRating) &&
            (identical(other.grossScore, grossScore) ||
                other.grossScore == grossScore) &&
            (identical(other.netScore, netScore) ||
                other.netScore == netScore) &&
            (identical(other.playingHandicap, playingHandicap) ||
                other.playingHandicap == playingHandicap) &&
            (identical(other.differential, differential) ||
                other.differential == differential) &&
            (identical(other.fairwaysHit, fairwaysHit) ||
                other.fairwaysHit == fairwaysHit) &&
            (identical(other.fairwaysTotal, fairwaysTotal) ||
                other.fairwaysTotal == fairwaysTotal) &&
            (identical(other.greensInRegulation, greensInRegulation) ||
                other.greensInRegulation == greensInRegulation) &&
            (identical(other.putts, putts) || other.putts == putts) &&
            (identical(other.penalties, penalties) ||
                other.penalties == penalties) &&
            (identical(other.isPractice, isPractice) ||
                other.isPractice == isPractice) &&
            (identical(other.isCountedForHandicap, isCountedForHandicap) ||
                other.isCountedForHandicap == isCountedForHandicap) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    tournamentId,
    playerId,
    roundNumber,
    roundDate,
    courseName,
    teePlayed,
    coursePar,
    courseSlope,
    courseRating,
    grossScore,
    netScore,
    playingHandicap,
    differential,
    fairwaysHit,
    fairwaysTotal,
    greensInRegulation,
    putts,
    penalties,
    isPractice,
    isCountedForHandicap,
    notes,
    createdAt,
    updatedAt,
  ]);

  /// Create a copy of Round
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RoundImplCopyWith<_$RoundImpl> get copyWith =>
      __$$RoundImplCopyWithImpl<_$RoundImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RoundImplToJson(this);
  }
}

abstract class _Round implements Round {
  const factory _Round({
    required final String id,
    final String? tournamentId,
    required final String playerId,
    final int roundNumber,
    required final DateTime roundDate,
    final String? courseName,
    final String? teePlayed,
    final int? coursePar,
    final double? courseSlope,
    final double? courseRating,
    required final int grossScore,
    final int? netScore,
    final double? playingHandicap,
    final double? differential,
    final int? fairwaysHit,
    final int? fairwaysTotal,
    final int? greensInRegulation,
    final int? putts,
    final int penalties,
    final bool isPractice,
    final bool isCountedForHandicap,
    final String? notes,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _$RoundImpl;

  factory _Round.fromJson(Map<String, dynamic> json) = _$RoundImpl.fromJson;

  @override
  String get id;
  @override
  String? get tournamentId;
  @override
  String get playerId;
  @override
  int get roundNumber;
  @override
  DateTime get roundDate; // Course Info
  @override
  String? get courseName;
  @override
  String? get teePlayed;
  @override
  int? get coursePar;
  @override
  double? get courseSlope;
  @override
  double? get courseRating; // Scores
  @override
  int get grossScore;
  @override
  int? get netScore;
  @override
  double? get playingHandicap; // The handicap used for this round
  @override
  double? get differential; // Stats
  @override
  int? get fairwaysHit;
  @override
  int? get fairwaysTotal;
  @override
  int? get greensInRegulation;
  @override
  int? get putts; // Penalties
  @override
  int get penalties; // Flags
  @override
  bool get isPractice;
  @override
  bool get isCountedForHandicap;
  @override
  String? get notes;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of Round
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoundImplCopyWith<_$RoundImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
