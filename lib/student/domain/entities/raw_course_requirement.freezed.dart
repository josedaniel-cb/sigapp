// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'raw_course_requirement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RawCourseRequirement implements DiagnosticableTreeMixin {

 String get courseCode; String get requiredCourseCode; String get requiredCourseDescription; String get score; String get semesterId;
/// Create a copy of RawCourseRequirement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RawCourseRequirementCopyWith<RawCourseRequirement> get copyWith => _$RawCourseRequirementCopyWithImpl<RawCourseRequirement>(this as RawCourseRequirement, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'RawCourseRequirement'))
    ..add(DiagnosticsProperty('courseCode', courseCode))..add(DiagnosticsProperty('requiredCourseCode', requiredCourseCode))..add(DiagnosticsProperty('requiredCourseDescription', requiredCourseDescription))..add(DiagnosticsProperty('score', score))..add(DiagnosticsProperty('semesterId', semesterId));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RawCourseRequirement&&(identical(other.courseCode, courseCode) || other.courseCode == courseCode)&&(identical(other.requiredCourseCode, requiredCourseCode) || other.requiredCourseCode == requiredCourseCode)&&(identical(other.requiredCourseDescription, requiredCourseDescription) || other.requiredCourseDescription == requiredCourseDescription)&&(identical(other.score, score) || other.score == score)&&(identical(other.semesterId, semesterId) || other.semesterId == semesterId));
}


@override
int get hashCode => Object.hash(runtimeType,courseCode,requiredCourseCode,requiredCourseDescription,score,semesterId);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'RawCourseRequirement(courseCode: $courseCode, requiredCourseCode: $requiredCourseCode, requiredCourseDescription: $requiredCourseDescription, score: $score, semesterId: $semesterId)';
}


}

/// @nodoc
abstract mixin class $RawCourseRequirementCopyWith<$Res>  {
  factory $RawCourseRequirementCopyWith(RawCourseRequirement value, $Res Function(RawCourseRequirement) _then) = _$RawCourseRequirementCopyWithImpl;
@useResult
$Res call({
 String courseCode, String requiredCourseCode, String requiredCourseDescription, String score, String semesterId
});




}
/// @nodoc
class _$RawCourseRequirementCopyWithImpl<$Res>
    implements $RawCourseRequirementCopyWith<$Res> {
  _$RawCourseRequirementCopyWithImpl(this._self, this._then);

  final RawCourseRequirement _self;
  final $Res Function(RawCourseRequirement) _then;

/// Create a copy of RawCourseRequirement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? courseCode = null,Object? requiredCourseCode = null,Object? requiredCourseDescription = null,Object? score = null,Object? semesterId = null,}) {
  return _then(_self.copyWith(
courseCode: null == courseCode ? _self.courseCode : courseCode // ignore: cast_nullable_to_non_nullable
as String,requiredCourseCode: null == requiredCourseCode ? _self.requiredCourseCode : requiredCourseCode // ignore: cast_nullable_to_non_nullable
as String,requiredCourseDescription: null == requiredCourseDescription ? _self.requiredCourseDescription : requiredCourseDescription // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as String,semesterId: null == semesterId ? _self.semesterId : semesterId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc


class _RawCourseRequirement with DiagnosticableTreeMixin implements RawCourseRequirement {
  const _RawCourseRequirement({required this.courseCode, required this.requiredCourseCode, required this.requiredCourseDescription, required this.score, required this.semesterId});
  

@override final  String courseCode;
@override final  String requiredCourseCode;
@override final  String requiredCourseDescription;
@override final  String score;
@override final  String semesterId;

/// Create a copy of RawCourseRequirement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RawCourseRequirementCopyWith<_RawCourseRequirement> get copyWith => __$RawCourseRequirementCopyWithImpl<_RawCourseRequirement>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'RawCourseRequirement'))
    ..add(DiagnosticsProperty('courseCode', courseCode))..add(DiagnosticsProperty('requiredCourseCode', requiredCourseCode))..add(DiagnosticsProperty('requiredCourseDescription', requiredCourseDescription))..add(DiagnosticsProperty('score', score))..add(DiagnosticsProperty('semesterId', semesterId));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RawCourseRequirement&&(identical(other.courseCode, courseCode) || other.courseCode == courseCode)&&(identical(other.requiredCourseCode, requiredCourseCode) || other.requiredCourseCode == requiredCourseCode)&&(identical(other.requiredCourseDescription, requiredCourseDescription) || other.requiredCourseDescription == requiredCourseDescription)&&(identical(other.score, score) || other.score == score)&&(identical(other.semesterId, semesterId) || other.semesterId == semesterId));
}


@override
int get hashCode => Object.hash(runtimeType,courseCode,requiredCourseCode,requiredCourseDescription,score,semesterId);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'RawCourseRequirement(courseCode: $courseCode, requiredCourseCode: $requiredCourseCode, requiredCourseDescription: $requiredCourseDescription, score: $score, semesterId: $semesterId)';
}


}

/// @nodoc
abstract mixin class _$RawCourseRequirementCopyWith<$Res> implements $RawCourseRequirementCopyWith<$Res> {
  factory _$RawCourseRequirementCopyWith(_RawCourseRequirement value, $Res Function(_RawCourseRequirement) _then) = __$RawCourseRequirementCopyWithImpl;
@override @useResult
$Res call({
 String courseCode, String requiredCourseCode, String requiredCourseDescription, String score, String semesterId
});




}
/// @nodoc
class __$RawCourseRequirementCopyWithImpl<$Res>
    implements _$RawCourseRequirementCopyWith<$Res> {
  __$RawCourseRequirementCopyWithImpl(this._self, this._then);

  final _RawCourseRequirement _self;
  final $Res Function(_RawCourseRequirement) _then;

/// Create a copy of RawCourseRequirement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? courseCode = null,Object? requiredCourseCode = null,Object? requiredCourseDescription = null,Object? score = null,Object? semesterId = null,}) {
  return _then(_RawCourseRequirement(
courseCode: null == courseCode ? _self.courseCode : courseCode // ignore: cast_nullable_to_non_nullable
as String,requiredCourseCode: null == requiredCourseCode ? _self.requiredCourseCode : requiredCourseCode // ignore: cast_nullable_to_non_nullable
as String,requiredCourseDescription: null == requiredCourseDescription ? _self.requiredCourseDescription : requiredCourseDescription // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as String,semesterId: null == semesterId ? _self.semesterId : semesterId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
