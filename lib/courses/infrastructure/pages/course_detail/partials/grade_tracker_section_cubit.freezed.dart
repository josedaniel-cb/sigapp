// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'grade_tracker_section_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GradeTrackerSectionState implements DiagnosticableTreeMixin {




@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'GradeTrackerSectionState'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GradeTrackerSectionState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'GradeTrackerSectionState()';
}


}

/// @nodoc
class $GradeTrackerSectionStateCopyWith<$Res>  {
$GradeTrackerSectionStateCopyWith(GradeTrackerSectionState _, $Res Function(GradeTrackerSectionState) __);
}


/// @nodoc


class GradeTrackerSectionEmptyState with DiagnosticableTreeMixin implements GradeTrackerSectionState {
  const GradeTrackerSectionEmptyState();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'GradeTrackerSectionState.empty'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GradeTrackerSectionEmptyState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'GradeTrackerSectionState.empty()';
}


}




/// @nodoc


class GradeTrackerSectionLoadingState with DiagnosticableTreeMixin implements GradeTrackerSectionState {
  const GradeTrackerSectionLoadingState();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'GradeTrackerSectionState.loading'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GradeTrackerSectionLoadingState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'GradeTrackerSectionState.loading()';
}


}




/// @nodoc


class GradeTrackerSectionReadyState with DiagnosticableTreeMixin implements GradeTrackerSectionState {
  const GradeTrackerSectionReadyState({required this.courseTracking});
  

 final  CourseTracking courseTracking;

/// Create a copy of GradeTrackerSectionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GradeTrackerSectionReadyStateCopyWith<GradeTrackerSectionReadyState> get copyWith => _$GradeTrackerSectionReadyStateCopyWithImpl<GradeTrackerSectionReadyState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'GradeTrackerSectionState.ready'))
    ..add(DiagnosticsProperty('courseTracking', courseTracking));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GradeTrackerSectionReadyState&&(identical(other.courseTracking, courseTracking) || other.courseTracking == courseTracking));
}


@override
int get hashCode => Object.hash(runtimeType,courseTracking);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'GradeTrackerSectionState.ready(courseTracking: $courseTracking)';
}


}

/// @nodoc
abstract mixin class $GradeTrackerSectionReadyStateCopyWith<$Res> implements $GradeTrackerSectionStateCopyWith<$Res> {
  factory $GradeTrackerSectionReadyStateCopyWith(GradeTrackerSectionReadyState value, $Res Function(GradeTrackerSectionReadyState) _then) = _$GradeTrackerSectionReadyStateCopyWithImpl;
@useResult
$Res call({
 CourseTracking courseTracking
});




}
/// @nodoc
class _$GradeTrackerSectionReadyStateCopyWithImpl<$Res>
    implements $GradeTrackerSectionReadyStateCopyWith<$Res> {
  _$GradeTrackerSectionReadyStateCopyWithImpl(this._self, this._then);

  final GradeTrackerSectionReadyState _self;
  final $Res Function(GradeTrackerSectionReadyState) _then;

/// Create a copy of GradeTrackerSectionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? courseTracking = null,}) {
  return _then(GradeTrackerSectionReadyState(
courseTracking: null == courseTracking ? _self.courseTracking : courseTracking // ignore: cast_nullable_to_non_nullable
as CourseTracking,
  ));
}


}

/// @nodoc


class GradeTrackerSectionErrorState with DiagnosticableTreeMixin implements GradeTrackerSectionState {
  const GradeTrackerSectionErrorState(this.error);
  

 final  Object error;

/// Create a copy of GradeTrackerSectionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GradeTrackerSectionErrorStateCopyWith<GradeTrackerSectionErrorState> get copyWith => _$GradeTrackerSectionErrorStateCopyWithImpl<GradeTrackerSectionErrorState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'GradeTrackerSectionState.error'))
    ..add(DiagnosticsProperty('error', error));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GradeTrackerSectionErrorState&&const DeepCollectionEquality().equals(other.error, error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(error));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'GradeTrackerSectionState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class $GradeTrackerSectionErrorStateCopyWith<$Res> implements $GradeTrackerSectionStateCopyWith<$Res> {
  factory $GradeTrackerSectionErrorStateCopyWith(GradeTrackerSectionErrorState value, $Res Function(GradeTrackerSectionErrorState) _then) = _$GradeTrackerSectionErrorStateCopyWithImpl;
@useResult
$Res call({
 Object error
});




}
/// @nodoc
class _$GradeTrackerSectionErrorStateCopyWithImpl<$Res>
    implements $GradeTrackerSectionErrorStateCopyWith<$Res> {
  _$GradeTrackerSectionErrorStateCopyWithImpl(this._self, this._then);

  final GradeTrackerSectionErrorState _self;
  final $Res Function(GradeTrackerSectionErrorState) _then;

/// Create a copy of GradeTrackerSectionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(GradeTrackerSectionErrorState(
null == error ? _self.error : error ,
  ));
}


}

// dart format on
