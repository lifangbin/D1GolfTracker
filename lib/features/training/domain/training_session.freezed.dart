// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'training_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TrainingSession _$TrainingSessionFromJson(Map<String, dynamic> json) {
  return _TrainingSession.fromJson(json);
}

/// @nodoc
mixin _$TrainingSession {
  String get id => throw _privateConstructorUsedError;
  String get playerId => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  TrainingType get type => throw _privateConstructorUsedError;
  int get durationMinutes => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  TrainingIntensity? get intensity => throw _privateConstructorUsedError;
  List<TrainingFocus> get focusAreas => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  String? get coachName => throw _privateConstructorUsedError;
  int? get ballsHit => throw _privateConstructorUsedError;
  int? get puttsMade => throw _privateConstructorUsedError;
  int? get puttsAttempted => throw _privateConstructorUsedError;
  double? get rating =>
      throw _privateConstructorUsedError; // 1-5 self-assessment
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this TrainingSession to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TrainingSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TrainingSessionCopyWith<TrainingSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrainingSessionCopyWith<$Res> {
  factory $TrainingSessionCopyWith(
    TrainingSession value,
    $Res Function(TrainingSession) then,
  ) = _$TrainingSessionCopyWithImpl<$Res, TrainingSession>;
  @useResult
  $Res call({
    String id,
    String playerId,
    DateTime date,
    TrainingType type,
    int durationMinutes,
    String? location,
    TrainingIntensity? intensity,
    List<TrainingFocus> focusAreas,
    String? notes,
    String? coachName,
    int? ballsHit,
    int? puttsMade,
    int? puttsAttempted,
    double? rating,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$TrainingSessionCopyWithImpl<$Res, $Val extends TrainingSession>
    implements $TrainingSessionCopyWith<$Res> {
  _$TrainingSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TrainingSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? playerId = null,
    Object? date = null,
    Object? type = null,
    Object? durationMinutes = null,
    Object? location = freezed,
    Object? intensity = freezed,
    Object? focusAreas = null,
    Object? notes = freezed,
    Object? coachName = freezed,
    Object? ballsHit = freezed,
    Object? puttsMade = freezed,
    Object? puttsAttempted = freezed,
    Object? rating = freezed,
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
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as TrainingType,
            durationMinutes: null == durationMinutes
                ? _value.durationMinutes
                : durationMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
            location: freezed == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as String?,
            intensity: freezed == intensity
                ? _value.intensity
                : intensity // ignore: cast_nullable_to_non_nullable
                      as TrainingIntensity?,
            focusAreas: null == focusAreas
                ? _value.focusAreas
                : focusAreas // ignore: cast_nullable_to_non_nullable
                      as List<TrainingFocus>,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
            coachName: freezed == coachName
                ? _value.coachName
                : coachName // ignore: cast_nullable_to_non_nullable
                      as String?,
            ballsHit: freezed == ballsHit
                ? _value.ballsHit
                : ballsHit // ignore: cast_nullable_to_non_nullable
                      as int?,
            puttsMade: freezed == puttsMade
                ? _value.puttsMade
                : puttsMade // ignore: cast_nullable_to_non_nullable
                      as int?,
            puttsAttempted: freezed == puttsAttempted
                ? _value.puttsAttempted
                : puttsAttempted // ignore: cast_nullable_to_non_nullable
                      as int?,
            rating: freezed == rating
                ? _value.rating
                : rating // ignore: cast_nullable_to_non_nullable
                      as double?,
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
abstract class _$$TrainingSessionImplCopyWith<$Res>
    implements $TrainingSessionCopyWith<$Res> {
  factory _$$TrainingSessionImplCopyWith(
    _$TrainingSessionImpl value,
    $Res Function(_$TrainingSessionImpl) then,
  ) = __$$TrainingSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String playerId,
    DateTime date,
    TrainingType type,
    int durationMinutes,
    String? location,
    TrainingIntensity? intensity,
    List<TrainingFocus> focusAreas,
    String? notes,
    String? coachName,
    int? ballsHit,
    int? puttsMade,
    int? puttsAttempted,
    double? rating,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$TrainingSessionImplCopyWithImpl<$Res>
    extends _$TrainingSessionCopyWithImpl<$Res, _$TrainingSessionImpl>
    implements _$$TrainingSessionImplCopyWith<$Res> {
  __$$TrainingSessionImplCopyWithImpl(
    _$TrainingSessionImpl _value,
    $Res Function(_$TrainingSessionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TrainingSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? playerId = null,
    Object? date = null,
    Object? type = null,
    Object? durationMinutes = null,
    Object? location = freezed,
    Object? intensity = freezed,
    Object? focusAreas = null,
    Object? notes = freezed,
    Object? coachName = freezed,
    Object? ballsHit = freezed,
    Object? puttsMade = freezed,
    Object? puttsAttempted = freezed,
    Object? rating = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$TrainingSessionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        playerId: null == playerId
            ? _value.playerId
            : playerId // ignore: cast_nullable_to_non_nullable
                  as String,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as TrainingType,
        durationMinutes: null == durationMinutes
            ? _value.durationMinutes
            : durationMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
        location: freezed == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String?,
        intensity: freezed == intensity
            ? _value.intensity
            : intensity // ignore: cast_nullable_to_non_nullable
                  as TrainingIntensity?,
        focusAreas: null == focusAreas
            ? _value._focusAreas
            : focusAreas // ignore: cast_nullable_to_non_nullable
                  as List<TrainingFocus>,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
        coachName: freezed == coachName
            ? _value.coachName
            : coachName // ignore: cast_nullable_to_non_nullable
                  as String?,
        ballsHit: freezed == ballsHit
            ? _value.ballsHit
            : ballsHit // ignore: cast_nullable_to_non_nullable
                  as int?,
        puttsMade: freezed == puttsMade
            ? _value.puttsMade
            : puttsMade // ignore: cast_nullable_to_non_nullable
                  as int?,
        puttsAttempted: freezed == puttsAttempted
            ? _value.puttsAttempted
            : puttsAttempted // ignore: cast_nullable_to_non_nullable
                  as int?,
        rating: freezed == rating
            ? _value.rating
            : rating // ignore: cast_nullable_to_non_nullable
                  as double?,
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
class _$TrainingSessionImpl extends _TrainingSession {
  const _$TrainingSessionImpl({
    required this.id,
    required this.playerId,
    required this.date,
    required this.type,
    required this.durationMinutes,
    this.location,
    this.intensity,
    final List<TrainingFocus> focusAreas = const [],
    this.notes,
    this.coachName,
    this.ballsHit,
    this.puttsMade,
    this.puttsAttempted,
    this.rating,
    this.createdAt,
    this.updatedAt,
  }) : _focusAreas = focusAreas,
       super._();

  factory _$TrainingSessionImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrainingSessionImplFromJson(json);

  @override
  final String id;
  @override
  final String playerId;
  @override
  final DateTime date;
  @override
  final TrainingType type;
  @override
  final int durationMinutes;
  @override
  final String? location;
  @override
  final TrainingIntensity? intensity;
  final List<TrainingFocus> _focusAreas;
  @override
  @JsonKey()
  List<TrainingFocus> get focusAreas {
    if (_focusAreas is EqualUnmodifiableListView) return _focusAreas;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_focusAreas);
  }

  @override
  final String? notes;
  @override
  final String? coachName;
  @override
  final int? ballsHit;
  @override
  final int? puttsMade;
  @override
  final int? puttsAttempted;
  @override
  final double? rating;
  // 1-5 self-assessment
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'TrainingSession(id: $id, playerId: $playerId, date: $date, type: $type, durationMinutes: $durationMinutes, location: $location, intensity: $intensity, focusAreas: $focusAreas, notes: $notes, coachName: $coachName, ballsHit: $ballsHit, puttsMade: $puttsMade, puttsAttempted: $puttsAttempted, rating: $rating, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrainingSessionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.intensity, intensity) ||
                other.intensity == intensity) &&
            const DeepCollectionEquality().equals(
              other._focusAreas,
              _focusAreas,
            ) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.coachName, coachName) ||
                other.coachName == coachName) &&
            (identical(other.ballsHit, ballsHit) ||
                other.ballsHit == ballsHit) &&
            (identical(other.puttsMade, puttsMade) ||
                other.puttsMade == puttsMade) &&
            (identical(other.puttsAttempted, puttsAttempted) ||
                other.puttsAttempted == puttsAttempted) &&
            (identical(other.rating, rating) || other.rating == rating) &&
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
    date,
    type,
    durationMinutes,
    location,
    intensity,
    const DeepCollectionEquality().hash(_focusAreas),
    notes,
    coachName,
    ballsHit,
    puttsMade,
    puttsAttempted,
    rating,
    createdAt,
    updatedAt,
  );

  /// Create a copy of TrainingSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TrainingSessionImplCopyWith<_$TrainingSessionImpl> get copyWith =>
      __$$TrainingSessionImplCopyWithImpl<_$TrainingSessionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TrainingSessionImplToJson(this);
  }
}

abstract class _TrainingSession extends TrainingSession {
  const factory _TrainingSession({
    required final String id,
    required final String playerId,
    required final DateTime date,
    required final TrainingType type,
    required final int durationMinutes,
    final String? location,
    final TrainingIntensity? intensity,
    final List<TrainingFocus> focusAreas,
    final String? notes,
    final String? coachName,
    final int? ballsHit,
    final int? puttsMade,
    final int? puttsAttempted,
    final double? rating,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _$TrainingSessionImpl;
  const _TrainingSession._() : super._();

  factory _TrainingSession.fromJson(Map<String, dynamic> json) =
      _$TrainingSessionImpl.fromJson;

  @override
  String get id;
  @override
  String get playerId;
  @override
  DateTime get date;
  @override
  TrainingType get type;
  @override
  int get durationMinutes;
  @override
  String? get location;
  @override
  TrainingIntensity? get intensity;
  @override
  List<TrainingFocus> get focusAreas;
  @override
  String? get notes;
  @override
  String? get coachName;
  @override
  int? get ballsHit;
  @override
  int? get puttsMade;
  @override
  int? get puttsAttempted;
  @override
  double? get rating; // 1-5 self-assessment
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of TrainingSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TrainingSessionImplCopyWith<_$TrainingSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TrainingSummary {
  int get totalSessions => throw _privateConstructorUsedError;
  int get totalMinutes => throw _privateConstructorUsedError;
  Map<TrainingType, int> get sessionsByType =>
      throw _privateConstructorUsedError;
  Map<TrainingType, int> get minutesByType =>
      throw _privateConstructorUsedError;
  double get averageRating => throw _privateConstructorUsedError;
  int get totalBallsHit => throw _privateConstructorUsedError;

  /// Create a copy of TrainingSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TrainingSummaryCopyWith<TrainingSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrainingSummaryCopyWith<$Res> {
  factory $TrainingSummaryCopyWith(
    TrainingSummary value,
    $Res Function(TrainingSummary) then,
  ) = _$TrainingSummaryCopyWithImpl<$Res, TrainingSummary>;
  @useResult
  $Res call({
    int totalSessions,
    int totalMinutes,
    Map<TrainingType, int> sessionsByType,
    Map<TrainingType, int> minutesByType,
    double averageRating,
    int totalBallsHit,
  });
}

/// @nodoc
class _$TrainingSummaryCopyWithImpl<$Res, $Val extends TrainingSummary>
    implements $TrainingSummaryCopyWith<$Res> {
  _$TrainingSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TrainingSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalSessions = null,
    Object? totalMinutes = null,
    Object? sessionsByType = null,
    Object? minutesByType = null,
    Object? averageRating = null,
    Object? totalBallsHit = null,
  }) {
    return _then(
      _value.copyWith(
            totalSessions: null == totalSessions
                ? _value.totalSessions
                : totalSessions // ignore: cast_nullable_to_non_nullable
                      as int,
            totalMinutes: null == totalMinutes
                ? _value.totalMinutes
                : totalMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
            sessionsByType: null == sessionsByType
                ? _value.sessionsByType
                : sessionsByType // ignore: cast_nullable_to_non_nullable
                      as Map<TrainingType, int>,
            minutesByType: null == minutesByType
                ? _value.minutesByType
                : minutesByType // ignore: cast_nullable_to_non_nullable
                      as Map<TrainingType, int>,
            averageRating: null == averageRating
                ? _value.averageRating
                : averageRating // ignore: cast_nullable_to_non_nullable
                      as double,
            totalBallsHit: null == totalBallsHit
                ? _value.totalBallsHit
                : totalBallsHit // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TrainingSummaryImplCopyWith<$Res>
    implements $TrainingSummaryCopyWith<$Res> {
  factory _$$TrainingSummaryImplCopyWith(
    _$TrainingSummaryImpl value,
    $Res Function(_$TrainingSummaryImpl) then,
  ) = __$$TrainingSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int totalSessions,
    int totalMinutes,
    Map<TrainingType, int> sessionsByType,
    Map<TrainingType, int> minutesByType,
    double averageRating,
    int totalBallsHit,
  });
}

/// @nodoc
class __$$TrainingSummaryImplCopyWithImpl<$Res>
    extends _$TrainingSummaryCopyWithImpl<$Res, _$TrainingSummaryImpl>
    implements _$$TrainingSummaryImplCopyWith<$Res> {
  __$$TrainingSummaryImplCopyWithImpl(
    _$TrainingSummaryImpl _value,
    $Res Function(_$TrainingSummaryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TrainingSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalSessions = null,
    Object? totalMinutes = null,
    Object? sessionsByType = null,
    Object? minutesByType = null,
    Object? averageRating = null,
    Object? totalBallsHit = null,
  }) {
    return _then(
      _$TrainingSummaryImpl(
        totalSessions: null == totalSessions
            ? _value.totalSessions
            : totalSessions // ignore: cast_nullable_to_non_nullable
                  as int,
        totalMinutes: null == totalMinutes
            ? _value.totalMinutes
            : totalMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
        sessionsByType: null == sessionsByType
            ? _value._sessionsByType
            : sessionsByType // ignore: cast_nullable_to_non_nullable
                  as Map<TrainingType, int>,
        minutesByType: null == minutesByType
            ? _value._minutesByType
            : minutesByType // ignore: cast_nullable_to_non_nullable
                  as Map<TrainingType, int>,
        averageRating: null == averageRating
            ? _value.averageRating
            : averageRating // ignore: cast_nullable_to_non_nullable
                  as double,
        totalBallsHit: null == totalBallsHit
            ? _value.totalBallsHit
            : totalBallsHit // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$TrainingSummaryImpl implements _TrainingSummary {
  const _$TrainingSummaryImpl({
    required this.totalSessions,
    required this.totalMinutes,
    required final Map<TrainingType, int> sessionsByType,
    required final Map<TrainingType, int> minutesByType,
    required this.averageRating,
    required this.totalBallsHit,
  }) : _sessionsByType = sessionsByType,
       _minutesByType = minutesByType;

  @override
  final int totalSessions;
  @override
  final int totalMinutes;
  final Map<TrainingType, int> _sessionsByType;
  @override
  Map<TrainingType, int> get sessionsByType {
    if (_sessionsByType is EqualUnmodifiableMapView) return _sessionsByType;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_sessionsByType);
  }

  final Map<TrainingType, int> _minutesByType;
  @override
  Map<TrainingType, int> get minutesByType {
    if (_minutesByType is EqualUnmodifiableMapView) return _minutesByType;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_minutesByType);
  }

  @override
  final double averageRating;
  @override
  final int totalBallsHit;

  @override
  String toString() {
    return 'TrainingSummary(totalSessions: $totalSessions, totalMinutes: $totalMinutes, sessionsByType: $sessionsByType, minutesByType: $minutesByType, averageRating: $averageRating, totalBallsHit: $totalBallsHit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrainingSummaryImpl &&
            (identical(other.totalSessions, totalSessions) ||
                other.totalSessions == totalSessions) &&
            (identical(other.totalMinutes, totalMinutes) ||
                other.totalMinutes == totalMinutes) &&
            const DeepCollectionEquality().equals(
              other._sessionsByType,
              _sessionsByType,
            ) &&
            const DeepCollectionEquality().equals(
              other._minutesByType,
              _minutesByType,
            ) &&
            (identical(other.averageRating, averageRating) ||
                other.averageRating == averageRating) &&
            (identical(other.totalBallsHit, totalBallsHit) ||
                other.totalBallsHit == totalBallsHit));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    totalSessions,
    totalMinutes,
    const DeepCollectionEquality().hash(_sessionsByType),
    const DeepCollectionEquality().hash(_minutesByType),
    averageRating,
    totalBallsHit,
  );

  /// Create a copy of TrainingSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TrainingSummaryImplCopyWith<_$TrainingSummaryImpl> get copyWith =>
      __$$TrainingSummaryImplCopyWithImpl<_$TrainingSummaryImpl>(
        this,
        _$identity,
      );
}

abstract class _TrainingSummary implements TrainingSummary {
  const factory _TrainingSummary({
    required final int totalSessions,
    required final int totalMinutes,
    required final Map<TrainingType, int> sessionsByType,
    required final Map<TrainingType, int> minutesByType,
    required final double averageRating,
    required final int totalBallsHit,
  }) = _$TrainingSummaryImpl;

  @override
  int get totalSessions;
  @override
  int get totalMinutes;
  @override
  Map<TrainingType, int> get sessionsByType;
  @override
  Map<TrainingType, int> get minutesByType;
  @override
  double get averageRating;
  @override
  int get totalBallsHit;

  /// Create a copy of TrainingSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TrainingSummaryImplCopyWith<_$TrainingSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
