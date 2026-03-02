// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Player _$PlayerFromJson(Map<String, dynamic> json) {
  return _Player.fromJson(json);
}

/// @nodoc
mixin _$Player {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  DateTime get dateOfBirth => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  String? get avatarUrl =>
      throw _privateConstructorUsedError; // Golf Australia Integration
  String? get gaNumber => throw _privateConstructorUsedError;
  bool get gaConnected => throw _privateConstructorUsedError;
  DateTime? get gaLastSync =>
      throw _privateConstructorUsedError; // Current Stats
  double? get currentHandicap => throw _privateConstructorUsedError;
  int get currentPhase => throw _privateConstructorUsedError;
  String? get homeCourse => throw _privateConstructorUsedError; // Timestamps
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Player to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Player
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlayerCopyWith<Player> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerCopyWith<$Res> {
  factory $PlayerCopyWith(Player value, $Res Function(Player) then) =
      _$PlayerCopyWithImpl<$Res, Player>;
  @useResult
  $Res call({
    String id,
    String userId,
    String firstName,
    String lastName,
    DateTime dateOfBirth,
    String? gender,
    String? avatarUrl,
    String? gaNumber,
    bool gaConnected,
    DateTime? gaLastSync,
    double? currentHandicap,
    int currentPhase,
    String? homeCourse,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$PlayerCopyWithImpl<$Res, $Val extends Player>
    implements $PlayerCopyWith<$Res> {
  _$PlayerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Player
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? dateOfBirth = null,
    Object? gender = freezed,
    Object? avatarUrl = freezed,
    Object? gaNumber = freezed,
    Object? gaConnected = null,
    Object? gaLastSync = freezed,
    Object? currentHandicap = freezed,
    Object? currentPhase = null,
    Object? homeCourse = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            firstName: null == firstName
                ? _value.firstName
                : firstName // ignore: cast_nullable_to_non_nullable
                      as String,
            lastName: null == lastName
                ? _value.lastName
                : lastName // ignore: cast_nullable_to_non_nullable
                      as String,
            dateOfBirth: null == dateOfBirth
                ? _value.dateOfBirth
                : dateOfBirth // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            gender: freezed == gender
                ? _value.gender
                : gender // ignore: cast_nullable_to_non_nullable
                      as String?,
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            gaNumber: freezed == gaNumber
                ? _value.gaNumber
                : gaNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            gaConnected: null == gaConnected
                ? _value.gaConnected
                : gaConnected // ignore: cast_nullable_to_non_nullable
                      as bool,
            gaLastSync: freezed == gaLastSync
                ? _value.gaLastSync
                : gaLastSync // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            currentHandicap: freezed == currentHandicap
                ? _value.currentHandicap
                : currentHandicap // ignore: cast_nullable_to_non_nullable
                      as double?,
            currentPhase: null == currentPhase
                ? _value.currentPhase
                : currentPhase // ignore: cast_nullable_to_non_nullable
                      as int,
            homeCourse: freezed == homeCourse
                ? _value.homeCourse
                : homeCourse // ignore: cast_nullable_to_non_nullable
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
abstract class _$$PlayerImplCopyWith<$Res> implements $PlayerCopyWith<$Res> {
  factory _$$PlayerImplCopyWith(
    _$PlayerImpl value,
    $Res Function(_$PlayerImpl) then,
  ) = __$$PlayerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    String firstName,
    String lastName,
    DateTime dateOfBirth,
    String? gender,
    String? avatarUrl,
    String? gaNumber,
    bool gaConnected,
    DateTime? gaLastSync,
    double? currentHandicap,
    int currentPhase,
    String? homeCourse,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$PlayerImplCopyWithImpl<$Res>
    extends _$PlayerCopyWithImpl<$Res, _$PlayerImpl>
    implements _$$PlayerImplCopyWith<$Res> {
  __$$PlayerImplCopyWithImpl(
    _$PlayerImpl _value,
    $Res Function(_$PlayerImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Player
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? dateOfBirth = null,
    Object? gender = freezed,
    Object? avatarUrl = freezed,
    Object? gaNumber = freezed,
    Object? gaConnected = null,
    Object? gaLastSync = freezed,
    Object? currentHandicap = freezed,
    Object? currentPhase = null,
    Object? homeCourse = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$PlayerImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        firstName: null == firstName
            ? _value.firstName
            : firstName // ignore: cast_nullable_to_non_nullable
                  as String,
        lastName: null == lastName
            ? _value.lastName
            : lastName // ignore: cast_nullable_to_non_nullable
                  as String,
        dateOfBirth: null == dateOfBirth
            ? _value.dateOfBirth
            : dateOfBirth // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        gender: freezed == gender
            ? _value.gender
            : gender // ignore: cast_nullable_to_non_nullable
                  as String?,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        gaNumber: freezed == gaNumber
            ? _value.gaNumber
            : gaNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        gaConnected: null == gaConnected
            ? _value.gaConnected
            : gaConnected // ignore: cast_nullable_to_non_nullable
                  as bool,
        gaLastSync: freezed == gaLastSync
            ? _value.gaLastSync
            : gaLastSync // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        currentHandicap: freezed == currentHandicap
            ? _value.currentHandicap
            : currentHandicap // ignore: cast_nullable_to_non_nullable
                  as double?,
        currentPhase: null == currentPhase
            ? _value.currentPhase
            : currentPhase // ignore: cast_nullable_to_non_nullable
                  as int,
        homeCourse: freezed == homeCourse
            ? _value.homeCourse
            : homeCourse // ignore: cast_nullable_to_non_nullable
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
class _$PlayerImpl implements _Player {
  const _$PlayerImpl({
    required this.id,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    this.gender,
    this.avatarUrl,
    this.gaNumber,
    this.gaConnected = false,
    this.gaLastSync,
    this.currentHandicap,
    this.currentPhase = 1,
    this.homeCourse,
    this.createdAt,
    this.updatedAt,
  });

  factory _$PlayerImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlayerImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final DateTime dateOfBirth;
  @override
  final String? gender;
  @override
  final String? avatarUrl;
  // Golf Australia Integration
  @override
  final String? gaNumber;
  @override
  @JsonKey()
  final bool gaConnected;
  @override
  final DateTime? gaLastSync;
  // Current Stats
  @override
  final double? currentHandicap;
  @override
  @JsonKey()
  final int currentPhase;
  @override
  final String? homeCourse;
  // Timestamps
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Player(id: $id, userId: $userId, firstName: $firstName, lastName: $lastName, dateOfBirth: $dateOfBirth, gender: $gender, avatarUrl: $avatarUrl, gaNumber: $gaNumber, gaConnected: $gaConnected, gaLastSync: $gaLastSync, currentHandicap: $currentHandicap, currentPhase: $currentPhase, homeCourse: $homeCourse, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.dateOfBirth, dateOfBirth) ||
                other.dateOfBirth == dateOfBirth) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.gaNumber, gaNumber) ||
                other.gaNumber == gaNumber) &&
            (identical(other.gaConnected, gaConnected) ||
                other.gaConnected == gaConnected) &&
            (identical(other.gaLastSync, gaLastSync) ||
                other.gaLastSync == gaLastSync) &&
            (identical(other.currentHandicap, currentHandicap) ||
                other.currentHandicap == currentHandicap) &&
            (identical(other.currentPhase, currentPhase) ||
                other.currentPhase == currentPhase) &&
            (identical(other.homeCourse, homeCourse) ||
                other.homeCourse == homeCourse) &&
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
    userId,
    firstName,
    lastName,
    dateOfBirth,
    gender,
    avatarUrl,
    gaNumber,
    gaConnected,
    gaLastSync,
    currentHandicap,
    currentPhase,
    homeCourse,
    createdAt,
    updatedAt,
  );

  /// Create a copy of Player
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerImplCopyWith<_$PlayerImpl> get copyWith =>
      __$$PlayerImplCopyWithImpl<_$PlayerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlayerImplToJson(this);
  }
}

abstract class _Player implements Player {
  const factory _Player({
    required final String id,
    required final String userId,
    required final String firstName,
    required final String lastName,
    required final DateTime dateOfBirth,
    final String? gender,
    final String? avatarUrl,
    final String? gaNumber,
    final bool gaConnected,
    final DateTime? gaLastSync,
    final double? currentHandicap,
    final int currentPhase,
    final String? homeCourse,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _$PlayerImpl;

  factory _Player.fromJson(Map<String, dynamic> json) = _$PlayerImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  DateTime get dateOfBirth;
  @override
  String? get gender;
  @override
  String? get avatarUrl; // Golf Australia Integration
  @override
  String? get gaNumber;
  @override
  bool get gaConnected;
  @override
  DateTime? get gaLastSync; // Current Stats
  @override
  double? get currentHandicap;
  @override
  int get currentPhase;
  @override
  String? get homeCourse; // Timestamps
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of Player
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlayerImplCopyWith<_$PlayerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
