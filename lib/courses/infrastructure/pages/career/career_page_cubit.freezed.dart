// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'career_page_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CareerPageState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CareerPageState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CareerPageState()';
}


}

/// @nodoc
class $CareerPageStateCopyWith<$Res>  {
$CareerPageStateCopyWith(CareerPageState _, $Res Function(CareerPageState) __);
}


/// @nodoc


class CareerPageLoadingState implements CareerPageState {
  const CareerPageLoadingState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CareerPageLoadingState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CareerPageState.loading()';
}


}




/// @nodoc


class CareerPageSuccessState implements CareerPageState {
  const CareerPageSuccessState({required this.programCurriculumProgress, required this.academicReport});
  

 final  ProgramCurriculumProgress programCurriculumProgress;
 final  AcademicReport academicReport;

/// Create a copy of CareerPageState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CareerPageSuccessStateCopyWith<CareerPageSuccessState> get copyWith => _$CareerPageSuccessStateCopyWithImpl<CareerPageSuccessState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CareerPageSuccessState&&(identical(other.programCurriculumProgress, programCurriculumProgress) || other.programCurriculumProgress == programCurriculumProgress)&&(identical(other.academicReport, academicReport) || other.academicReport == academicReport));
}


@override
int get hashCode => Object.hash(runtimeType,programCurriculumProgress,academicReport);

@override
String toString() {
  return 'CareerPageState.success(programCurriculumProgress: $programCurriculumProgress, academicReport: $academicReport)';
}


}

/// @nodoc
abstract mixin class $CareerPageSuccessStateCopyWith<$Res> implements $CareerPageStateCopyWith<$Res> {
  factory $CareerPageSuccessStateCopyWith(CareerPageSuccessState value, $Res Function(CareerPageSuccessState) _then) = _$CareerPageSuccessStateCopyWithImpl;
@useResult
$Res call({
 ProgramCurriculumProgress programCurriculumProgress, AcademicReport academicReport
});


$AcademicReportCopyWith<$Res> get academicReport;

}
/// @nodoc
class _$CareerPageSuccessStateCopyWithImpl<$Res>
    implements $CareerPageSuccessStateCopyWith<$Res> {
  _$CareerPageSuccessStateCopyWithImpl(this._self, this._then);

  final CareerPageSuccessState _self;
  final $Res Function(CareerPageSuccessState) _then;

/// Create a copy of CareerPageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? programCurriculumProgress = null,Object? academicReport = null,}) {
  return _then(CareerPageSuccessState(
programCurriculumProgress: null == programCurriculumProgress ? _self.programCurriculumProgress : programCurriculumProgress // ignore: cast_nullable_to_non_nullable
as ProgramCurriculumProgress,academicReport: null == academicReport ? _self.academicReport : academicReport // ignore: cast_nullable_to_non_nullable
as AcademicReport,
  ));
}

/// Create a copy of CareerPageState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AcademicReportCopyWith<$Res> get academicReport {
  
  return $AcademicReportCopyWith<$Res>(_self.academicReport, (value) {
    return _then(_self.copyWith(academicReport: value));
  });
}
}

/// @nodoc


class CareerPageErrorState implements CareerPageState {
  const CareerPageErrorState(this.error);
  

 final  Object error;

/// Create a copy of CareerPageState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CareerPageErrorStateCopyWith<CareerPageErrorState> get copyWith => _$CareerPageErrorStateCopyWithImpl<CareerPageErrorState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CareerPageErrorState&&const DeepCollectionEquality().equals(other.error, error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(error));

@override
String toString() {
  return 'CareerPageState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class $CareerPageErrorStateCopyWith<$Res> implements $CareerPageStateCopyWith<$Res> {
  factory $CareerPageErrorStateCopyWith(CareerPageErrorState value, $Res Function(CareerPageErrorState) _then) = _$CareerPageErrorStateCopyWithImpl;
@useResult
$Res call({
 Object error
});




}
/// @nodoc
class _$CareerPageErrorStateCopyWithImpl<$Res>
    implements $CareerPageErrorStateCopyWith<$Res> {
  _$CareerPageErrorStateCopyWithImpl(this._self, this._then);

  final CareerPageErrorState _self;
  final $Res Function(CareerPageErrorState) _then;

/// Create a copy of CareerPageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(CareerPageErrorState(
null == error ? _self.error : error ,
  ));
}


}

// dart format on
