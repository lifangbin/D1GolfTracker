// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hole_score.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

HoleScore _$HoleScoreFromJson(Map<String, dynamic> json) {
  return _HoleScore.fromJson(json);
}

/// @nodoc
mixin _$HoleScore {
  String get id => throw _privateConstructorUsedError;
  String get roundId => throw _privateConstructorUsedError;
  int get holeNumber => throw _privateConstructorUsedError;
  int get par => throw _privateConstructorUsedError;
  int? get strokeIndex => throw _privateConstructorUsedError;
  int get strokes => throw _privateConstructorUsedError;
  int? get putts => throw _privateConstructorUsedError;
  bool? get fairwayHit => throw _privateConstructorUsedError;
  bool? get greenInRegulation => throw _privateConstructorUsedError;
  bool? get sandSave => throw _privateConstructorUsedError;
  bool? get upAndDown => throw _privateConstructorUsedError;
  int get penaltyStrokes => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Serializes this HoleScore to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HoleScore
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HoleScoreCopyWith<HoleScore> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HoleScoreCopyWith<$Res> {
  factory $HoleScoreCopyWith(HoleScore value, $Res Function(HoleScore) then) =
      _$HoleScoreCopyWithImpl<$Res, HoleScore>;
  @useResult
  $Res call({
    String id,
    String roundId,
    int holeNumber,
    int par,
    int? strokeIndex,
    int strokes,
    int? putts,
    bool? fairwayHit,
    bool? greenInRegulation,
    bool? sandSave,
    bool? upAndDown,
    int penaltyStrokes,
    String? notes,
  });
}

/// @nodoc
class _$HoleScoreCopyWithImpl<$Res, $Val extends HoleScore>
    implements $HoleScoreCopyWith<$Res> {
  _$HoleScoreCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HoleScore
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? roundId = null,
    Object? holeNumber = null,
    Object? par = null,
    Object? strokeIndex = freezed,
    Object? strokes = null,
    Object? putts = freezed,
    Object? fairwayHit = freezed,
    Object? greenInRegulation = freezed,
    Object? sandSave = freezed,
    Object? upAndDown = freezed,
    Object? penaltyStrokes = null,
    Object? notes = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            roundId: null == roundId
                ? _value.roundId
                : roundId // ignore: cast_nullable_to_non_nullable
                      as String,
            holeNumber: null == holeNumber
                ? _value.holeNumber
                : holeNumber // ignore: cast_nullable_to_non_nullable
                      as int,
            par: null == par
                ? _value.par
                : par // ignore: cast_nullable_to_non_nullable
                      as int,
            strokeIndex: freezed == strokeIndex
                ? _value.strokeIndex
                : strokeIndex // ignore: cast_nullable_to_non_nullable
                      as int?,
            strokes: null == strokes
                ? _value.strokes
                : strokes // ignore: cast_nullable_to_non_nullable
                      as int,
            putts: freezed == putts
                ? _value.putts
                : putts // ignore: cast_nullable_to_non_nullable
                      as int?,
            fairwayHit: freezed == fairwayHit
                ? _value.fairwayHit
                : fairwayHit // ignore: cast_nullable_to_non_nullable
                      as bool?,
            greenInRegulation: freezed == greenInRegulation
                ? _value.greenInRegulation
                : greenInRegulation // ignore: cast_nullable_to_non_nullable
                      as bool?,
            sandSave: freezed == sandSave
                ? _value.sandSave
                : sandSave // ignore: cast_nullable_to_non_nullable
                      as bool?,
            upAndDown: freezed == upAndDown
                ? _value.upAndDown
                : upAndDown // ignore: cast_nullable_to_non_nullable
                      as bool?,
            penaltyStrokes: null == penaltyStrokes
                ? _value.penaltyStrokes
                : penaltyStrokes // ignore: cast_nullable_to_non_nullable
                      as int,
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
abstract class _$$HoleScoreImplCopyWith<$Res>
    implements $HoleScoreCopyWith<$Res> {
  factory _$$HoleScoreImplCopyWith(
    _$HoleScoreImpl value,
    $Res Function(_$HoleScoreImpl) then,
  ) = __$$HoleScoreImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String roundId,
    int holeNumber,
    int par,
    int? strokeIndex,
    int strokes,
    int? putts,
    bool? fairwayHit,
    bool? greenInRegulation,
    bool? sandSave,
    bool? upAndDown,
    int penaltyStrokes,
    String? notes,
  });
}

/// @nodoc
class __$$HoleScoreImplCopyWithImpl<$Res>
    extends _$HoleScoreCopyWithImpl<$Res, _$HoleScoreImpl>
    implements _$$HoleScoreImplCopyWith<$Res> {
  __$$HoleScoreImplCopyWithImpl(
    _$HoleScoreImpl _value,
    $Res Function(_$HoleScoreImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HoleScore
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? roundId = null,
    Object? holeNumber = null,
    Object? par = null,
    Object? strokeIndex = freezed,
    Object? strokes = null,
    Object? putts = freezed,
    Object? fairwayHit = freezed,
    Object? greenInRegulation = freezed,
    Object? sandSave = freezed,
    Object? upAndDown = freezed,
    Object? penaltyStrokes = null,
    Object? notes = freezed,
  }) {
    return _then(
      _$HoleScoreImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        roundId: null == roundId
            ? _value.roundId
            : roundId // ignore: cast_nullable_to_non_nullable
                  as String,
        holeNumber: null == holeNumber
            ? _value.holeNumber
            : holeNumber // ignore: cast_nullable_to_non_nullable
                  as int,
        par: null == par
            ? _value.par
            : par // ignore: cast_nullable_to_non_nullable
                  as int,
        strokeIndex: freezed == strokeIndex
            ? _value.strokeIndex
            : strokeIndex // ignore: cast_nullable_to_non_nullable
                  as int?,
        strokes: null == strokes
            ? _value.strokes
            : strokes // ignore: cast_nullable_to_non_nullable
                  as int,
        putts: freezed == putts
            ? _value.putts
            : putts // ignore: cast_nullable_to_non_nullable
                  as int?,
        fairwayHit: freezed == fairwayHit
            ? _value.fairwayHit
            : fairwayHit // ignore: cast_nullable_to_non_nullable
                  as bool?,
        greenInRegulation: freezed == greenInRegulation
            ? _value.greenInRegulation
            : greenInRegulation // ignore: cast_nullable_to_non_nullable
                  as bool?,
        sandSave: freezed == sandSave
            ? _value.sandSave
            : sandSave // ignore: cast_nullable_to_non_nullable
                  as bool?,
        upAndDown: freezed == upAndDown
            ? _value.upAndDown
            : upAndDown // ignore: cast_nullable_to_non_nullable
                  as bool?,
        penaltyStrokes: null == penaltyStrokes
            ? _value.penaltyStrokes
            : penaltyStrokes // ignore: cast_nullable_to_non_nullable
                  as int,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$HoleScoreImpl implements _HoleScore {
  const _$HoleScoreImpl({
    required this.id,
    required this.roundId,
    required this.holeNumber,
    required this.par,
    this.strokeIndex,
    required this.strokes,
    this.putts,
    this.fairwayHit,
    this.greenInRegulation,
    this.sandSave,
    this.upAndDown,
    this.penaltyStrokes = 0,
    this.notes,
  });

  factory _$HoleScoreImpl.fromJson(Map<String, dynamic> json) =>
      _$$HoleScoreImplFromJson(json);

  @override
  final String id;
  @override
  final String roundId;
  @override
  final int holeNumber;
  @override
  final int par;
  @override
  final int? strokeIndex;
  @override
  final int strokes;
  @override
  final int? putts;
  @override
  final bool? fairwayHit;
  @override
  final bool? greenInRegulation;
  @override
  final bool? sandSave;
  @override
  final bool? upAndDown;
  @override
  @JsonKey()
  final int penaltyStrokes;
  @override
  final String? notes;

  @override
  String toString() {
    return 'HoleScore(id: $id, roundId: $roundId, holeNumber: $holeNumber, par: $par, strokeIndex: $strokeIndex, strokes: $strokes, putts: $putts, fairwayHit: $fairwayHit, greenInRegulation: $greenInRegulation, sandSave: $sandSave, upAndDown: $upAndDown, penaltyStrokes: $penaltyStrokes, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HoleScoreImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.roundId, roundId) || other.roundId == roundId) &&
            (identical(other.holeNumber, holeNumber) ||
                other.holeNumber == holeNumber) &&
            (identical(other.par, par) || other.par == par) &&
            (identical(other.strokeIndex, strokeIndex) ||
                other.strokeIndex == strokeIndex) &&
            (identical(other.strokes, strokes) || other.strokes == strokes) &&
            (identical(other.putts, putts) || other.putts == putts) &&
            (identical(other.fairwayHit, fairwayHit) ||
                other.fairwayHit == fairwayHit) &&
            (identical(other.greenInRegulation, greenInRegulation) ||
                other.greenInRegulation == greenInRegulation) &&
            (identical(other.sandSave, sandSave) ||
                other.sandSave == sandSave) &&
            (identical(other.upAndDown, upAndDown) ||
                other.upAndDown == upAndDown) &&
            (identical(other.penaltyStrokes, penaltyStrokes) ||
                other.penaltyStrokes == penaltyStrokes) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    roundId,
    holeNumber,
    par,
    strokeIndex,
    strokes,
    putts,
    fairwayHit,
    greenInRegulation,
    sandSave,
    upAndDown,
    penaltyStrokes,
    notes,
  );

  /// Create a copy of HoleScore
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HoleScoreImplCopyWith<_$HoleScoreImpl> get copyWith =>
      __$$HoleScoreImplCopyWithImpl<_$HoleScoreImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HoleScoreImplToJson(this);
  }
}

abstract class _HoleScore implements HoleScore {
  const factory _HoleScore({
    required final String id,
    required final String roundId,
    required final int holeNumber,
    required final int par,
    final int? strokeIndex,
    required final int strokes,
    final int? putts,
    final bool? fairwayHit,
    final bool? greenInRegulation,
    final bool? sandSave,
    final bool? upAndDown,
    final int penaltyStrokes,
    final String? notes,
  }) = _$HoleScoreImpl;

  factory _HoleScore.fromJson(Map<String, dynamic> json) =
      _$HoleScoreImpl.fromJson;

  @override
  String get id;
  @override
  String get roundId;
  @override
  int get holeNumber;
  @override
  int get par;
  @override
  int? get strokeIndex;
  @override
  int get strokes;
  @override
  int? get putts;
  @override
  bool? get fairwayHit;
  @override
  bool? get greenInRegulation;
  @override
  bool? get sandSave;
  @override
  bool? get upAndDown;
  @override
  int get penaltyStrokes;
  @override
  String? get notes;

  /// Create a copy of HoleScore
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HoleScoreImplCopyWith<_$HoleScoreImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
