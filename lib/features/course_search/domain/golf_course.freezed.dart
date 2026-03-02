// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'golf_course.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

GolfCourse _$GolfCourseFromJson(Map<String, dynamic> json) {
  return _GolfCourse.fromJson(json);
}

/// @nodoc
mixin _$GolfCourse {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get state => throw _privateConstructorUsedError;
  String get country => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  int? get par => throw _privateConstructorUsedError;
  double? get slopeRating => throw _privateConstructorUsedError;
  double? get courseRating => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  String? get website => throw _privateConstructorUsedError;
  String? get placeId => throw _privateConstructorUsedError;

  /// Serializes this GolfCourse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GolfCourse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GolfCourseCopyWith<GolfCourse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GolfCourseCopyWith<$Res> {
  factory $GolfCourseCopyWith(
    GolfCourse value,
    $Res Function(GolfCourse) then,
  ) = _$GolfCourseCopyWithImpl<$Res, GolfCourse>;
  @useResult
  $Res call({
    String id,
    String name,
    String? city,
    String? state,
    String country,
    String? address,
    double? latitude,
    double? longitude,
    int? par,
    double? slopeRating,
    double? courseRating,
    String? phoneNumber,
    String? website,
    String? placeId,
  });
}

/// @nodoc
class _$GolfCourseCopyWithImpl<$Res, $Val extends GolfCourse>
    implements $GolfCourseCopyWith<$Res> {
  _$GolfCourseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GolfCourse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? city = freezed,
    Object? state = freezed,
    Object? country = null,
    Object? address = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? par = freezed,
    Object? slopeRating = freezed,
    Object? courseRating = freezed,
    Object? phoneNumber = freezed,
    Object? website = freezed,
    Object? placeId = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            city: freezed == city
                ? _value.city
                : city // ignore: cast_nullable_to_non_nullable
                      as String?,
            state: freezed == state
                ? _value.state
                : state // ignore: cast_nullable_to_non_nullable
                      as String?,
            country: null == country
                ? _value.country
                : country // ignore: cast_nullable_to_non_nullable
                      as String,
            address: freezed == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String?,
            latitude: freezed == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            longitude: freezed == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            par: freezed == par
                ? _value.par
                : par // ignore: cast_nullable_to_non_nullable
                      as int?,
            slopeRating: freezed == slopeRating
                ? _value.slopeRating
                : slopeRating // ignore: cast_nullable_to_non_nullable
                      as double?,
            courseRating: freezed == courseRating
                ? _value.courseRating
                : courseRating // ignore: cast_nullable_to_non_nullable
                      as double?,
            phoneNumber: freezed == phoneNumber
                ? _value.phoneNumber
                : phoneNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            website: freezed == website
                ? _value.website
                : website // ignore: cast_nullable_to_non_nullable
                      as String?,
            placeId: freezed == placeId
                ? _value.placeId
                : placeId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GolfCourseImplCopyWith<$Res>
    implements $GolfCourseCopyWith<$Res> {
  factory _$$GolfCourseImplCopyWith(
    _$GolfCourseImpl value,
    $Res Function(_$GolfCourseImpl) then,
  ) = __$$GolfCourseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String? city,
    String? state,
    String country,
    String? address,
    double? latitude,
    double? longitude,
    int? par,
    double? slopeRating,
    double? courseRating,
    String? phoneNumber,
    String? website,
    String? placeId,
  });
}

/// @nodoc
class __$$GolfCourseImplCopyWithImpl<$Res>
    extends _$GolfCourseCopyWithImpl<$Res, _$GolfCourseImpl>
    implements _$$GolfCourseImplCopyWith<$Res> {
  __$$GolfCourseImplCopyWithImpl(
    _$GolfCourseImpl _value,
    $Res Function(_$GolfCourseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GolfCourse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? city = freezed,
    Object? state = freezed,
    Object? country = null,
    Object? address = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? par = freezed,
    Object? slopeRating = freezed,
    Object? courseRating = freezed,
    Object? phoneNumber = freezed,
    Object? website = freezed,
    Object? placeId = freezed,
  }) {
    return _then(
      _$GolfCourseImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        city: freezed == city
            ? _value.city
            : city // ignore: cast_nullable_to_non_nullable
                  as String?,
        state: freezed == state
            ? _value.state
            : state // ignore: cast_nullable_to_non_nullable
                  as String?,
        country: null == country
            ? _value.country
            : country // ignore: cast_nullable_to_non_nullable
                  as String,
        address: freezed == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String?,
        latitude: freezed == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        longitude: freezed == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        par: freezed == par
            ? _value.par
            : par // ignore: cast_nullable_to_non_nullable
                  as int?,
        slopeRating: freezed == slopeRating
            ? _value.slopeRating
            : slopeRating // ignore: cast_nullable_to_non_nullable
                  as double?,
        courseRating: freezed == courseRating
            ? _value.courseRating
            : courseRating // ignore: cast_nullable_to_non_nullable
                  as double?,
        phoneNumber: freezed == phoneNumber
            ? _value.phoneNumber
            : phoneNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        website: freezed == website
            ? _value.website
            : website // ignore: cast_nullable_to_non_nullable
                  as String?,
        placeId: freezed == placeId
            ? _value.placeId
            : placeId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GolfCourseImpl implements _GolfCourse {
  const _$GolfCourseImpl({
    required this.id,
    required this.name,
    this.city,
    this.state,
    this.country = 'Australia',
    this.address,
    this.latitude,
    this.longitude,
    this.par,
    this.slopeRating,
    this.courseRating,
    this.phoneNumber,
    this.website,
    this.placeId,
  });

  factory _$GolfCourseImpl.fromJson(Map<String, dynamic> json) =>
      _$$GolfCourseImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? city;
  @override
  final String? state;
  @override
  @JsonKey()
  final String country;
  @override
  final String? address;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  final int? par;
  @override
  final double? slopeRating;
  @override
  final double? courseRating;
  @override
  final String? phoneNumber;
  @override
  final String? website;
  @override
  final String? placeId;

  @override
  String toString() {
    return 'GolfCourse(id: $id, name: $name, city: $city, state: $state, country: $country, address: $address, latitude: $latitude, longitude: $longitude, par: $par, slopeRating: $slopeRating, courseRating: $courseRating, phoneNumber: $phoneNumber, website: $website, placeId: $placeId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GolfCourseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.par, par) || other.par == par) &&
            (identical(other.slopeRating, slopeRating) ||
                other.slopeRating == slopeRating) &&
            (identical(other.courseRating, courseRating) ||
                other.courseRating == courseRating) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.website, website) || other.website == website) &&
            (identical(other.placeId, placeId) || other.placeId == placeId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    city,
    state,
    country,
    address,
    latitude,
    longitude,
    par,
    slopeRating,
    courseRating,
    phoneNumber,
    website,
    placeId,
  );

  /// Create a copy of GolfCourse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GolfCourseImplCopyWith<_$GolfCourseImpl> get copyWith =>
      __$$GolfCourseImplCopyWithImpl<_$GolfCourseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GolfCourseImplToJson(this);
  }
}

abstract class _GolfCourse implements GolfCourse {
  const factory _GolfCourse({
    required final String id,
    required final String name,
    final String? city,
    final String? state,
    final String country,
    final String? address,
    final double? latitude,
    final double? longitude,
    final int? par,
    final double? slopeRating,
    final double? courseRating,
    final String? phoneNumber,
    final String? website,
    final String? placeId,
  }) = _$GolfCourseImpl;

  factory _GolfCourse.fromJson(Map<String, dynamic> json) =
      _$GolfCourseImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get city;
  @override
  String? get state;
  @override
  String get country;
  @override
  String? get address;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  int? get par;
  @override
  double? get slopeRating;
  @override
  double? get courseRating;
  @override
  String? get phoneNumber;
  @override
  String? get website;
  @override
  String? get placeId;

  /// Create a copy of GolfCourse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GolfCourseImplCopyWith<_$GolfCourseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
