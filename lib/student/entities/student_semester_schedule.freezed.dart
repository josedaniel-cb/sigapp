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
mixin _$StudentSemesterSchedule {
  String get semester =>
      throw _privateConstructorUsedError; // YYYYX where X is 1 or 2
// required List<GetClassScheduleModel> rawSchedule,
  List<WeeklyScheduleEvent> get weeklyEvents =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StudentSemesterScheduleCopyWith<StudentSemesterSchedule> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudentSemesterScheduleCopyWith<$Res> {
  factory $StudentSemesterScheduleCopyWith(StudentSemesterSchedule value,
          $Res Function(StudentSemesterSchedule) then) =
      _$StudentSemesterScheduleCopyWithImpl<$Res, StudentSemesterSchedule>;
  @useResult
  $Res call({String semester, List<WeeklyScheduleEvent> weeklyEvents});
}

/// @nodoc
class _$StudentSemesterScheduleCopyWithImpl<$Res,
        $Val extends StudentSemesterSchedule>
    implements $StudentSemesterScheduleCopyWith<$Res> {
  _$StudentSemesterScheduleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? semester = null,
    Object? weeklyEvents = null,
  }) {
    return _then(_value.copyWith(
      semester: null == semester
          ? _value.semester
          : semester // ignore: cast_nullable_to_non_nullable
              as String,
      weeklyEvents: null == weeklyEvents
          ? _value.weeklyEvents
          : weeklyEvents // ignore: cast_nullable_to_non_nullable
              as List<WeeklyScheduleEvent>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StudentSemesterScheduleImplCopyWith<$Res>
    implements $StudentSemesterScheduleCopyWith<$Res> {
  factory _$$StudentSemesterScheduleImplCopyWith(
          _$StudentSemesterScheduleImpl value,
          $Res Function(_$StudentSemesterScheduleImpl) then) =
      __$$StudentSemesterScheduleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String semester, List<WeeklyScheduleEvent> weeklyEvents});
}

/// @nodoc
class __$$StudentSemesterScheduleImplCopyWithImpl<$Res>
    extends _$StudentSemesterScheduleCopyWithImpl<$Res,
        _$StudentSemesterScheduleImpl>
    implements _$$StudentSemesterScheduleImplCopyWith<$Res> {
  __$$StudentSemesterScheduleImplCopyWithImpl(
      _$StudentSemesterScheduleImpl _value,
      $Res Function(_$StudentSemesterScheduleImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? semester = null,
    Object? weeklyEvents = null,
  }) {
    return _then(_$StudentSemesterScheduleImpl(
      semester: null == semester
          ? _value.semester
          : semester // ignore: cast_nullable_to_non_nullable
              as String,
      weeklyEvents: null == weeklyEvents
          ? _value._weeklyEvents
          : weeklyEvents // ignore: cast_nullable_to_non_nullable
              as List<WeeklyScheduleEvent>,
    ));
  }
}

/// @nodoc

class _$StudentSemesterScheduleImpl implements _StudentSemesterSchedule {
  _$StudentSemesterScheduleImpl(
      {required this.semester,
      required final List<WeeklyScheduleEvent> weeklyEvents})
      : _weeklyEvents = weeklyEvents;

  @override
  final String semester;
// YYYYX where X is 1 or 2
// required List<GetClassScheduleModel> rawSchedule,
  final List<WeeklyScheduleEvent> _weeklyEvents;
// YYYYX where X is 1 or 2
// required List<GetClassScheduleModel> rawSchedule,
  @override
  List<WeeklyScheduleEvent> get weeklyEvents {
    if (_weeklyEvents is EqualUnmodifiableListView) return _weeklyEvents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_weeklyEvents);
  }

  @override
  String toString() {
    return 'StudentSemesterSchedule(semester: $semester, weeklyEvents: $weeklyEvents)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudentSemesterScheduleImpl &&
            (identical(other.semester, semester) ||
                other.semester == semester) &&
            const DeepCollectionEquality()
                .equals(other._weeklyEvents, _weeklyEvents));
  }

  @override
  int get hashCode => Object.hash(runtimeType, semester,
      const DeepCollectionEquality().hash(_weeklyEvents));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StudentSemesterScheduleImplCopyWith<_$StudentSemesterScheduleImpl>
      get copyWith => __$$StudentSemesterScheduleImplCopyWithImpl<
          _$StudentSemesterScheduleImpl>(this, _$identity);
}

abstract class _StudentSemesterSchedule implements StudentSemesterSchedule {
  factory _StudentSemesterSchedule(
          {required final String semester,
          required final List<WeeklyScheduleEvent> weeklyEvents}) =
      _$StudentSemesterScheduleImpl;

  @override
  String get semester;
  @override // YYYYX where X is 1 or 2
// required List<GetClassScheduleModel> rawSchedule,
  List<WeeklyScheduleEvent> get weeklyEvents;
  @override
  @JsonKey(ignore: true)
  _$$StudentSemesterScheduleImplCopyWith<_$StudentSemesterScheduleImpl>
      get copyWith => throw _privateConstructorUsedError;
}
