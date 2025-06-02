// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'student_semester_schedule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SemesterSchedule {

 AcademicReport get studentAcademicReport; List<ScheduledTermIdentifier> get semesterList; ScheduledTermIdentifier get semester; List<WeeklyScheduleEvent> get weeklyEvents;
/// Create a copy of SemesterSchedule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SemesterScheduleCopyWith<SemesterSchedule> get copyWith => _$SemesterScheduleCopyWithImpl<SemesterSchedule>(this as SemesterSchedule, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SemesterSchedule&&(identical(other.studentAcademicReport, studentAcademicReport) || other.studentAcademicReport == studentAcademicReport)&&const DeepCollectionEquality().equals(other.semesterList, semesterList)&&(identical(other.semester, semester) || other.semester == semester)&&const DeepCollectionEquality().equals(other.weeklyEvents, weeklyEvents));
}


@override
int get hashCode => Object.hash(runtimeType,studentAcademicReport,const DeepCollectionEquality().hash(semesterList),semester,const DeepCollectionEquality().hash(weeklyEvents));

@override
String toString() {
  return 'SemesterSchedule(studentAcademicReport: $studentAcademicReport, semesterList: $semesterList, semester: $semester, weeklyEvents: $weeklyEvents)';
}


}

/// @nodoc
abstract mixin class $SemesterScheduleCopyWith<$Res>  {
  factory $SemesterScheduleCopyWith(SemesterSchedule value, $Res Function(SemesterSchedule) _then) = _$SemesterScheduleCopyWithImpl;
@useResult
$Res call({
 AcademicReport studentAcademicReport, List<ScheduledTermIdentifier> semesterList, ScheduledTermIdentifier semester, List<WeeklyScheduleEvent> weeklyEvents
});


$AcademicReportCopyWith<$Res> get studentAcademicReport;

}
/// @nodoc
class _$SemesterScheduleCopyWithImpl<$Res>
    implements $SemesterScheduleCopyWith<$Res> {
  _$SemesterScheduleCopyWithImpl(this._self, this._then);

  final SemesterSchedule _self;
  final $Res Function(SemesterSchedule) _then;

/// Create a copy of SemesterSchedule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? studentAcademicReport = null,Object? semesterList = null,Object? semester = null,Object? weeklyEvents = null,}) {
  return _then(_self.copyWith(
studentAcademicReport: null == studentAcademicReport ? _self.studentAcademicReport : studentAcademicReport // ignore: cast_nullable_to_non_nullable
as AcademicReport,semesterList: null == semesterList ? _self.semesterList : semesterList // ignore: cast_nullable_to_non_nullable
as List<ScheduledTermIdentifier>,semester: null == semester ? _self.semester : semester // ignore: cast_nullable_to_non_nullable
as ScheduledTermIdentifier,weeklyEvents: null == weeklyEvents ? _self.weeklyEvents : weeklyEvents // ignore: cast_nullable_to_non_nullable
as List<WeeklyScheduleEvent>,
  ));
}
/// Create a copy of SemesterSchedule
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AcademicReportCopyWith<$Res> get studentAcademicReport {
  
  return $AcademicReportCopyWith<$Res>(_self.studentAcademicReport, (value) {
    return _then(_self.copyWith(studentAcademicReport: value));
  });
}
}


/// @nodoc


class _SemesterSchedule implements SemesterSchedule {
   _SemesterSchedule({required this.studentAcademicReport, required final  List<ScheduledTermIdentifier> semesterList, required this.semester, required final  List<WeeklyScheduleEvent> weeklyEvents}): _semesterList = semesterList,_weeklyEvents = weeklyEvents;
  

@override final  AcademicReport studentAcademicReport;
 final  List<ScheduledTermIdentifier> _semesterList;
@override List<ScheduledTermIdentifier> get semesterList {
  if (_semesterList is EqualUnmodifiableListView) return _semesterList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_semesterList);
}

@override final  ScheduledTermIdentifier semester;
 final  List<WeeklyScheduleEvent> _weeklyEvents;
@override List<WeeklyScheduleEvent> get weeklyEvents {
  if (_weeklyEvents is EqualUnmodifiableListView) return _weeklyEvents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_weeklyEvents);
}


/// Create a copy of SemesterSchedule
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SemesterScheduleCopyWith<_SemesterSchedule> get copyWith => __$SemesterScheduleCopyWithImpl<_SemesterSchedule>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SemesterSchedule&&(identical(other.studentAcademicReport, studentAcademicReport) || other.studentAcademicReport == studentAcademicReport)&&const DeepCollectionEquality().equals(other._semesterList, _semesterList)&&(identical(other.semester, semester) || other.semester == semester)&&const DeepCollectionEquality().equals(other._weeklyEvents, _weeklyEvents));
}


@override
int get hashCode => Object.hash(runtimeType,studentAcademicReport,const DeepCollectionEquality().hash(_semesterList),semester,const DeepCollectionEquality().hash(_weeklyEvents));

@override
String toString() {
  return 'SemesterSchedule(studentAcademicReport: $studentAcademicReport, semesterList: $semesterList, semester: $semester, weeklyEvents: $weeklyEvents)';
}


}

/// @nodoc
abstract mixin class _$SemesterScheduleCopyWith<$Res> implements $SemesterScheduleCopyWith<$Res> {
  factory _$SemesterScheduleCopyWith(_SemesterSchedule value, $Res Function(_SemesterSchedule) _then) = __$SemesterScheduleCopyWithImpl;
@override @useResult
$Res call({
 AcademicReport studentAcademicReport, List<ScheduledTermIdentifier> semesterList, ScheduledTermIdentifier semester, List<WeeklyScheduleEvent> weeklyEvents
});


@override $AcademicReportCopyWith<$Res> get studentAcademicReport;

}
/// @nodoc
class __$SemesterScheduleCopyWithImpl<$Res>
    implements _$SemesterScheduleCopyWith<$Res> {
  __$SemesterScheduleCopyWithImpl(this._self, this._then);

  final _SemesterSchedule _self;
  final $Res Function(_SemesterSchedule) _then;

/// Create a copy of SemesterSchedule
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? studentAcademicReport = null,Object? semesterList = null,Object? semester = null,Object? weeklyEvents = null,}) {
  return _then(_SemesterSchedule(
studentAcademicReport: null == studentAcademicReport ? _self.studentAcademicReport : studentAcademicReport // ignore: cast_nullable_to_non_nullable
as AcademicReport,semesterList: null == semesterList ? _self._semesterList : semesterList // ignore: cast_nullable_to_non_nullable
as List<ScheduledTermIdentifier>,semester: null == semester ? _self.semester : semester // ignore: cast_nullable_to_non_nullable
as ScheduledTermIdentifier,weeklyEvents: null == weeklyEvents ? _self._weeklyEvents : weeklyEvents // ignore: cast_nullable_to_non_nullable
as List<WeeklyScheduleEvent>,
  ));
}

/// Create a copy of SemesterSchedule
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AcademicReportCopyWith<$Res> get studentAcademicReport {
  
  return $AcademicReportCopyWith<$Res>(_self.studentAcademicReport, (value) {
    return _then(_self.copyWith(studentAcademicReport: value));
  });
}
}

// dart format on
