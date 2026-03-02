// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'handicap_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

HandicapEntry _$HandicapEntryFromJson(Map<String, dynamic> json) {
  return _HandicapEntry.fromJson(json);
}

/// @nodoc
mixin _$HandicapEntry {
  String get id => throw _privateConstructorUsedError;
  String get playerId => throw _privateConstructorUsedError;
  double get handicapIndex => throw _privateConstructorUsedError;
  double? get lowHandicap => throw _privateConstructorUsedError;
  DateTime get effectiveDate => throw _privateConstructorUsedError;
  String get source =>
      throw _privateConstructorUsedError; // 'ga_connect', 'manual', 'calculated'
  int? get roundsCounted => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this HandicapEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HandicapEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HandicapEntryCopyWith<HandicapEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HandicapEntryCopyWith<$Res> {
  factory $HandicapEntryCopyWith(
    HandicapEntry value,
    $Res Function(HandicapEntry) then,
  ) = _$HandicapEntryCopyWithImpl<$Res, HandicapEntry>;
  @useResult
  $Res call({
    String id,
    String playerId,
    double handicapIndex,
    double? lowHandicap,
    DateTime effectiveDate,
    String source,
    int? roundsCounted,
    DateTime? createdAt,
  });
}

/// @nodoc
class _$HandicapEntryCopyWithImpl<$Res, $Val extends HandicapEntry>
    implements $HandicapEntryCopyWith<$Res> {
  _$HandicapEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HandicapEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? playerId = null,
    Object? handicapIndex = null,
    Object? lowHandicap = freezed,
    Object? effectiveDate = null,
    Object? source = null,
    Object? roundsCounted = freezed,
    Object? createdAt = freezed,
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
            handicapIndex: null == handicapIndex
                ? _value.handicapIndex
                : handicapIndex // ignore: cast_nullable_to_non_nullable
                      as double,
            lowHandicap: freezed == lowHandicap
                ? _value.lowHandicap
                : lowHandicap // ignore: cast_nullable_to_non_nullable
                      as double?,
            effectiveDate: null == effectiveDate
                ? _value.effectiveDate
                : effectiveDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            source: null == source
                ? _value.source
                : source // ignore: cast_nullable_to_non_nullable
                      as String,
            roundsCounted: freezed == roundsCounted
                ? _value.roundsCounted
                : roundsCounted // ignore: cast_nullable_to_non_nullable
                      as int?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HandicapEntryImplCopyWith<$Res>
    implements $HandicapEntryCopyWith<$Res> {
  factory _$$HandicapEntryImplCopyWith(
    _$HandicapEntryImpl value,
    $Res Function(_$HandicapEntryImpl) then,
  ) = __$$HandicapEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String playerId,
    double handicapIndex,
    double? lowHandicap,
    DateTime effectiveDate,
    String source,
    int? roundsCounted,
    DateTime? createdAt,
  });
}

/// @nodoc
class __$$HandicapEntryImplCopyWithImpl<$Res>
    extends _$HandicapEntryCopyWithImpl<$Res, _$HandicapEntryImpl>
    implements _$$HandicapEntryImplCopyWith<$Res> {
  __$$HandicapEntryImplCopyWithImpl(
    _$HandicapEntryImpl _value,
    $Res Function(_$HandicapEntryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HandicapEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? playerId = null,
    Object? handicapIndex = null,
    Object? lowHandicap = freezed,
    Object? effectiveDate = null,
    Object? source = null,
    Object? roundsCounted = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$HandicapEntryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        playerId: null == playerId
            ? _value.playerId
            : playerId // ignore: cast_nullable_to_non_nullable
                  as String,
        handicapIndex: null == handicapIndex
            ? _value.handicapIndex
            : handicapIndex // ignore: cast_nullable_to_non_nullable
                  as double,
        lowHandicap: freezed == lowHandicap
            ? _value.lowHandicap
            : lowHandicap // ignore: cast_nullable_to_non_nullable
                  as double?,
        effectiveDate: null == effectiveDate
            ? _value.effectiveDate
            : effectiveDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        source: null == source
            ? _value.source
            : source // ignore: cast_nullable_to_non_nullable
                  as String,
        roundsCounted: freezed == roundsCounted
            ? _value.roundsCounted
            : roundsCounted // ignore: cast_nullable_to_non_nullable
                  as int?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$HandicapEntryImpl implements _HandicapEntry {
  const _$HandicapEntryImpl({
    required this.id,
    required this.playerId,
    required this.handicapIndex,
    this.lowHandicap,
    required this.effectiveDate,
    this.source = 'manual',
    this.roundsCounted,
    this.createdAt,
  });

  factory _$HandicapEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$HandicapEntryImplFromJson(json);

  @override
  final String id;
  @override
  final String playerId;
  @override
  final double handicapIndex;
  @override
  final double? lowHandicap;
  @override
  final DateTime effectiveDate;
  @override
  @JsonKey()
  final String source;
  // 'ga_connect', 'manual', 'calculated'
  @override
  final int? roundsCounted;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'HandicapEntry(id: $id, playerId: $playerId, handicapIndex: $handicapIndex, lowHandicap: $lowHandicap, effectiveDate: $effectiveDate, source: $source, roundsCounted: $roundsCounted, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HandicapEntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId) &&
            (identical(other.handicapIndex, handicapIndex) ||
                other.handicapIndex == handicapIndex) &&
            (identical(other.lowHandicap, lowHandicap) ||
                other.lowHandicap == lowHandicap) &&
            (identical(other.effectiveDate, effectiveDate) ||
                other.effectiveDate == effectiveDate) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.roundsCounted, roundsCounted) ||
                other.roundsCounted == roundsCounted) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    playerId,
    handicapIndex,
    lowHandicap,
    effectiveDate,
    source,
    roundsCounted,
    createdAt,
  );

  /// Create a copy of HandicapEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HandicapEntryImplCopyWith<_$HandicapEntryImpl> get copyWith =>
      __$$HandicapEntryImplCopyWithImpl<_$HandicapEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HandicapEntryImplToJson(this);
  }
}

abstract class _HandicapEntry implements HandicapEntry {
  const factory _HandicapEntry({
    required final String id,
    required final String playerId,
    required final double handicapIndex,
    final double? lowHandicap,
    required final DateTime effectiveDate,
    final String source,
    final int? roundsCounted,
    final DateTime? createdAt,
  }) = _$HandicapEntryImpl;

  factory _HandicapEntry.fromJson(Map<String, dynamic> json) =
      _$HandicapEntryImpl.fromJson;

  @override
  String get id;
  @override
  String get playerId;
  @override
  double get handicapIndex;
  @override
  double? get lowHandicap;
  @override
  DateTime get effectiveDate;
  @override
  String get source; // 'ga_connect', 'manual', 'calculated'
  @override
  int? get roundsCounted;
  @override
  DateTime? get createdAt;

  /// Create a copy of HandicapEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HandicapEntryImplCopyWith<_$HandicapEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
