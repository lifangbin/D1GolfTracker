// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'milestone.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MilestoneDefinition _$MilestoneDefinitionFromJson(Map<String, dynamic> json) {
  return _MilestoneDefinition.fromJson(json);
}

/// @nodoc
mixin _$MilestoneDefinition {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int get phase => throw _privateConstructorUsedError;
  MilestoneCategory get category => throw _privateConstructorUsedError;
  int get sortOrder => throw _privateConstructorUsedError;
  String? get targetValue => throw _privateConstructorUsedError;
  String? get unit => throw _privateConstructorUsedError;

  /// Serializes this MilestoneDefinition to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MilestoneDefinition
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MilestoneDefinitionCopyWith<MilestoneDefinition> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MilestoneDefinitionCopyWith<$Res> {
  factory $MilestoneDefinitionCopyWith(
    MilestoneDefinition value,
    $Res Function(MilestoneDefinition) then,
  ) = _$MilestoneDefinitionCopyWithImpl<$Res, MilestoneDefinition>;
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    int phase,
    MilestoneCategory category,
    int sortOrder,
    String? targetValue,
    String? unit,
  });
}

/// @nodoc
class _$MilestoneDefinitionCopyWithImpl<$Res, $Val extends MilestoneDefinition>
    implements $MilestoneDefinitionCopyWith<$Res> {
  _$MilestoneDefinitionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MilestoneDefinition
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? phase = null,
    Object? category = null,
    Object? sortOrder = null,
    Object? targetValue = freezed,
    Object? unit = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            phase: null == phase
                ? _value.phase
                : phase // ignore: cast_nullable_to_non_nullable
                      as int,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as MilestoneCategory,
            sortOrder: null == sortOrder
                ? _value.sortOrder
                : sortOrder // ignore: cast_nullable_to_non_nullable
                      as int,
            targetValue: freezed == targetValue
                ? _value.targetValue
                : targetValue // ignore: cast_nullable_to_non_nullable
                      as String?,
            unit: freezed == unit
                ? _value.unit
                : unit // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MilestoneDefinitionImplCopyWith<$Res>
    implements $MilestoneDefinitionCopyWith<$Res> {
  factory _$$MilestoneDefinitionImplCopyWith(
    _$MilestoneDefinitionImpl value,
    $Res Function(_$MilestoneDefinitionImpl) then,
  ) = __$$MilestoneDefinitionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    int phase,
    MilestoneCategory category,
    int sortOrder,
    String? targetValue,
    String? unit,
  });
}

/// @nodoc
class __$$MilestoneDefinitionImplCopyWithImpl<$Res>
    extends _$MilestoneDefinitionCopyWithImpl<$Res, _$MilestoneDefinitionImpl>
    implements _$$MilestoneDefinitionImplCopyWith<$Res> {
  __$$MilestoneDefinitionImplCopyWithImpl(
    _$MilestoneDefinitionImpl _value,
    $Res Function(_$MilestoneDefinitionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MilestoneDefinition
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? phase = null,
    Object? category = null,
    Object? sortOrder = null,
    Object? targetValue = freezed,
    Object? unit = freezed,
  }) {
    return _then(
      _$MilestoneDefinitionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        phase: null == phase
            ? _value.phase
            : phase // ignore: cast_nullable_to_non_nullable
                  as int,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as MilestoneCategory,
        sortOrder: null == sortOrder
            ? _value.sortOrder
            : sortOrder // ignore: cast_nullable_to_non_nullable
                  as int,
        targetValue: freezed == targetValue
            ? _value.targetValue
            : targetValue // ignore: cast_nullable_to_non_nullable
                  as String?,
        unit: freezed == unit
            ? _value.unit
            : unit // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MilestoneDefinitionImpl implements _MilestoneDefinition {
  const _$MilestoneDefinitionImpl({
    required this.id,
    required this.title,
    required this.description,
    required this.phase,
    required this.category,
    required this.sortOrder,
    this.targetValue,
    this.unit,
  });

  factory _$MilestoneDefinitionImpl.fromJson(Map<String, dynamic> json) =>
      _$$MilestoneDefinitionImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final int phase;
  @override
  final MilestoneCategory category;
  @override
  final int sortOrder;
  @override
  final String? targetValue;
  @override
  final String? unit;

  @override
  String toString() {
    return 'MilestoneDefinition(id: $id, title: $title, description: $description, phase: $phase, category: $category, sortOrder: $sortOrder, targetValue: $targetValue, unit: $unit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MilestoneDefinitionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.phase, phase) || other.phase == phase) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.targetValue, targetValue) ||
                other.targetValue == targetValue) &&
            (identical(other.unit, unit) || other.unit == unit));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    description,
    phase,
    category,
    sortOrder,
    targetValue,
    unit,
  );

  /// Create a copy of MilestoneDefinition
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MilestoneDefinitionImplCopyWith<_$MilestoneDefinitionImpl> get copyWith =>
      __$$MilestoneDefinitionImplCopyWithImpl<_$MilestoneDefinitionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MilestoneDefinitionImplToJson(this);
  }
}

abstract class _MilestoneDefinition implements MilestoneDefinition {
  const factory _MilestoneDefinition({
    required final String id,
    required final String title,
    required final String description,
    required final int phase,
    required final MilestoneCategory category,
    required final int sortOrder,
    final String? targetValue,
    final String? unit,
  }) = _$MilestoneDefinitionImpl;

  factory _MilestoneDefinition.fromJson(Map<String, dynamic> json) =
      _$MilestoneDefinitionImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  int get phase;
  @override
  MilestoneCategory get category;
  @override
  int get sortOrder;
  @override
  String? get targetValue;
  @override
  String? get unit;

  /// Create a copy of MilestoneDefinition
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MilestoneDefinitionImplCopyWith<_$MilestoneDefinitionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PlayerMilestone _$PlayerMilestoneFromJson(Map<String, dynamic> json) {
  return _PlayerMilestone.fromJson(json);
}

/// @nodoc
mixin _$PlayerMilestone {
  String get id => throw _privateConstructorUsedError;
  String get playerId => throw _privateConstructorUsedError;
  String get milestoneId => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  String? get mediaUrl => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this PlayerMilestone to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlayerMilestone
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlayerMilestoneCopyWith<PlayerMilestone> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerMilestoneCopyWith<$Res> {
  factory $PlayerMilestoneCopyWith(
    PlayerMilestone value,
    $Res Function(PlayerMilestone) then,
  ) = _$PlayerMilestoneCopyWithImpl<$Res, PlayerMilestone>;
  @useResult
  $Res call({
    String id,
    String playerId,
    String milestoneId,
    bool isCompleted,
    DateTime? completedAt,
    String? notes,
    String? mediaUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$PlayerMilestoneCopyWithImpl<$Res, $Val extends PlayerMilestone>
    implements $PlayerMilestoneCopyWith<$Res> {
  _$PlayerMilestoneCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlayerMilestone
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? playerId = null,
    Object? milestoneId = null,
    Object? isCompleted = null,
    Object? completedAt = freezed,
    Object? notes = freezed,
    Object? mediaUrl = freezed,
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
            milestoneId: null == milestoneId
                ? _value.milestoneId
                : milestoneId // ignore: cast_nullable_to_non_nullable
                      as String,
            isCompleted: null == isCompleted
                ? _value.isCompleted
                : isCompleted // ignore: cast_nullable_to_non_nullable
                      as bool,
            completedAt: freezed == completedAt
                ? _value.completedAt
                : completedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
            mediaUrl: freezed == mediaUrl
                ? _value.mediaUrl
                : mediaUrl // ignore: cast_nullable_to_non_nullable
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
abstract class _$$PlayerMilestoneImplCopyWith<$Res>
    implements $PlayerMilestoneCopyWith<$Res> {
  factory _$$PlayerMilestoneImplCopyWith(
    _$PlayerMilestoneImpl value,
    $Res Function(_$PlayerMilestoneImpl) then,
  ) = __$$PlayerMilestoneImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String playerId,
    String milestoneId,
    bool isCompleted,
    DateTime? completedAt,
    String? notes,
    String? mediaUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$PlayerMilestoneImplCopyWithImpl<$Res>
    extends _$PlayerMilestoneCopyWithImpl<$Res, _$PlayerMilestoneImpl>
    implements _$$PlayerMilestoneImplCopyWith<$Res> {
  __$$PlayerMilestoneImplCopyWithImpl(
    _$PlayerMilestoneImpl _value,
    $Res Function(_$PlayerMilestoneImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PlayerMilestone
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? playerId = null,
    Object? milestoneId = null,
    Object? isCompleted = null,
    Object? completedAt = freezed,
    Object? notes = freezed,
    Object? mediaUrl = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$PlayerMilestoneImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        playerId: null == playerId
            ? _value.playerId
            : playerId // ignore: cast_nullable_to_non_nullable
                  as String,
        milestoneId: null == milestoneId
            ? _value.milestoneId
            : milestoneId // ignore: cast_nullable_to_non_nullable
                  as String,
        isCompleted: null == isCompleted
            ? _value.isCompleted
            : isCompleted // ignore: cast_nullable_to_non_nullable
                  as bool,
        completedAt: freezed == completedAt
            ? _value.completedAt
            : completedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
        mediaUrl: freezed == mediaUrl
            ? _value.mediaUrl
            : mediaUrl // ignore: cast_nullable_to_non_nullable
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
class _$PlayerMilestoneImpl implements _PlayerMilestone {
  const _$PlayerMilestoneImpl({
    required this.id,
    required this.playerId,
    required this.milestoneId,
    this.isCompleted = false,
    this.completedAt,
    this.notes,
    this.mediaUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory _$PlayerMilestoneImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlayerMilestoneImplFromJson(json);

  @override
  final String id;
  @override
  final String playerId;
  @override
  final String milestoneId;
  @override
  @JsonKey()
  final bool isCompleted;
  @override
  final DateTime? completedAt;
  @override
  final String? notes;
  @override
  final String? mediaUrl;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'PlayerMilestone(id: $id, playerId: $playerId, milestoneId: $milestoneId, isCompleted: $isCompleted, completedAt: $completedAt, notes: $notes, mediaUrl: $mediaUrl, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerMilestoneImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId) &&
            (identical(other.milestoneId, milestoneId) ||
                other.milestoneId == milestoneId) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.mediaUrl, mediaUrl) ||
                other.mediaUrl == mediaUrl) &&
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
    milestoneId,
    isCompleted,
    completedAt,
    notes,
    mediaUrl,
    createdAt,
    updatedAt,
  );

  /// Create a copy of PlayerMilestone
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerMilestoneImplCopyWith<_$PlayerMilestoneImpl> get copyWith =>
      __$$PlayerMilestoneImplCopyWithImpl<_$PlayerMilestoneImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PlayerMilestoneImplToJson(this);
  }
}

abstract class _PlayerMilestone implements PlayerMilestone {
  const factory _PlayerMilestone({
    required final String id,
    required final String playerId,
    required final String milestoneId,
    final bool isCompleted,
    final DateTime? completedAt,
    final String? notes,
    final String? mediaUrl,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _$PlayerMilestoneImpl;

  factory _PlayerMilestone.fromJson(Map<String, dynamic> json) =
      _$PlayerMilestoneImpl.fromJson;

  @override
  String get id;
  @override
  String get playerId;
  @override
  String get milestoneId;
  @override
  bool get isCompleted;
  @override
  DateTime? get completedAt;
  @override
  String? get notes;
  @override
  String? get mediaUrl;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of PlayerMilestone
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlayerMilestoneImplCopyWith<_$PlayerMilestoneImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MilestoneWithProgress {
  MilestoneDefinition get definition => throw _privateConstructorUsedError;
  PlayerMilestone? get progress => throw _privateConstructorUsedError;

  /// Create a copy of MilestoneWithProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MilestoneWithProgressCopyWith<MilestoneWithProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MilestoneWithProgressCopyWith<$Res> {
  factory $MilestoneWithProgressCopyWith(
    MilestoneWithProgress value,
    $Res Function(MilestoneWithProgress) then,
  ) = _$MilestoneWithProgressCopyWithImpl<$Res, MilestoneWithProgress>;
  @useResult
  $Res call({MilestoneDefinition definition, PlayerMilestone? progress});

  $MilestoneDefinitionCopyWith<$Res> get definition;
  $PlayerMilestoneCopyWith<$Res>? get progress;
}

/// @nodoc
class _$MilestoneWithProgressCopyWithImpl<
  $Res,
  $Val extends MilestoneWithProgress
>
    implements $MilestoneWithProgressCopyWith<$Res> {
  _$MilestoneWithProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MilestoneWithProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? definition = null, Object? progress = freezed}) {
    return _then(
      _value.copyWith(
            definition: null == definition
                ? _value.definition
                : definition // ignore: cast_nullable_to_non_nullable
                      as MilestoneDefinition,
            progress: freezed == progress
                ? _value.progress
                : progress // ignore: cast_nullable_to_non_nullable
                      as PlayerMilestone?,
          )
          as $Val,
    );
  }

  /// Create a copy of MilestoneWithProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MilestoneDefinitionCopyWith<$Res> get definition {
    return $MilestoneDefinitionCopyWith<$Res>(_value.definition, (value) {
      return _then(_value.copyWith(definition: value) as $Val);
    });
  }

  /// Create a copy of MilestoneWithProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PlayerMilestoneCopyWith<$Res>? get progress {
    if (_value.progress == null) {
      return null;
    }

    return $PlayerMilestoneCopyWith<$Res>(_value.progress!, (value) {
      return _then(_value.copyWith(progress: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MilestoneWithProgressImplCopyWith<$Res>
    implements $MilestoneWithProgressCopyWith<$Res> {
  factory _$$MilestoneWithProgressImplCopyWith(
    _$MilestoneWithProgressImpl value,
    $Res Function(_$MilestoneWithProgressImpl) then,
  ) = __$$MilestoneWithProgressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({MilestoneDefinition definition, PlayerMilestone? progress});

  @override
  $MilestoneDefinitionCopyWith<$Res> get definition;
  @override
  $PlayerMilestoneCopyWith<$Res>? get progress;
}

/// @nodoc
class __$$MilestoneWithProgressImplCopyWithImpl<$Res>
    extends
        _$MilestoneWithProgressCopyWithImpl<$Res, _$MilestoneWithProgressImpl>
    implements _$$MilestoneWithProgressImplCopyWith<$Res> {
  __$$MilestoneWithProgressImplCopyWithImpl(
    _$MilestoneWithProgressImpl _value,
    $Res Function(_$MilestoneWithProgressImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MilestoneWithProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? definition = null, Object? progress = freezed}) {
    return _then(
      _$MilestoneWithProgressImpl(
        definition: null == definition
            ? _value.definition
            : definition // ignore: cast_nullable_to_non_nullable
                  as MilestoneDefinition,
        progress: freezed == progress
            ? _value.progress
            : progress // ignore: cast_nullable_to_non_nullable
                  as PlayerMilestone?,
      ),
    );
  }
}

/// @nodoc

class _$MilestoneWithProgressImpl extends _MilestoneWithProgress {
  const _$MilestoneWithProgressImpl({required this.definition, this.progress})
    : super._();

  @override
  final MilestoneDefinition definition;
  @override
  final PlayerMilestone? progress;

  @override
  String toString() {
    return 'MilestoneWithProgress(definition: $definition, progress: $progress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MilestoneWithProgressImpl &&
            (identical(other.definition, definition) ||
                other.definition == definition) &&
            (identical(other.progress, progress) ||
                other.progress == progress));
  }

  @override
  int get hashCode => Object.hash(runtimeType, definition, progress);

  /// Create a copy of MilestoneWithProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MilestoneWithProgressImplCopyWith<_$MilestoneWithProgressImpl>
  get copyWith =>
      __$$MilestoneWithProgressImplCopyWithImpl<_$MilestoneWithProgressImpl>(
        this,
        _$identity,
      );
}

abstract class _MilestoneWithProgress extends MilestoneWithProgress {
  const factory _MilestoneWithProgress({
    required final MilestoneDefinition definition,
    final PlayerMilestone? progress,
  }) = _$MilestoneWithProgressImpl;
  const _MilestoneWithProgress._() : super._();

  @override
  MilestoneDefinition get definition;
  @override
  PlayerMilestone? get progress;

  /// Create a copy of MilestoneWithProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MilestoneWithProgressImplCopyWith<_$MilestoneWithProgressImpl>
  get copyWith => throw _privateConstructorUsedError;
}
