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
  List<SemesterScheduleSemesterMetadata> get semesterList =>
      throw _privateConstructorUsedError;
  SemesterScheduleSemesterMetadata get semester =>
      throw _privateConstructorUsedError;
  List<WeeklyScheduleEvent> get weeklyEvents =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
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
      {List<SemesterScheduleSemesterMetadata> semesterList,
      SemesterScheduleSemesterMetadata semester,
      List<WeeklyScheduleEvent> weeklyEvents});

  $SemesterScheduleSemesterMetadataCopyWith<$Res> get semester;
}

/// @nodoc
class _$SemesterScheduleCopyWithImpl<$Res, $Val extends SemesterSchedule>
    implements $SemesterScheduleCopyWith<$Res> {
  _$SemesterScheduleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? semesterList = null,
    Object? semester = null,
    Object? weeklyEvents = null,
  }) {
    return _then(_value.copyWith(
      semesterList: null == semesterList
          ? _value.semesterList
          : semesterList // ignore: cast_nullable_to_non_nullable
              as List<SemesterScheduleSemesterMetadata>,
      semester: null == semester
          ? _value.semester
          : semester // ignore: cast_nullable_to_non_nullable
              as SemesterScheduleSemesterMetadata,
      weeklyEvents: null == weeklyEvents
          ? _value.weeklyEvents
          : weeklyEvents // ignore: cast_nullable_to_non_nullable
              as List<WeeklyScheduleEvent>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SemesterScheduleSemesterMetadataCopyWith<$Res> get semester {
    return $SemesterScheduleSemesterMetadataCopyWith<$Res>(_value.semester,
        (value) {
      return _then(_value.copyWith(semester: value) as $Val);
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
      {List<SemesterScheduleSemesterMetadata> semesterList,
      SemesterScheduleSemesterMetadata semester,
      List<WeeklyScheduleEvent> weeklyEvents});

  @override
  $SemesterScheduleSemesterMetadataCopyWith<$Res> get semester;
}

/// @nodoc
class __$$SemesterScheduleImplCopyWithImpl<$Res>
    extends _$SemesterScheduleCopyWithImpl<$Res, _$SemesterScheduleImpl>
    implements _$$SemesterScheduleImplCopyWith<$Res> {
  __$$SemesterScheduleImplCopyWithImpl(_$SemesterScheduleImpl _value,
      $Res Function(_$SemesterScheduleImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? semesterList = null,
    Object? semester = null,
    Object? weeklyEvents = null,
  }) {
    return _then(_$SemesterScheduleImpl(
      semesterList: null == semesterList
          ? _value._semesterList
          : semesterList // ignore: cast_nullable_to_non_nullable
              as List<SemesterScheduleSemesterMetadata>,
      semester: null == semester
          ? _value.semester
          : semester // ignore: cast_nullable_to_non_nullable
              as SemesterScheduleSemesterMetadata,
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
      {required final List<SemesterScheduleSemesterMetadata> semesterList,
      required this.semester,
      required final List<WeeklyScheduleEvent> weeklyEvents})
      : _semesterList = semesterList,
        _weeklyEvents = weeklyEvents;

  final List<SemesterScheduleSemesterMetadata> _semesterList;
  @override
  List<SemesterScheduleSemesterMetadata> get semesterList {
    if (_semesterList is EqualUnmodifiableListView) return _semesterList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_semesterList);
  }

  @override
  final SemesterScheduleSemesterMetadata semester;
  final List<WeeklyScheduleEvent> _weeklyEvents;
  @override
  List<WeeklyScheduleEvent> get weeklyEvents {
    if (_weeklyEvents is EqualUnmodifiableListView) return _weeklyEvents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_weeklyEvents);
  }

  @override
  String toString() {
    return 'SemesterSchedule(semesterList: $semesterList, semester: $semester, weeklyEvents: $weeklyEvents)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SemesterScheduleImpl &&
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
      const DeepCollectionEquality().hash(_semesterList),
      semester,
      const DeepCollectionEquality().hash(_weeklyEvents));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SemesterScheduleImplCopyWith<_$SemesterScheduleImpl> get copyWith =>
      __$$SemesterScheduleImplCopyWithImpl<_$SemesterScheduleImpl>(
          this, _$identity);
}

abstract class _SemesterSchedule implements SemesterSchedule {
  factory _SemesterSchedule(
          {required final List<SemesterScheduleSemesterMetadata> semesterList,
          required final SemesterScheduleSemesterMetadata semester,
          required final List<WeeklyScheduleEvent> weeklyEvents}) =
      _$SemesterScheduleImpl;

  @override
  List<SemesterScheduleSemesterMetadata> get semesterList;
  @override
  SemesterScheduleSemesterMetadata get semester;
  @override
  List<WeeklyScheduleEvent> get weeklyEvents;
  @override
  @JsonKey(ignore: true)
  _$$SemesterScheduleImplCopyWith<_$SemesterScheduleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SemesterScheduleSemesterMetadata {
  String get id =>
      throw _privateConstructorUsedError; // YYYYX where X is from 0 to 2
  String get name => throw _privateConstructorUsedError;
  String get year => throw _privateConstructorUsedError;
  String get period => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SemesterScheduleSemesterMetadataCopyWith<SemesterScheduleSemesterMetadata>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SemesterScheduleSemesterMetadataCopyWith<$Res> {
  factory $SemesterScheduleSemesterMetadataCopyWith(
          SemesterScheduleSemesterMetadata value,
          $Res Function(SemesterScheduleSemesterMetadata) then) =
      _$SemesterScheduleSemesterMetadataCopyWithImpl<$Res,
          SemesterScheduleSemesterMetadata>;
  @useResult
  $Res call({String id, String name, String year, String period});
}

/// @nodoc
class _$SemesterScheduleSemesterMetadataCopyWithImpl<$Res,
        $Val extends SemesterScheduleSemesterMetadata>
    implements $SemesterScheduleSemesterMetadataCopyWith<$Res> {
  _$SemesterScheduleSemesterMetadataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? year = null,
    Object? period = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as String,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SemesterScheduleSemesterMetadataImplCopyWith<$Res>
    implements $SemesterScheduleSemesterMetadataCopyWith<$Res> {
  factory _$$SemesterScheduleSemesterMetadataImplCopyWith(
          _$SemesterScheduleSemesterMetadataImpl value,
          $Res Function(_$SemesterScheduleSemesterMetadataImpl) then) =
      __$$SemesterScheduleSemesterMetadataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String year, String period});
}

/// @nodoc
class __$$SemesterScheduleSemesterMetadataImplCopyWithImpl<$Res>
    extends _$SemesterScheduleSemesterMetadataCopyWithImpl<$Res,
        _$SemesterScheduleSemesterMetadataImpl>
    implements _$$SemesterScheduleSemesterMetadataImplCopyWith<$Res> {
  __$$SemesterScheduleSemesterMetadataImplCopyWithImpl(
      _$SemesterScheduleSemesterMetadataImpl _value,
      $Res Function(_$SemesterScheduleSemesterMetadataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? year = null,
    Object? period = null,
  }) {
    return _then(_$SemesterScheduleSemesterMetadataImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as String,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SemesterScheduleSemesterMetadataImpl
    implements _SemesterScheduleSemesterMetadata {
  _$SemesterScheduleSemesterMetadataImpl(
      {required this.id,
      required this.name,
      required this.year,
      required this.period});

  @override
  final String id;
// YYYYX where X is from 0 to 2
  @override
  final String name;
  @override
  final String year;
  @override
  final String period;

  @override
  String toString() {
    return 'SemesterScheduleSemesterMetadata(id: $id, name: $name, year: $year, period: $period)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SemesterScheduleSemesterMetadataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.period, period) || other.period == period));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, year, period);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SemesterScheduleSemesterMetadataImplCopyWith<
          _$SemesterScheduleSemesterMetadataImpl>
      get copyWith => __$$SemesterScheduleSemesterMetadataImplCopyWithImpl<
          _$SemesterScheduleSemesterMetadataImpl>(this, _$identity);
}

abstract class _SemesterScheduleSemesterMetadata
    implements SemesterScheduleSemesterMetadata {
  factory _SemesterScheduleSemesterMetadata(
      {required final String id,
      required final String name,
      required final String year,
      required final String period}) = _$SemesterScheduleSemesterMetadataImpl;

  @override
  String get id;
  @override // YYYYX where X is from 0 to 2
  String get name;
  @override
  String get year;
  @override
  String get period;
  @override
  @JsonKey(ignore: true)
  _$$SemesterScheduleSemesterMetadataImplCopyWith<
          _$SemesterScheduleSemesterMetadataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
