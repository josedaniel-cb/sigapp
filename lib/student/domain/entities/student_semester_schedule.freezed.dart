// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'student_semester_schedule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SemesterSchedule {
  AcademicReport get studentAcademicReport =>
      throw _privateConstructorUsedError;
  List<ScheduledTermIdentifier> get semesterList =>
      throw _privateConstructorUsedError;
  ScheduledTermIdentifier get semester => throw _privateConstructorUsedError;
  List<WeeklyScheduleEvent> get weeklyEvents =>
      throw _privateConstructorUsedError;

  /// Create a copy of SemesterSchedule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SemesterScheduleCopyWith<SemesterSchedule> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SemesterScheduleCopyWith<$Res> {
  factory $SemesterScheduleCopyWith(
          SemesterSchedule value, $Res Function(SemesterSchedule) then) =
      _$SemesterScheduleCopyWithImpl<$Res, SemesterSchedule>;
  @useResult
  $Res call(
      {AcademicReport studentAcademicReport,
      List<ScheduledTermIdentifier> semesterList,
      ScheduledTermIdentifier semester,
      List<WeeklyScheduleEvent> weeklyEvents});

  $AcademicReportCopyWith<$Res> get studentAcademicReport;
}

/// @nodoc
class _$SemesterScheduleCopyWithImpl<$Res, $Val extends SemesterSchedule>
    implements $SemesterScheduleCopyWith<$Res> {
  _$SemesterScheduleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SemesterSchedule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studentAcademicReport = null,
    Object? semesterList = null,
    Object? semester = null,
    Object? weeklyEvents = null,
  }) {
    return _then(_value.copyWith(
      studentAcademicReport: null == studentAcademicReport
          ? _value.studentAcademicReport
          : studentAcademicReport // ignore: cast_nullable_to_non_nullable
              as AcademicReport,
      semesterList: null == semesterList
          ? _value.semesterList
          : semesterList // ignore: cast_nullable_to_non_nullable
              as List<ScheduledTermIdentifier>,
      semester: null == semester
          ? _value.semester
          : semester // ignore: cast_nullable_to_non_nullable
              as ScheduledTermIdentifier,
      weeklyEvents: null == weeklyEvents
          ? _value.weeklyEvents
          : weeklyEvents // ignore: cast_nullable_to_non_nullable
              as List<WeeklyScheduleEvent>,
    ) as $Val);
  }

  /// Create a copy of SemesterSchedule
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AcademicReportCopyWith<$Res> get studentAcademicReport {
    return $AcademicReportCopyWith<$Res>(_value.studentAcademicReport, (value) {
      return _then(_value.copyWith(studentAcademicReport: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SemesterScheduleImplCopyWith<$Res>
    implements $SemesterScheduleCopyWith<$Res> {
  factory _$$SemesterScheduleImplCopyWith(_$SemesterScheduleImpl value,
          $Res Function(_$SemesterScheduleImpl) then) =
      __$$SemesterScheduleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AcademicReport studentAcademicReport,
      List<ScheduledTermIdentifier> semesterList,
      ScheduledTermIdentifier semester,
      List<WeeklyScheduleEvent> weeklyEvents});

  @override
  $AcademicReportCopyWith<$Res> get studentAcademicReport;
}

/// @nodoc
class __$$SemesterScheduleImplCopyWithImpl<$Res>
    extends _$SemesterScheduleCopyWithImpl<$Res, _$SemesterScheduleImpl>
    implements _$$SemesterScheduleImplCopyWith<$Res> {
  __$$SemesterScheduleImplCopyWithImpl(_$SemesterScheduleImpl _value,
      $Res Function(_$SemesterScheduleImpl) _then)
      : super(_value, _then);

  /// Create a copy of SemesterSchedule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studentAcademicReport = null,
    Object? semesterList = null,
    Object? semester = null,
    Object? weeklyEvents = null,
  }) {
    return _then(_$SemesterScheduleImpl(
      studentAcademicReport: null == studentAcademicReport
          ? _value.studentAcademicReport
          : studentAcademicReport // ignore: cast_nullable_to_non_nullable
              as AcademicReport,
      semesterList: null == semesterList
          ? _value._semesterList
          : semesterList // ignore: cast_nullable_to_non_nullable
              as List<ScheduledTermIdentifier>,
      semester: null == semester
          ? _value.semester
          : semester // ignore: cast_nullable_to_non_nullable
              as ScheduledTermIdentifier,
      weeklyEvents: null == weeklyEvents
          ? _value._weeklyEvents
          : weeklyEvents // ignore: cast_nullable_to_non_nullable
              as List<WeeklyScheduleEvent>,
    ));
  }
}

/// @nodoc

class _$SemesterScheduleImpl implements _SemesterSchedule {
  _$SemesterScheduleImpl(
      {required this.studentAcademicReport,
      required final List<ScheduledTermIdentifier> semesterList,
      required this.semester,
      required final List<WeeklyScheduleEvent> weeklyEvents})
      : _semesterList = semesterList,
        _weeklyEvents = weeklyEvents;

  @override
  final AcademicReport studentAcademicReport;
  final List<ScheduledTermIdentifier> _semesterList;
  @override
  List<ScheduledTermIdentifier> get semesterList {
    if (_semesterList is EqualUnmodifiableListView) return _semesterList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_semesterList);
  }

  @override
  final ScheduledTermIdentifier semester;
  final List<WeeklyScheduleEvent> _weeklyEvents;
  @override
  List<WeeklyScheduleEvent> get weeklyEvents {
    if (_weeklyEvents is EqualUnmodifiableListView) return _weeklyEvents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_weeklyEvents);
  }

  @override
  String toString() {
    return 'SemesterSchedule(studentAcademicReport: $studentAcademicReport, semesterList: $semesterList, semester: $semester, weeklyEvents: $weeklyEvents)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SemesterScheduleImpl &&
            (identical(other.studentAcademicReport, studentAcademicReport) ||
                other.studentAcademicReport == studentAcademicReport) &&
            const DeepCollectionEquality()
                .equals(other._semesterList, _semesterList) &&
            (identical(other.semester, semester) ||
                other.semester == semester) &&
            const DeepCollectionEquality()
                .equals(other._weeklyEvents, _weeklyEvents));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      studentAcademicReport,
      const DeepCollectionEquality().hash(_semesterList),
      semester,
      const DeepCollectionEquality().hash(_weeklyEvents));

  /// Create a copy of SemesterSchedule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SemesterScheduleImplCopyWith<_$SemesterScheduleImpl> get copyWith =>
      __$$SemesterScheduleImplCopyWithImpl<_$SemesterScheduleImpl>(
          this, _$identity);
}

abstract class _SemesterSchedule implements SemesterSchedule {
  factory _SemesterSchedule(
          {required final AcademicReport studentAcademicReport,
          required final List<ScheduledTermIdentifier> semesterList,
          required final ScheduledTermIdentifier semester,
          required final List<WeeklyScheduleEvent> weeklyEvents}) =
      _$SemesterScheduleImpl;

  @override
  AcademicReport get studentAcademicReport;
  @override
  List<ScheduledTermIdentifier> get semesterList;
  @override
  ScheduledTermIdentifier get semester;
  @override
  List<WeeklyScheduleEvent> get weeklyEvents;

  /// Create a copy of SemesterSchedule
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SemesterScheduleImplCopyWith<_$SemesterScheduleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
