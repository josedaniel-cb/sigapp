// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scheduled_courses_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ScheduledCoursesPageState implements DiagnosticableTreeMixin {




@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ScheduledCoursesPageState'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScheduledCoursesPageState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ScheduledCoursesPageState()';
}


}

/// @nodoc
class $ScheduledCoursesPageStateCopyWith<$Res>  {
$ScheduledCoursesPageStateCopyWith(ScheduledCoursesPageState _, $Res Function(ScheduledCoursesPageState) __);
}


/// @nodoc


class CoursesPageLoadingState with DiagnosticableTreeMixin implements ScheduledCoursesPageState {
  const CoursesPageLoadingState();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ScheduledCoursesPageState.loading'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CoursesPageLoadingState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ScheduledCoursesPageState.loading()';
}


}




/// @nodoc


class ScheduledCoursesPageSuccessState with DiagnosticableTreeMixin implements ScheduledCoursesPageState {
  const ScheduledCoursesPageSuccessState({required final  List<ScheduledCourse> scheduledCourses, required final  List<ScheduledCourse> filteredCourses, required this.searchQuery}): _scheduledCourses = scheduledCourses,_filteredCourses = filteredCourses;
  

 final  List<ScheduledCourse> _scheduledCourses;
 List<ScheduledCourse> get scheduledCourses {
  if (_scheduledCourses is EqualUnmodifiableListView) return _scheduledCourses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_scheduledCourses);
}

 final  List<ScheduledCourse> _filteredCourses;
 List<ScheduledCourse> get filteredCourses {
  if (_filteredCourses is EqualUnmodifiableListView) return _filteredCourses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filteredCourses);
}

 final  String searchQuery;

/// Create a copy of ScheduledCoursesPageState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScheduledCoursesPageSuccessStateCopyWith<ScheduledCoursesPageSuccessState> get copyWith => _$ScheduledCoursesPageSuccessStateCopyWithImpl<ScheduledCoursesPageSuccessState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ScheduledCoursesPageState.success'))
    ..add(DiagnosticsProperty('scheduledCourses', scheduledCourses))..add(DiagnosticsProperty('filteredCourses', filteredCourses))..add(DiagnosticsProperty('searchQuery', searchQuery));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScheduledCoursesPageSuccessState&&const DeepCollectionEquality().equals(other._scheduledCourses, _scheduledCourses)&&const DeepCollectionEquality().equals(other._filteredCourses, _filteredCourses)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_scheduledCourses),const DeepCollectionEquality().hash(_filteredCourses),searchQuery);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ScheduledCoursesPageState.success(scheduledCourses: $scheduledCourses, filteredCourses: $filteredCourses, searchQuery: $searchQuery)';
}


}

/// @nodoc
abstract mixin class $ScheduledCoursesPageSuccessStateCopyWith<$Res> implements $ScheduledCoursesPageStateCopyWith<$Res> {
  factory $ScheduledCoursesPageSuccessStateCopyWith(ScheduledCoursesPageSuccessState value, $Res Function(ScheduledCoursesPageSuccessState) _then) = _$ScheduledCoursesPageSuccessStateCopyWithImpl;
@useResult
$Res call({
 List<ScheduledCourse> scheduledCourses, List<ScheduledCourse> filteredCourses, String searchQuery
});




}
/// @nodoc
class _$ScheduledCoursesPageSuccessStateCopyWithImpl<$Res>
    implements $ScheduledCoursesPageSuccessStateCopyWith<$Res> {
  _$ScheduledCoursesPageSuccessStateCopyWithImpl(this._self, this._then);

  final ScheduledCoursesPageSuccessState _self;
  final $Res Function(ScheduledCoursesPageSuccessState) _then;

/// Create a copy of ScheduledCoursesPageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? scheduledCourses = null,Object? filteredCourses = null,Object? searchQuery = null,}) {
  return _then(ScheduledCoursesPageSuccessState(
scheduledCourses: null == scheduledCourses ? _self._scheduledCourses : scheduledCourses // ignore: cast_nullable_to_non_nullable
as List<ScheduledCourse>,filteredCourses: null == filteredCourses ? _self._filteredCourses : filteredCourses // ignore: cast_nullable_to_non_nullable
as List<ScheduledCourse>,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CoursesPageErrorState with DiagnosticableTreeMixin implements ScheduledCoursesPageState {
  const CoursesPageErrorState(this.error);
  

 final  Object error;

/// Create a copy of ScheduledCoursesPageState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CoursesPageErrorStateCopyWith<CoursesPageErrorState> get copyWith => _$CoursesPageErrorStateCopyWithImpl<CoursesPageErrorState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ScheduledCoursesPageState.error'))
    ..add(DiagnosticsProperty('error', error));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CoursesPageErrorState&&const DeepCollectionEquality().equals(other.error, error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(error));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ScheduledCoursesPageState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class $CoursesPageErrorStateCopyWith<$Res> implements $ScheduledCoursesPageStateCopyWith<$Res> {
  factory $CoursesPageErrorStateCopyWith(CoursesPageErrorState value, $Res Function(CoursesPageErrorState) _then) = _$CoursesPageErrorStateCopyWithImpl;
@useResult
$Res call({
 Object error
});




}
/// @nodoc
class _$CoursesPageErrorStateCopyWithImpl<$Res>
    implements $CoursesPageErrorStateCopyWith<$Res> {
  _$CoursesPageErrorStateCopyWithImpl(this._self, this._then);

  final CoursesPageErrorState _self;
  final $Res Function(CoursesPageErrorState) _then;

/// Create a copy of ScheduledCoursesPageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(CoursesPageErrorState(
null == error ? _self.error : error ,
  ));
}


}

// dart format on
