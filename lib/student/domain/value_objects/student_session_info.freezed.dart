// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'student_session_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StudentSessionInfo {

 String get currentSemesterName; String get schoolName;
/// Create a copy of StudentSessionInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudentSessionInfoCopyWith<StudentSessionInfo> get copyWith => _$StudentSessionInfoCopyWithImpl<StudentSessionInfo>(this as StudentSessionInfo, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudentSessionInfo&&(identical(other.currentSemesterName, currentSemesterName) || other.currentSemesterName == currentSemesterName)&&(identical(other.schoolName, schoolName) || other.schoolName == schoolName));
}


@override
int get hashCode => Object.hash(runtimeType,currentSemesterName,schoolName);

@override
String toString() {
  return 'StudentSessionInfo(currentSemesterName: $currentSemesterName, schoolName: $schoolName)';
}


}

/// @nodoc
abstract mixin class $StudentSessionInfoCopyWith<$Res>  {
  factory $StudentSessionInfoCopyWith(StudentSessionInfo value, $Res Function(StudentSessionInfo) _then) = _$StudentSessionInfoCopyWithImpl;
@useResult
$Res call({
 String currentSemesterName, String schoolName
});




}
/// @nodoc
class _$StudentSessionInfoCopyWithImpl<$Res>
    implements $StudentSessionInfoCopyWith<$Res> {
  _$StudentSessionInfoCopyWithImpl(this._self, this._then);

  final StudentSessionInfo _self;
  final $Res Function(StudentSessionInfo) _then;

/// Create a copy of StudentSessionInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentSemesterName = null,Object? schoolName = null,}) {
  return _then(_self.copyWith(
currentSemesterName: null == currentSemesterName ? _self.currentSemesterName : currentSemesterName // ignore: cast_nullable_to_non_nullable
as String,schoolName: null == schoolName ? _self.schoolName : schoolName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc


class _StudentSessionInfo implements StudentSessionInfo {
   _StudentSessionInfo({required this.currentSemesterName, required this.schoolName});
  

@override final  String currentSemesterName;
@override final  String schoolName;

/// Create a copy of StudentSessionInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudentSessionInfoCopyWith<_StudentSessionInfo> get copyWith => __$StudentSessionInfoCopyWithImpl<_StudentSessionInfo>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudentSessionInfo&&(identical(other.currentSemesterName, currentSemesterName) || other.currentSemesterName == currentSemesterName)&&(identical(other.schoolName, schoolName) || other.schoolName == schoolName));
}


@override
int get hashCode => Object.hash(runtimeType,currentSemesterName,schoolName);

@override
String toString() {
  return 'StudentSessionInfo(currentSemesterName: $currentSemesterName, schoolName: $schoolName)';
}


}

/// @nodoc
abstract mixin class _$StudentSessionInfoCopyWith<$Res> implements $StudentSessionInfoCopyWith<$Res> {
  factory _$StudentSessionInfoCopyWith(_StudentSessionInfo value, $Res Function(_StudentSessionInfo) _then) = __$StudentSessionInfoCopyWithImpl;
@override @useResult
$Res call({
 String currentSemesterName, String schoolName
});




}
/// @nodoc
class __$StudentSessionInfoCopyWithImpl<$Res>
    implements _$StudentSessionInfoCopyWith<$Res> {
  __$StudentSessionInfoCopyWithImpl(this._self, this._then);

  final _StudentSessionInfo _self;
  final $Res Function(_StudentSessionInfo) _then;

/// Create a copy of StudentSessionInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentSemesterName = null,Object? schoolName = null,}) {
  return _then(_StudentSessionInfo(
currentSemesterName: null == currentSemesterName ? _self.currentSemesterName : currentSemesterName // ignore: cast_nullable_to_non_nullable
as String,schoolName: null == schoolName ? _self.schoolName : schoolName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
