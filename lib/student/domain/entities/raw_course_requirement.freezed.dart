// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'raw_course_requirement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RawCourseRequirement {
  String get courseCode => throw _privateConstructorUsedError;
  String get requiredCourseCode => throw _privateConstructorUsedError;
  String get requiredCourseDescription => throw _privateConstructorUsedError;
  String get score => throw _privateConstructorUsedError;
  String get semesterId => throw _privateConstructorUsedError;

  /// Create a copy of RawCourseRequirement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RawCourseRequirementCopyWith<RawCourseRequirement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RawCourseRequirementCopyWith<$Res> {
  factory $RawCourseRequirementCopyWith(RawCourseRequirement value,
          $Res Function(RawCourseRequirement) then) =
      _$RawCourseRequirementCopyWithImpl<$Res, RawCourseRequirement>;
  @useResult
  $Res call(
      {String courseCode,
      String requiredCourseCode,
      String requiredCourseDescription,
      String score,
      String semesterId});
}

/// @nodoc
class _$RawCourseRequirementCopyWithImpl<$Res,
        $Val extends RawCourseRequirement>
    implements $RawCourseRequirementCopyWith<$Res> {
  _$RawCourseRequirementCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RawCourseRequirement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? courseCode = null,
    Object? requiredCourseCode = null,
    Object? requiredCourseDescription = null,
    Object? score = null,
    Object? semesterId = null,
  }) {
    return _then(_value.copyWith(
      courseCode: null == courseCode
          ? _value.courseCode
          : courseCode // ignore: cast_nullable_to_non_nullable
              as String,
      requiredCourseCode: null == requiredCourseCode
          ? _value.requiredCourseCode
          : requiredCourseCode // ignore: cast_nullable_to_non_nullable
              as String,
      requiredCourseDescription: null == requiredCourseDescription
          ? _value.requiredCourseDescription
          : requiredCourseDescription // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as String,
      semesterId: null == semesterId
          ? _value.semesterId
          : semesterId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RawCourseRequirementImplCopyWith<$Res>
    implements $RawCourseRequirementCopyWith<$Res> {
  factory _$$RawCourseRequirementImplCopyWith(_$RawCourseRequirementImpl value,
          $Res Function(_$RawCourseRequirementImpl) then) =
      __$$RawCourseRequirementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String courseCode,
      String requiredCourseCode,
      String requiredCourseDescription,
      String score,
      String semesterId});
}

/// @nodoc
class __$$RawCourseRequirementImplCopyWithImpl<$Res>
    extends _$RawCourseRequirementCopyWithImpl<$Res, _$RawCourseRequirementImpl>
    implements _$$RawCourseRequirementImplCopyWith<$Res> {
  __$$RawCourseRequirementImplCopyWithImpl(_$RawCourseRequirementImpl _value,
      $Res Function(_$RawCourseRequirementImpl) _then)
      : super(_value, _then);

  /// Create a copy of RawCourseRequirement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? courseCode = null,
    Object? requiredCourseCode = null,
    Object? requiredCourseDescription = null,
    Object? score = null,
    Object? semesterId = null,
  }) {
    return _then(_$RawCourseRequirementImpl(
      courseCode: null == courseCode
          ? _value.courseCode
          : courseCode // ignore: cast_nullable_to_non_nullable
              as String,
      requiredCourseCode: null == requiredCourseCode
          ? _value.requiredCourseCode
          : requiredCourseCode // ignore: cast_nullable_to_non_nullable
              as String,
      requiredCourseDescription: null == requiredCourseDescription
          ? _value.requiredCourseDescription
          : requiredCourseDescription // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as String,
      semesterId: null == semesterId
          ? _value.semesterId
          : semesterId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RawCourseRequirementImpl
    with DiagnosticableTreeMixin
    implements _RawCourseRequirement {
  const _$RawCourseRequirementImpl(
      {required this.courseCode,
      required this.requiredCourseCode,
      required this.requiredCourseDescription,
      required this.score,
      required this.semesterId});

  @override
  final String courseCode;
  @override
  final String requiredCourseCode;
  @override
  final String requiredCourseDescription;
  @override
  final String score;
  @override
  final String semesterId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RawCourseRequirement(courseCode: $courseCode, requiredCourseCode: $requiredCourseCode, requiredCourseDescription: $requiredCourseDescription, score: $score, semesterId: $semesterId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RawCourseRequirement'))
      ..add(DiagnosticsProperty('courseCode', courseCode))
      ..add(DiagnosticsProperty('requiredCourseCode', requiredCourseCode))
      ..add(DiagnosticsProperty(
          'requiredCourseDescription', requiredCourseDescription))
      ..add(DiagnosticsProperty('score', score))
      ..add(DiagnosticsProperty('semesterId', semesterId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RawCourseRequirementImpl &&
            (identical(other.courseCode, courseCode) ||
                other.courseCode == courseCode) &&
            (identical(other.requiredCourseCode, requiredCourseCode) ||
                other.requiredCourseCode == requiredCourseCode) &&
            (identical(other.requiredCourseDescription,
                    requiredCourseDescription) ||
                other.requiredCourseDescription == requiredCourseDescription) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.semesterId, semesterId) ||
                other.semesterId == semesterId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, courseCode, requiredCourseCode,
      requiredCourseDescription, score, semesterId);

  /// Create a copy of RawCourseRequirement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RawCourseRequirementImplCopyWith<_$RawCourseRequirementImpl>
      get copyWith =>
          __$$RawCourseRequirementImplCopyWithImpl<_$RawCourseRequirementImpl>(
              this, _$identity);
}

abstract class _RawCourseRequirement implements RawCourseRequirement {
  const factory _RawCourseRequirement(
      {required final String courseCode,
      required final String requiredCourseCode,
      required final String requiredCourseDescription,
      required final String score,
      required final String semesterId}) = _$RawCourseRequirementImpl;

  @override
  String get courseCode;
  @override
  String get requiredCourseCode;
  @override
  String get requiredCourseDescription;
  @override
  String get score;
  @override
  String get semesterId;

  /// Create a copy of RawCourseRequirement
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RawCourseRequirementImplCopyWith<_$RawCourseRequirementImpl>
      get copyWith => throw _privateConstructorUsedError;
}
