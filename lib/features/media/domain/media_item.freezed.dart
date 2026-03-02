// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'media_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MediaItem _$MediaItemFromJson(Map<String, dynamic> json) {
  return _MediaItem.fromJson(json);
}

/// @nodoc
mixin _$MediaItem {
  String get id => throw _privateConstructorUsedError;
  String get playerId =>
      throw _privateConstructorUsedError; // Association (one or more can be set)
  String? get tournamentId => throw _privateConstructorUsedError;
  String? get roundId => throw _privateConstructorUsedError;
  String? get holeNumber => throw _privateConstructorUsedError; // Media Info
  MediaType get mediaType => throw _privateConstructorUsedError;
  MediaCategory get category => throw _privateConstructorUsedError;
  String get storagePath => throw _privateConstructorUsedError;
  String? get thumbnailPath => throw _privateConstructorUsedError;
  String get originalFilename =>
      throw _privateConstructorUsedError; // URLs (populated after upload)
  String? get url => throw _privateConstructorUsedError;
  String? get thumbnailUrl => throw _privateConstructorUsedError; // Metadata
  String? get caption => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  List<String> get tags =>
      throw _privateConstructorUsedError; // For recruiting highlights
  bool get isHighlight => throw _privateConstructorUsedError;
  String? get highlightNotes =>
      throw _privateConstructorUsedError; // Video specific
  int? get durationSeconds => throw _privateConstructorUsedError; // File info
  int? get fileSizeBytes => throw _privateConstructorUsedError;
  int? get width => throw _privateConstructorUsedError;
  int? get height => throw _privateConstructorUsedError; // Timestamps
  DateTime? get capturedAt => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this MediaItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MediaItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MediaItemCopyWith<MediaItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MediaItemCopyWith<$Res> {
  factory $MediaItemCopyWith(MediaItem value, $Res Function(MediaItem) then) =
      _$MediaItemCopyWithImpl<$Res, MediaItem>;
  @useResult
  $Res call({
    String id,
    String playerId,
    String? tournamentId,
    String? roundId,
    String? holeNumber,
    MediaType mediaType,
    MediaCategory category,
    String storagePath,
    String? thumbnailPath,
    String originalFilename,
    String? url,
    String? thumbnailUrl,
    String? caption,
    String? description,
    List<String> tags,
    bool isHighlight,
    String? highlightNotes,
    int? durationSeconds,
    int? fileSizeBytes,
    int? width,
    int? height,
    DateTime? capturedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$MediaItemCopyWithImpl<$Res, $Val extends MediaItem>
    implements $MediaItemCopyWith<$Res> {
  _$MediaItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MediaItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? playerId = null,
    Object? tournamentId = freezed,
    Object? roundId = freezed,
    Object? holeNumber = freezed,
    Object? mediaType = null,
    Object? category = null,
    Object? storagePath = null,
    Object? thumbnailPath = freezed,
    Object? originalFilename = null,
    Object? url = freezed,
    Object? thumbnailUrl = freezed,
    Object? caption = freezed,
    Object? description = freezed,
    Object? tags = null,
    Object? isHighlight = null,
    Object? highlightNotes = freezed,
    Object? durationSeconds = freezed,
    Object? fileSizeBytes = freezed,
    Object? width = freezed,
    Object? height = freezed,
    Object? capturedAt = freezed,
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
            tournamentId: freezed == tournamentId
                ? _value.tournamentId
                : tournamentId // ignore: cast_nullable_to_non_nullable
                      as String?,
            roundId: freezed == roundId
                ? _value.roundId
                : roundId // ignore: cast_nullable_to_non_nullable
                      as String?,
            holeNumber: freezed == holeNumber
                ? _value.holeNumber
                : holeNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            mediaType: null == mediaType
                ? _value.mediaType
                : mediaType // ignore: cast_nullable_to_non_nullable
                      as MediaType,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as MediaCategory,
            storagePath: null == storagePath
                ? _value.storagePath
                : storagePath // ignore: cast_nullable_to_non_nullable
                      as String,
            thumbnailPath: freezed == thumbnailPath
                ? _value.thumbnailPath
                : thumbnailPath // ignore: cast_nullable_to_non_nullable
                      as String?,
            originalFilename: null == originalFilename
                ? _value.originalFilename
                : originalFilename // ignore: cast_nullable_to_non_nullable
                      as String,
            url: freezed == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                      as String?,
            thumbnailUrl: freezed == thumbnailUrl
                ? _value.thumbnailUrl
                : thumbnailUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            caption: freezed == caption
                ? _value.caption
                : caption // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            tags: null == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            isHighlight: null == isHighlight
                ? _value.isHighlight
                : isHighlight // ignore: cast_nullable_to_non_nullable
                      as bool,
            highlightNotes: freezed == highlightNotes
                ? _value.highlightNotes
                : highlightNotes // ignore: cast_nullable_to_non_nullable
                      as String?,
            durationSeconds: freezed == durationSeconds
                ? _value.durationSeconds
                : durationSeconds // ignore: cast_nullable_to_non_nullable
                      as int?,
            fileSizeBytes: freezed == fileSizeBytes
                ? _value.fileSizeBytes
                : fileSizeBytes // ignore: cast_nullable_to_non_nullable
                      as int?,
            width: freezed == width
                ? _value.width
                : width // ignore: cast_nullable_to_non_nullable
                      as int?,
            height: freezed == height
                ? _value.height
                : height // ignore: cast_nullable_to_non_nullable
                      as int?,
            capturedAt: freezed == capturedAt
                ? _value.capturedAt
                : capturedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
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
abstract class _$$MediaItemImplCopyWith<$Res>
    implements $MediaItemCopyWith<$Res> {
  factory _$$MediaItemImplCopyWith(
    _$MediaItemImpl value,
    $Res Function(_$MediaItemImpl) then,
  ) = __$$MediaItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String playerId,
    String? tournamentId,
    String? roundId,
    String? holeNumber,
    MediaType mediaType,
    MediaCategory category,
    String storagePath,
    String? thumbnailPath,
    String originalFilename,
    String? url,
    String? thumbnailUrl,
    String? caption,
    String? description,
    List<String> tags,
    bool isHighlight,
    String? highlightNotes,
    int? durationSeconds,
    int? fileSizeBytes,
    int? width,
    int? height,
    DateTime? capturedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$MediaItemImplCopyWithImpl<$Res>
    extends _$MediaItemCopyWithImpl<$Res, _$MediaItemImpl>
    implements _$$MediaItemImplCopyWith<$Res> {
  __$$MediaItemImplCopyWithImpl(
    _$MediaItemImpl _value,
    $Res Function(_$MediaItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MediaItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? playerId = null,
    Object? tournamentId = freezed,
    Object? roundId = freezed,
    Object? holeNumber = freezed,
    Object? mediaType = null,
    Object? category = null,
    Object? storagePath = null,
    Object? thumbnailPath = freezed,
    Object? originalFilename = null,
    Object? url = freezed,
    Object? thumbnailUrl = freezed,
    Object? caption = freezed,
    Object? description = freezed,
    Object? tags = null,
    Object? isHighlight = null,
    Object? highlightNotes = freezed,
    Object? durationSeconds = freezed,
    Object? fileSizeBytes = freezed,
    Object? width = freezed,
    Object? height = freezed,
    Object? capturedAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$MediaItemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        playerId: null == playerId
            ? _value.playerId
            : playerId // ignore: cast_nullable_to_non_nullable
                  as String,
        tournamentId: freezed == tournamentId
            ? _value.tournamentId
            : tournamentId // ignore: cast_nullable_to_non_nullable
                  as String?,
        roundId: freezed == roundId
            ? _value.roundId
            : roundId // ignore: cast_nullable_to_non_nullable
                  as String?,
        holeNumber: freezed == holeNumber
            ? _value.holeNumber
            : holeNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        mediaType: null == mediaType
            ? _value.mediaType
            : mediaType // ignore: cast_nullable_to_non_nullable
                  as MediaType,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as MediaCategory,
        storagePath: null == storagePath
            ? _value.storagePath
            : storagePath // ignore: cast_nullable_to_non_nullable
                  as String,
        thumbnailPath: freezed == thumbnailPath
            ? _value.thumbnailPath
            : thumbnailPath // ignore: cast_nullable_to_non_nullable
                  as String?,
        originalFilename: null == originalFilename
            ? _value.originalFilename
            : originalFilename // ignore: cast_nullable_to_non_nullable
                  as String,
        url: freezed == url
            ? _value.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String?,
        thumbnailUrl: freezed == thumbnailUrl
            ? _value.thumbnailUrl
            : thumbnailUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        caption: freezed == caption
            ? _value.caption
            : caption // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        tags: null == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        isHighlight: null == isHighlight
            ? _value.isHighlight
            : isHighlight // ignore: cast_nullable_to_non_nullable
                  as bool,
        highlightNotes: freezed == highlightNotes
            ? _value.highlightNotes
            : highlightNotes // ignore: cast_nullable_to_non_nullable
                  as String?,
        durationSeconds: freezed == durationSeconds
            ? _value.durationSeconds
            : durationSeconds // ignore: cast_nullable_to_non_nullable
                  as int?,
        fileSizeBytes: freezed == fileSizeBytes
            ? _value.fileSizeBytes
            : fileSizeBytes // ignore: cast_nullable_to_non_nullable
                  as int?,
        width: freezed == width
            ? _value.width
            : width // ignore: cast_nullable_to_non_nullable
                  as int?,
        height: freezed == height
            ? _value.height
            : height // ignore: cast_nullable_to_non_nullable
                  as int?,
        capturedAt: freezed == capturedAt
            ? _value.capturedAt
            : capturedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
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
class _$MediaItemImpl implements _MediaItem {
  const _$MediaItemImpl({
    required this.id,
    required this.playerId,
    this.tournamentId,
    this.roundId,
    this.holeNumber,
    required this.mediaType,
    this.category = MediaCategory.other,
    required this.storagePath,
    this.thumbnailPath,
    required this.originalFilename,
    this.url,
    this.thumbnailUrl,
    this.caption,
    this.description,
    final List<String> tags = const [],
    this.isHighlight = false,
    this.highlightNotes,
    this.durationSeconds,
    this.fileSizeBytes,
    this.width,
    this.height,
    this.capturedAt,
    this.createdAt,
    this.updatedAt,
  }) : _tags = tags;

  factory _$MediaItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$MediaItemImplFromJson(json);

  @override
  final String id;
  @override
  final String playerId;
  // Association (one or more can be set)
  @override
  final String? tournamentId;
  @override
  final String? roundId;
  @override
  final String? holeNumber;
  // Media Info
  @override
  final MediaType mediaType;
  @override
  @JsonKey()
  final MediaCategory category;
  @override
  final String storagePath;
  @override
  final String? thumbnailPath;
  @override
  final String originalFilename;
  // URLs (populated after upload)
  @override
  final String? url;
  @override
  final String? thumbnailUrl;
  // Metadata
  @override
  final String? caption;
  @override
  final String? description;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  // For recruiting highlights
  @override
  @JsonKey()
  final bool isHighlight;
  @override
  final String? highlightNotes;
  // Video specific
  @override
  final int? durationSeconds;
  // File info
  @override
  final int? fileSizeBytes;
  @override
  final int? width;
  @override
  final int? height;
  // Timestamps
  @override
  final DateTime? capturedAt;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'MediaItem(id: $id, playerId: $playerId, tournamentId: $tournamentId, roundId: $roundId, holeNumber: $holeNumber, mediaType: $mediaType, category: $category, storagePath: $storagePath, thumbnailPath: $thumbnailPath, originalFilename: $originalFilename, url: $url, thumbnailUrl: $thumbnailUrl, caption: $caption, description: $description, tags: $tags, isHighlight: $isHighlight, highlightNotes: $highlightNotes, durationSeconds: $durationSeconds, fileSizeBytes: $fileSizeBytes, width: $width, height: $height, capturedAt: $capturedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MediaItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId) &&
            (identical(other.tournamentId, tournamentId) ||
                other.tournamentId == tournamentId) &&
            (identical(other.roundId, roundId) || other.roundId == roundId) &&
            (identical(other.holeNumber, holeNumber) ||
                other.holeNumber == holeNumber) &&
            (identical(other.mediaType, mediaType) ||
                other.mediaType == mediaType) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.storagePath, storagePath) ||
                other.storagePath == storagePath) &&
            (identical(other.thumbnailPath, thumbnailPath) ||
                other.thumbnailPath == thumbnailPath) &&
            (identical(other.originalFilename, originalFilename) ||
                other.originalFilename == originalFilename) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.caption, caption) || other.caption == caption) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.isHighlight, isHighlight) ||
                other.isHighlight == isHighlight) &&
            (identical(other.highlightNotes, highlightNotes) ||
                other.highlightNotes == highlightNotes) &&
            (identical(other.durationSeconds, durationSeconds) ||
                other.durationSeconds == durationSeconds) &&
            (identical(other.fileSizeBytes, fileSizeBytes) ||
                other.fileSizeBytes == fileSizeBytes) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.capturedAt, capturedAt) ||
                other.capturedAt == capturedAt) &&
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
    tournamentId,
    roundId,
    holeNumber,
    mediaType,
    category,
    storagePath,
    thumbnailPath,
    originalFilename,
    url,
    thumbnailUrl,
    caption,
    description,
    const DeepCollectionEquality().hash(_tags),
    isHighlight,
    highlightNotes,
    durationSeconds,
    fileSizeBytes,
    width,
    height,
    capturedAt,
    createdAt,
    updatedAt,
  ]);

  /// Create a copy of MediaItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MediaItemImplCopyWith<_$MediaItemImpl> get copyWith =>
      __$$MediaItemImplCopyWithImpl<_$MediaItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MediaItemImplToJson(this);
  }
}

abstract class _MediaItem implements MediaItem {
  const factory _MediaItem({
    required final String id,
    required final String playerId,
    final String? tournamentId,
    final String? roundId,
    final String? holeNumber,
    required final MediaType mediaType,
    final MediaCategory category,
    required final String storagePath,
    final String? thumbnailPath,
    required final String originalFilename,
    final String? url,
    final String? thumbnailUrl,
    final String? caption,
    final String? description,
    final List<String> tags,
    final bool isHighlight,
    final String? highlightNotes,
    final int? durationSeconds,
    final int? fileSizeBytes,
    final int? width,
    final int? height,
    final DateTime? capturedAt,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _$MediaItemImpl;

  factory _MediaItem.fromJson(Map<String, dynamic> json) =
      _$MediaItemImpl.fromJson;

  @override
  String get id;
  @override
  String get playerId; // Association (one or more can be set)
  @override
  String? get tournamentId;
  @override
  String? get roundId;
  @override
  String? get holeNumber; // Media Info
  @override
  MediaType get mediaType;
  @override
  MediaCategory get category;
  @override
  String get storagePath;
  @override
  String? get thumbnailPath;
  @override
  String get originalFilename; // URLs (populated after upload)
  @override
  String? get url;
  @override
  String? get thumbnailUrl; // Metadata
  @override
  String? get caption;
  @override
  String? get description;
  @override
  List<String> get tags; // For recruiting highlights
  @override
  bool get isHighlight;
  @override
  String? get highlightNotes; // Video specific
  @override
  int? get durationSeconds; // File info
  @override
  int? get fileSizeBytes;
  @override
  int? get width;
  @override
  int? get height; // Timestamps
  @override
  DateTime? get capturedAt;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of MediaItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MediaItemImplCopyWith<_$MediaItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
