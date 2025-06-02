// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course_detail_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CourseDetailState implements DiagnosticableTreeMixin {




@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CourseDetailState'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CourseDetailState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CourseDetailState()';
}


}

/// @nodoc
class $CourseDetailStateCopyWith<$Res>  {
$CourseDetailStateCopyWith(CourseDetailState _, $Res Function(CourseDetailState) __);
}


/// @nodoc


class CourseDetailEmptyState with DiagnosticableTreeMixin implements CourseDetailState {
  const CourseDetailEmptyState();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CourseDetailState.empty'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CourseDetailEmptyState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CourseDetailState.empty()';
}


}




/// @nodoc


class CourseDetailReadyState with DiagnosticableTreeMixin implements CourseDetailState {
  const CourseDetailReadyState({required this.course, required this.regevaScheduledCourseId, required this.syllabus, required this.grades});
  

 final  EnrolledCourse course;
 final  String regevaScheduledCourseId;
 final  CourseDetailSyllabusState syllabus;
 final  CourseDetailGradesState grades;

/// Create a copy of CourseDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CourseDetailReadyStateCopyWith<CourseDetailReadyState> get copyWith => _$CourseDetailReadyStateCopyWithImpl<CourseDetailReadyState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CourseDetailState.ready'))
    ..add(DiagnosticsProperty('course', course))..add(DiagnosticsProperty('regevaScheduledCourseId', regevaScheduledCourseId))..add(DiagnosticsProperty('syllabus', syllabus))..add(DiagnosticsProperty('grades', grades));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CourseDetailReadyState&&(identical(other.course, course) || other.course == course)&&(identical(other.regevaScheduledCourseId, regevaScheduledCourseId) || other.regevaScheduledCourseId == regevaScheduledCourseId)&&(identical(other.syllabus, syllabus) || other.syllabus == syllabus)&&(identical(other.grades, grades) || other.grades == grades));
}


@override
int get hashCode => Object.hash(runtimeType,course,regevaScheduledCourseId,syllabus,grades);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CourseDetailState.ready(course: $course, regevaScheduledCourseId: $regevaScheduledCourseId, syllabus: $syllabus, grades: $grades)';
}


}

/// @nodoc
abstract mixin class $CourseDetailReadyStateCopyWith<$Res> implements $CourseDetailStateCopyWith<$Res> {
  factory $CourseDetailReadyStateCopyWith(CourseDetailReadyState value, $Res Function(CourseDetailReadyState) _then) = _$CourseDetailReadyStateCopyWithImpl;
@useResult
$Res call({
 EnrolledCourse course, String regevaScheduledCourseId, CourseDetailSyllabusState syllabus, CourseDetailGradesState grades
});


$CourseDetailSyllabusStateCopyWith<$Res> get syllabus;$CourseDetailGradesStateCopyWith<$Res> get grades;

}
/// @nodoc
class _$CourseDetailReadyStateCopyWithImpl<$Res>
    implements $CourseDetailReadyStateCopyWith<$Res> {
  _$CourseDetailReadyStateCopyWithImpl(this._self, this._then);

  final CourseDetailReadyState _self;
  final $Res Function(CourseDetailReadyState) _then;

/// Create a copy of CourseDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? course = null,Object? regevaScheduledCourseId = null,Object? syllabus = null,Object? grades = null,}) {
  return _then(CourseDetailReadyState(
course: null == course ? _self.course : course // ignore: cast_nullable_to_non_nullable
as EnrolledCourse,regevaScheduledCourseId: null == regevaScheduledCourseId ? _self.regevaScheduledCourseId : regevaScheduledCourseId // ignore: cast_nullable_to_non_nullable
as String,syllabus: null == syllabus ? _self.syllabus : syllabus // ignore: cast_nullable_to_non_nullable
as CourseDetailSyllabusState,grades: null == grades ? _self.grades : grades // ignore: cast_nullable_to_non_nullable
as CourseDetailGradesState,
  ));
}

/// Create a copy of CourseDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CourseDetailSyllabusStateCopyWith<$Res> get syllabus {
  
  return $CourseDetailSyllabusStateCopyWith<$Res>(_self.syllabus, (value) {
    return _then(_self.copyWith(syllabus: value));
  });
}/// Create a copy of CourseDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CourseDetailGradesStateCopyWith<$Res> get grades {
  
  return $CourseDetailGradesStateCopyWith<$Res>(_self.grades, (value) {
    return _then(_self.copyWith(grades: value));
  });
}
}

/// @nodoc
mixin _$CourseDetailSyllabusState implements DiagnosticableTreeMixin {




@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CourseDetailSyllabusState'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CourseDetailSyllabusState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CourseDetailSyllabusState()';
}


}

/// @nodoc
class $CourseDetailSyllabusStateCopyWith<$Res>  {
$CourseDetailSyllabusStateCopyWith(CourseDetailSyllabusState _, $Res Function(CourseDetailSyllabusState) __);
}


/// @nodoc


class CourseDetailSyllabusStateInitial with DiagnosticableTreeMixin implements CourseDetailSyllabusState {
  const CourseDetailSyllabusStateInitial();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CourseDetailSyllabusState.initial'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CourseDetailSyllabusStateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CourseDetailSyllabusState.initial()';
}


}




/// @nodoc


class CourseDetailSyllabusStateLoading with DiagnosticableTreeMixin implements CourseDetailSyllabusState {
  const CourseDetailSyllabusStateLoading();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CourseDetailSyllabusState.loading'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CourseDetailSyllabusStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CourseDetailSyllabusState.loading()';
}


}




/// @nodoc


class CourseDetailSyllabusStateLoaded with DiagnosticableTreeMixin implements CourseDetailSyllabusState {
  const CourseDetailSyllabusStateLoaded(this.syllabusFile);
  

 final  File syllabusFile;

/// Create a copy of CourseDetailSyllabusState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CourseDetailSyllabusStateLoadedCopyWith<CourseDetailSyllabusStateLoaded> get copyWith => _$CourseDetailSyllabusStateLoadedCopyWithImpl<CourseDetailSyllabusStateLoaded>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CourseDetailSyllabusState.loaded'))
    ..add(DiagnosticsProperty('syllabusFile', syllabusFile));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CourseDetailSyllabusStateLoaded&&(identical(other.syllabusFile, syllabusFile) || other.syllabusFile == syllabusFile));
}


@override
int get hashCode => Object.hash(runtimeType,syllabusFile);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CourseDetailSyllabusState.loaded(syllabusFile: $syllabusFile)';
}


}

/// @nodoc
abstract mixin class $CourseDetailSyllabusStateLoadedCopyWith<$Res> implements $CourseDetailSyllabusStateCopyWith<$Res> {
  factory $CourseDetailSyllabusStateLoadedCopyWith(CourseDetailSyllabusStateLoaded value, $Res Function(CourseDetailSyllabusStateLoaded) _then) = _$CourseDetailSyllabusStateLoadedCopyWithImpl;
@useResult
$Res call({
 File syllabusFile
});




}
/// @nodoc
class _$CourseDetailSyllabusStateLoadedCopyWithImpl<$Res>
    implements $CourseDetailSyllabusStateLoadedCopyWith<$Res> {
  _$CourseDetailSyllabusStateLoadedCopyWithImpl(this._self, this._then);

  final CourseDetailSyllabusStateLoaded _self;
  final $Res Function(CourseDetailSyllabusStateLoaded) _then;

/// Create a copy of CourseDetailSyllabusState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? syllabusFile = null,}) {
  return _then(CourseDetailSyllabusStateLoaded(
null == syllabusFile ? _self.syllabusFile : syllabusFile // ignore: cast_nullable_to_non_nullable
as File,
  ));
}


}

/// @nodoc


class CourseDetailSyllabusStateNotFound with DiagnosticableTreeMixin implements CourseDetailSyllabusState {
  const CourseDetailSyllabusStateNotFound();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CourseDetailSyllabusState.notFound'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CourseDetailSyllabusStateNotFound);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CourseDetailSyllabusState.notFound()';
}


}




/// @nodoc


class CourseDetailSyllabusStateError with DiagnosticableTreeMixin implements CourseDetailSyllabusState {
  const CourseDetailSyllabusStateError(this.message);
  

 final  String message;

/// Create a copy of CourseDetailSyllabusState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CourseDetailSyllabusStateErrorCopyWith<CourseDetailSyllabusStateError> get copyWith => _$CourseDetailSyllabusStateErrorCopyWithImpl<CourseDetailSyllabusStateError>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CourseDetailSyllabusState.error'))
    ..add(DiagnosticsProperty('message', message));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CourseDetailSyllabusStateError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CourseDetailSyllabusState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $CourseDetailSyllabusStateErrorCopyWith<$Res> implements $CourseDetailSyllabusStateCopyWith<$Res> {
  factory $CourseDetailSyllabusStateErrorCopyWith(CourseDetailSyllabusStateError value, $Res Function(CourseDetailSyllabusStateError) _then) = _$CourseDetailSyllabusStateErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$CourseDetailSyllabusStateErrorCopyWithImpl<$Res>
    implements $CourseDetailSyllabusStateErrorCopyWith<$Res> {
  _$CourseDetailSyllabusStateErrorCopyWithImpl(this._self, this._then);

  final CourseDetailSyllabusStateError _self;
  final $Res Function(CourseDetailSyllabusStateError) _then;

/// Create a copy of CourseDetailSyllabusState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(CourseDetailSyllabusStateError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$CourseDetailGradesState implements DiagnosticableTreeMixin {




@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CourseDetailGradesState'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CourseDetailGradesState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CourseDetailGradesState()';
}


}

/// @nodoc
class $CourseDetailGradesStateCopyWith<$Res>  {
$CourseDetailGradesStateCopyWith(CourseDetailGradesState _, $Res Function(CourseDetailGradesState) __);
}


/// @nodoc


class CourseDetailGradesStateInitial with DiagnosticableTreeMixin implements CourseDetailGradesState {
  const CourseDetailGradesStateInitial();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CourseDetailGradesState.initial'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CourseDetailGradesStateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CourseDetailGradesState.initial()';
}


}




/// @nodoc


class CourseDetailGradesStateLoading with DiagnosticableTreeMixin implements CourseDetailGradesState {
  const CourseDetailGradesStateLoading();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CourseDetailGradesState.loading'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CourseDetailGradesStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CourseDetailGradesState.loading()';
}


}




/// @nodoc


class CourseDetailGradesStateLoaded with DiagnosticableTreeMixin implements CourseDetailGradesState {
  const CourseDetailGradesStateLoaded(this.value);
  

 final  CourseGradeInfo value;

/// Create a copy of CourseDetailGradesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CourseDetailGradesStateLoadedCopyWith<CourseDetailGradesStateLoaded> get copyWith => _$CourseDetailGradesStateLoadedCopyWithImpl<CourseDetailGradesStateLoaded>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CourseDetailGradesState.loaded'))
    ..add(DiagnosticsProperty('value', value));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CourseDetailGradesStateLoaded&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CourseDetailGradesState.loaded(value: $value)';
}


}

/// @nodoc
abstract mixin class $CourseDetailGradesStateLoadedCopyWith<$Res> implements $CourseDetailGradesStateCopyWith<$Res> {
  factory $CourseDetailGradesStateLoadedCopyWith(CourseDetailGradesStateLoaded value, $Res Function(CourseDetailGradesStateLoaded) _then) = _$CourseDetailGradesStateLoadedCopyWithImpl;
@useResult
$Res call({
 CourseGradeInfo value
});




}
/// @nodoc
class _$CourseDetailGradesStateLoadedCopyWithImpl<$Res>
    implements $CourseDetailGradesStateLoadedCopyWith<$Res> {
  _$CourseDetailGradesStateLoadedCopyWithImpl(this._self, this._then);

  final CourseDetailGradesStateLoaded _self;
  final $Res Function(CourseDetailGradesStateLoaded) _then;

/// Create a copy of CourseDetailGradesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(CourseDetailGradesStateLoaded(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as CourseGradeInfo,
  ));
}


}

/// @nodoc


class CourseDetailGradesStateError with DiagnosticableTreeMixin implements CourseDetailGradesState {
  const CourseDetailGradesStateError(this.message);
  

 final  String message;

/// Create a copy of CourseDetailGradesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CourseDetailGradesStateErrorCopyWith<CourseDetailGradesStateError> get copyWith => _$CourseDetailGradesStateErrorCopyWithImpl<CourseDetailGradesStateError>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CourseDetailGradesState.error'))
    ..add(DiagnosticsProperty('message', message));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CourseDetailGradesStateError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CourseDetailGradesState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $CourseDetailGradesStateErrorCopyWith<$Res> implements $CourseDetailGradesStateCopyWith<$Res> {
  factory $CourseDetailGradesStateErrorCopyWith(CourseDetailGradesStateError value, $Res Function(CourseDetailGradesStateError) _then) = _$CourseDetailGradesStateErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$CourseDetailGradesStateErrorCopyWithImpl<$Res>
    implements $CourseDetailGradesStateErrorCopyWith<$Res> {
  _$CourseDetailGradesStateErrorCopyWithImpl(this._self, this._then);

  final CourseDetailGradesStateError _self;
  final $Res Function(CourseDetailGradesStateError) _then;

/// Create a copy of CourseDetailGradesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(CourseDetailGradesStateError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
