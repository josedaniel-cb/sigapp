// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course_detail_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CourseDetailState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() empty,
    required TResult Function(
            EnrolledCourse course,
            String regevaScheduledCourseId,
            CourseDetailSyllabusState syllabus,
            CourseDetailGradesState grades)
        ready,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? empty,
    TResult? Function(EnrolledCourse course, String regevaScheduledCourseId,
            CourseDetailSyllabusState syllabus, CourseDetailGradesState grades)?
        ready,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? empty,
    TResult Function(EnrolledCourse course, String regevaScheduledCourseId,
            CourseDetailSyllabusState syllabus, CourseDetailGradesState grades)?
        ready,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CourseDetailEmptyState value) empty,
    required TResult Function(CourseDetailReadyState value) ready,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CourseDetailEmptyState value)? empty,
    TResult? Function(CourseDetailReadyState value)? ready,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CourseDetailEmptyState value)? empty,
    TResult Function(CourseDetailReadyState value)? ready,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CourseDetailStateCopyWith<$Res> {
  factory $CourseDetailStateCopyWith(
          CourseDetailState value, $Res Function(CourseDetailState) then) =
      _$CourseDetailStateCopyWithImpl<$Res, CourseDetailState>;
}

/// @nodoc
class _$CourseDetailStateCopyWithImpl<$Res, $Val extends CourseDetailState>
    implements $CourseDetailStateCopyWith<$Res> {
  _$CourseDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CourseDetailState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$CourseDetailEmptyStateImplCopyWith<$Res> {
  factory _$$CourseDetailEmptyStateImplCopyWith(
          _$CourseDetailEmptyStateImpl value,
          $Res Function(_$CourseDetailEmptyStateImpl) then) =
      __$$CourseDetailEmptyStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CourseDetailEmptyStateImplCopyWithImpl<$Res>
    extends _$CourseDetailStateCopyWithImpl<$Res, _$CourseDetailEmptyStateImpl>
    implements _$$CourseDetailEmptyStateImplCopyWith<$Res> {
  __$$CourseDetailEmptyStateImplCopyWithImpl(
      _$CourseDetailEmptyStateImpl _value,
      $Res Function(_$CourseDetailEmptyStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CourseDetailState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CourseDetailEmptyStateImpl
    with DiagnosticableTreeMixin
    implements CourseDetailEmptyState {
  const _$CourseDetailEmptyStateImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CourseDetailState.empty()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'CourseDetailState.empty'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CourseDetailEmptyStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() empty,
    required TResult Function(
            EnrolledCourse course,
            String regevaScheduledCourseId,
            CourseDetailSyllabusState syllabus,
            CourseDetailGradesState grades)
        ready,
  }) {
    return empty();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? empty,
    TResult? Function(EnrolledCourse course, String regevaScheduledCourseId,
            CourseDetailSyllabusState syllabus, CourseDetailGradesState grades)?
        ready,
  }) {
    return empty?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? empty,
    TResult Function(EnrolledCourse course, String regevaScheduledCourseId,
            CourseDetailSyllabusState syllabus, CourseDetailGradesState grades)?
        ready,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CourseDetailEmptyState value) empty,
    required TResult Function(CourseDetailReadyState value) ready,
  }) {
    return empty(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CourseDetailEmptyState value)? empty,
    TResult? Function(CourseDetailReadyState value)? ready,
  }) {
    return empty?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CourseDetailEmptyState value)? empty,
    TResult Function(CourseDetailReadyState value)? ready,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(this);
    }
    return orElse();
  }
}

abstract class CourseDetailEmptyState implements CourseDetailState {
  const factory CourseDetailEmptyState() = _$CourseDetailEmptyStateImpl;
}

/// @nodoc
abstract class _$$CourseDetailReadyStateImplCopyWith<$Res> {
  factory _$$CourseDetailReadyStateImplCopyWith(
          _$CourseDetailReadyStateImpl value,
          $Res Function(_$CourseDetailReadyStateImpl) then) =
      __$$CourseDetailReadyStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {EnrolledCourse course,
      String regevaScheduledCourseId,
      CourseDetailSyllabusState syllabus,
      CourseDetailGradesState grades});

  $CourseDetailSyllabusStateCopyWith<$Res> get syllabus;
  $CourseDetailGradesStateCopyWith<$Res> get grades;
}

/// @nodoc
class __$$CourseDetailReadyStateImplCopyWithImpl<$Res>
    extends _$CourseDetailStateCopyWithImpl<$Res, _$CourseDetailReadyStateImpl>
    implements _$$CourseDetailReadyStateImplCopyWith<$Res> {
  __$$CourseDetailReadyStateImplCopyWithImpl(
      _$CourseDetailReadyStateImpl _value,
      $Res Function(_$CourseDetailReadyStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CourseDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? course = null,
    Object? regevaScheduledCourseId = null,
    Object? syllabus = null,
    Object? grades = null,
  }) {
    return _then(_$CourseDetailReadyStateImpl(
      course: null == course
          ? _value.course
          : course // ignore: cast_nullable_to_non_nullable
              as EnrolledCourse,
      regevaScheduledCourseId: null == regevaScheduledCourseId
          ? _value.regevaScheduledCourseId
          : regevaScheduledCourseId // ignore: cast_nullable_to_non_nullable
              as String,
      syllabus: null == syllabus
          ? _value.syllabus
          : syllabus // ignore: cast_nullable_to_non_nullable
              as CourseDetailSyllabusState,
      grades: null == grades
          ? _value.grades
          : grades // ignore: cast_nullable_to_non_nullable
              as CourseDetailGradesState,
    ));
  }

  /// Create a copy of CourseDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CourseDetailSyllabusStateCopyWith<$Res> get syllabus {
    return $CourseDetailSyllabusStateCopyWith<$Res>(_value.syllabus, (value) {
      return _then(_value.copyWith(syllabus: value));
    });
  }

  /// Create a copy of CourseDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CourseDetailGradesStateCopyWith<$Res> get grades {
    return $CourseDetailGradesStateCopyWith<$Res>(_value.grades, (value) {
      return _then(_value.copyWith(grades: value));
    });
  }
}

/// @nodoc

class _$CourseDetailReadyStateImpl
    with DiagnosticableTreeMixin
    implements CourseDetailReadyState {
  const _$CourseDetailReadyStateImpl(
      {required this.course,
      required this.regevaScheduledCourseId,
      required this.syllabus,
      required this.grades});

  @override
  final EnrolledCourse course;
  @override
  final String regevaScheduledCourseId;
  @override
  final CourseDetailSyllabusState syllabus;
  @override
  final CourseDetailGradesState grades;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CourseDetailState.ready(course: $course, regevaScheduledCourseId: $regevaScheduledCourseId, syllabus: $syllabus, grades: $grades)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CourseDetailState.ready'))
      ..add(DiagnosticsProperty('course', course))
      ..add(DiagnosticsProperty(
          'regevaScheduledCourseId', regevaScheduledCourseId))
      ..add(DiagnosticsProperty('syllabus', syllabus))
      ..add(DiagnosticsProperty('grades', grades));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CourseDetailReadyStateImpl &&
            (identical(other.course, course) || other.course == course) &&
            (identical(
                    other.regevaScheduledCourseId, regevaScheduledCourseId) ||
                other.regevaScheduledCourseId == regevaScheduledCourseId) &&
            (identical(other.syllabus, syllabus) ||
                other.syllabus == syllabus) &&
            (identical(other.grades, grades) || other.grades == grades));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, course, regevaScheduledCourseId, syllabus, grades);

  /// Create a copy of CourseDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CourseDetailReadyStateImplCopyWith<_$CourseDetailReadyStateImpl>
      get copyWith => __$$CourseDetailReadyStateImplCopyWithImpl<
          _$CourseDetailReadyStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() empty,
    required TResult Function(
            EnrolledCourse course,
            String regevaScheduledCourseId,
            CourseDetailSyllabusState syllabus,
            CourseDetailGradesState grades)
        ready,
  }) {
    return ready(course, regevaScheduledCourseId, syllabus, grades);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? empty,
    TResult? Function(EnrolledCourse course, String regevaScheduledCourseId,
            CourseDetailSyllabusState syllabus, CourseDetailGradesState grades)?
        ready,
  }) {
    return ready?.call(course, regevaScheduledCourseId, syllabus, grades);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? empty,
    TResult Function(EnrolledCourse course, String regevaScheduledCourseId,
            CourseDetailSyllabusState syllabus, CourseDetailGradesState grades)?
        ready,
    required TResult orElse(),
  }) {
    if (ready != null) {
      return ready(course, regevaScheduledCourseId, syllabus, grades);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CourseDetailEmptyState value) empty,
    required TResult Function(CourseDetailReadyState value) ready,
  }) {
    return ready(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CourseDetailEmptyState value)? empty,
    TResult? Function(CourseDetailReadyState value)? ready,
  }) {
    return ready?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CourseDetailEmptyState value)? empty,
    TResult Function(CourseDetailReadyState value)? ready,
    required TResult orElse(),
  }) {
    if (ready != null) {
      return ready(this);
    }
    return orElse();
  }
}

abstract class CourseDetailReadyState implements CourseDetailState {
  const factory CourseDetailReadyState(
          {required final EnrolledCourse course,
          required final String regevaScheduledCourseId,
          required final CourseDetailSyllabusState syllabus,
          required final CourseDetailGradesState grades}) =
      _$CourseDetailReadyStateImpl;

  EnrolledCourse get course;
  String get regevaScheduledCourseId;
  CourseDetailSyllabusState get syllabus;
  CourseDetailGradesState get grades;

  /// Create a copy of CourseDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CourseDetailReadyStateImplCopyWith<_$CourseDetailReadyStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CourseDetailSyllabusState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(File syllabusFile) loaded,
    required TResult Function() notFound,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(File syllabusFile)? loaded,
    TResult? Function()? notFound,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(File syllabusFile)? loaded,
    TResult Function()? notFound,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CourseDetailSyllabusStateInitial value) initial,
    required TResult Function(_CourseDetailSyllabusStateLoading value) loading,
    required TResult Function(_CourseDetailSyllabusStateLoaded value) loaded,
    required TResult Function(_CourseDetailSyllabusStateNotFound value)
        notFound,
    required TResult Function(_CourseDetailSyllabusStateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CourseDetailSyllabusStateInitial value)? initial,
    TResult? Function(_CourseDetailSyllabusStateLoading value)? loading,
    TResult? Function(_CourseDetailSyllabusStateLoaded value)? loaded,
    TResult? Function(_CourseDetailSyllabusStateNotFound value)? notFound,
    TResult? Function(_CourseDetailSyllabusStateError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CourseDetailSyllabusStateInitial value)? initial,
    TResult Function(_CourseDetailSyllabusStateLoading value)? loading,
    TResult Function(_CourseDetailSyllabusStateLoaded value)? loaded,
    TResult Function(_CourseDetailSyllabusStateNotFound value)? notFound,
    TResult Function(_CourseDetailSyllabusStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CourseDetailSyllabusStateCopyWith<$Res> {
  factory $CourseDetailSyllabusStateCopyWith(CourseDetailSyllabusState value,
          $Res Function(CourseDetailSyllabusState) then) =
      _$CourseDetailSyllabusStateCopyWithImpl<$Res, CourseDetailSyllabusState>;
}

/// @nodoc
class _$CourseDetailSyllabusStateCopyWithImpl<$Res,
        $Val extends CourseDetailSyllabusState>
    implements $CourseDetailSyllabusStateCopyWith<$Res> {
  _$CourseDetailSyllabusStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CourseDetailSyllabusState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$CourseDetailSyllabusStateInitialImplCopyWith<$Res> {
  factory _$$CourseDetailSyllabusStateInitialImplCopyWith(
          _$CourseDetailSyllabusStateInitialImpl value,
          $Res Function(_$CourseDetailSyllabusStateInitialImpl) then) =
      __$$CourseDetailSyllabusStateInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CourseDetailSyllabusStateInitialImplCopyWithImpl<$Res>
    extends _$CourseDetailSyllabusStateCopyWithImpl<$Res,
        _$CourseDetailSyllabusStateInitialImpl>
    implements _$$CourseDetailSyllabusStateInitialImplCopyWith<$Res> {
  __$$CourseDetailSyllabusStateInitialImplCopyWithImpl(
      _$CourseDetailSyllabusStateInitialImpl _value,
      $Res Function(_$CourseDetailSyllabusStateInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of CourseDetailSyllabusState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CourseDetailSyllabusStateInitialImpl
    with DiagnosticableTreeMixin
    implements _CourseDetailSyllabusStateInitial {
  const _$CourseDetailSyllabusStateInitialImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CourseDetailSyllabusState.initial()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CourseDetailSyllabusState.initial'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CourseDetailSyllabusStateInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(File syllabusFile) loaded,
    required TResult Function() notFound,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(File syllabusFile)? loaded,
    TResult? Function()? notFound,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(File syllabusFile)? loaded,
    TResult Function()? notFound,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CourseDetailSyllabusStateInitial value) initial,
    required TResult Function(_CourseDetailSyllabusStateLoading value) loading,
    required TResult Function(_CourseDetailSyllabusStateLoaded value) loaded,
    required TResult Function(_CourseDetailSyllabusStateNotFound value)
        notFound,
    required TResult Function(_CourseDetailSyllabusStateError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CourseDetailSyllabusStateInitial value)? initial,
    TResult? Function(_CourseDetailSyllabusStateLoading value)? loading,
    TResult? Function(_CourseDetailSyllabusStateLoaded value)? loaded,
    TResult? Function(_CourseDetailSyllabusStateNotFound value)? notFound,
    TResult? Function(_CourseDetailSyllabusStateError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CourseDetailSyllabusStateInitial value)? initial,
    TResult Function(_CourseDetailSyllabusStateLoading value)? loading,
    TResult Function(_CourseDetailSyllabusStateLoaded value)? loaded,
    TResult Function(_CourseDetailSyllabusStateNotFound value)? notFound,
    TResult Function(_CourseDetailSyllabusStateError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _CourseDetailSyllabusStateInitial
    implements CourseDetailSyllabusState {
  const factory _CourseDetailSyllabusStateInitial() =
      _$CourseDetailSyllabusStateInitialImpl;
}

/// @nodoc
abstract class _$$CourseDetailSyllabusStateLoadingImplCopyWith<$Res> {
  factory _$$CourseDetailSyllabusStateLoadingImplCopyWith(
          _$CourseDetailSyllabusStateLoadingImpl value,
          $Res Function(_$CourseDetailSyllabusStateLoadingImpl) then) =
      __$$CourseDetailSyllabusStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CourseDetailSyllabusStateLoadingImplCopyWithImpl<$Res>
    extends _$CourseDetailSyllabusStateCopyWithImpl<$Res,
        _$CourseDetailSyllabusStateLoadingImpl>
    implements _$$CourseDetailSyllabusStateLoadingImplCopyWith<$Res> {
  __$$CourseDetailSyllabusStateLoadingImplCopyWithImpl(
      _$CourseDetailSyllabusStateLoadingImpl _value,
      $Res Function(_$CourseDetailSyllabusStateLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of CourseDetailSyllabusState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CourseDetailSyllabusStateLoadingImpl
    with DiagnosticableTreeMixin
    implements _CourseDetailSyllabusStateLoading {
  const _$CourseDetailSyllabusStateLoadingImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CourseDetailSyllabusState.loading()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CourseDetailSyllabusState.loading'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CourseDetailSyllabusStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(File syllabusFile) loaded,
    required TResult Function() notFound,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(File syllabusFile)? loaded,
    TResult? Function()? notFound,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(File syllabusFile)? loaded,
    TResult Function()? notFound,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CourseDetailSyllabusStateInitial value) initial,
    required TResult Function(_CourseDetailSyllabusStateLoading value) loading,
    required TResult Function(_CourseDetailSyllabusStateLoaded value) loaded,
    required TResult Function(_CourseDetailSyllabusStateNotFound value)
        notFound,
    required TResult Function(_CourseDetailSyllabusStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CourseDetailSyllabusStateInitial value)? initial,
    TResult? Function(_CourseDetailSyllabusStateLoading value)? loading,
    TResult? Function(_CourseDetailSyllabusStateLoaded value)? loaded,
    TResult? Function(_CourseDetailSyllabusStateNotFound value)? notFound,
    TResult? Function(_CourseDetailSyllabusStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CourseDetailSyllabusStateInitial value)? initial,
    TResult Function(_CourseDetailSyllabusStateLoading value)? loading,
    TResult Function(_CourseDetailSyllabusStateLoaded value)? loaded,
    TResult Function(_CourseDetailSyllabusStateNotFound value)? notFound,
    TResult Function(_CourseDetailSyllabusStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _CourseDetailSyllabusStateLoading
    implements CourseDetailSyllabusState {
  const factory _CourseDetailSyllabusStateLoading() =
      _$CourseDetailSyllabusStateLoadingImpl;
}

/// @nodoc
abstract class _$$CourseDetailSyllabusStateLoadedImplCopyWith<$Res> {
  factory _$$CourseDetailSyllabusStateLoadedImplCopyWith(
          _$CourseDetailSyllabusStateLoadedImpl value,
          $Res Function(_$CourseDetailSyllabusStateLoadedImpl) then) =
      __$$CourseDetailSyllabusStateLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({File syllabusFile});
}

/// @nodoc
class __$$CourseDetailSyllabusStateLoadedImplCopyWithImpl<$Res>
    extends _$CourseDetailSyllabusStateCopyWithImpl<$Res,
        _$CourseDetailSyllabusStateLoadedImpl>
    implements _$$CourseDetailSyllabusStateLoadedImplCopyWith<$Res> {
  __$$CourseDetailSyllabusStateLoadedImplCopyWithImpl(
      _$CourseDetailSyllabusStateLoadedImpl _value,
      $Res Function(_$CourseDetailSyllabusStateLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of CourseDetailSyllabusState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? syllabusFile = null,
  }) {
    return _then(_$CourseDetailSyllabusStateLoadedImpl(
      null == syllabusFile
          ? _value.syllabusFile
          : syllabusFile // ignore: cast_nullable_to_non_nullable
              as File,
    ));
  }
}

/// @nodoc

class _$CourseDetailSyllabusStateLoadedImpl
    with DiagnosticableTreeMixin
    implements _CourseDetailSyllabusStateLoaded {
  const _$CourseDetailSyllabusStateLoadedImpl(this.syllabusFile);

  @override
  final File syllabusFile;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CourseDetailSyllabusState.loaded(syllabusFile: $syllabusFile)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CourseDetailSyllabusState.loaded'))
      ..add(DiagnosticsProperty('syllabusFile', syllabusFile));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CourseDetailSyllabusStateLoadedImpl &&
            (identical(other.syllabusFile, syllabusFile) ||
                other.syllabusFile == syllabusFile));
  }

  @override
  int get hashCode => Object.hash(runtimeType, syllabusFile);

  /// Create a copy of CourseDetailSyllabusState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CourseDetailSyllabusStateLoadedImplCopyWith<
          _$CourseDetailSyllabusStateLoadedImpl>
      get copyWith => __$$CourseDetailSyllabusStateLoadedImplCopyWithImpl<
          _$CourseDetailSyllabusStateLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(File syllabusFile) loaded,
    required TResult Function() notFound,
    required TResult Function(String message) error,
  }) {
    return loaded(syllabusFile);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(File syllabusFile)? loaded,
    TResult? Function()? notFound,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(syllabusFile);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(File syllabusFile)? loaded,
    TResult Function()? notFound,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(syllabusFile);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CourseDetailSyllabusStateInitial value) initial,
    required TResult Function(_CourseDetailSyllabusStateLoading value) loading,
    required TResult Function(_CourseDetailSyllabusStateLoaded value) loaded,
    required TResult Function(_CourseDetailSyllabusStateNotFound value)
        notFound,
    required TResult Function(_CourseDetailSyllabusStateError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CourseDetailSyllabusStateInitial value)? initial,
    TResult? Function(_CourseDetailSyllabusStateLoading value)? loading,
    TResult? Function(_CourseDetailSyllabusStateLoaded value)? loaded,
    TResult? Function(_CourseDetailSyllabusStateNotFound value)? notFound,
    TResult? Function(_CourseDetailSyllabusStateError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CourseDetailSyllabusStateInitial value)? initial,
    TResult Function(_CourseDetailSyllabusStateLoading value)? loading,
    TResult Function(_CourseDetailSyllabusStateLoaded value)? loaded,
    TResult Function(_CourseDetailSyllabusStateNotFound value)? notFound,
    TResult Function(_CourseDetailSyllabusStateError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _CourseDetailSyllabusStateLoaded
    implements CourseDetailSyllabusState {
  const factory _CourseDetailSyllabusStateLoaded(final File syllabusFile) =
      _$CourseDetailSyllabusStateLoadedImpl;

  File get syllabusFile;

  /// Create a copy of CourseDetailSyllabusState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CourseDetailSyllabusStateLoadedImplCopyWith<
          _$CourseDetailSyllabusStateLoadedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CourseDetailSyllabusStateNotFoundImplCopyWith<$Res> {
  factory _$$CourseDetailSyllabusStateNotFoundImplCopyWith(
          _$CourseDetailSyllabusStateNotFoundImpl value,
          $Res Function(_$CourseDetailSyllabusStateNotFoundImpl) then) =
      __$$CourseDetailSyllabusStateNotFoundImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CourseDetailSyllabusStateNotFoundImplCopyWithImpl<$Res>
    extends _$CourseDetailSyllabusStateCopyWithImpl<$Res,
        _$CourseDetailSyllabusStateNotFoundImpl>
    implements _$$CourseDetailSyllabusStateNotFoundImplCopyWith<$Res> {
  __$$CourseDetailSyllabusStateNotFoundImplCopyWithImpl(
      _$CourseDetailSyllabusStateNotFoundImpl _value,
      $Res Function(_$CourseDetailSyllabusStateNotFoundImpl) _then)
      : super(_value, _then);

  /// Create a copy of CourseDetailSyllabusState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CourseDetailSyllabusStateNotFoundImpl
    with DiagnosticableTreeMixin
    implements _CourseDetailSyllabusStateNotFound {
  const _$CourseDetailSyllabusStateNotFoundImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CourseDetailSyllabusState.notFound()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CourseDetailSyllabusState.notFound'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CourseDetailSyllabusStateNotFoundImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(File syllabusFile) loaded,
    required TResult Function() notFound,
    required TResult Function(String message) error,
  }) {
    return notFound();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(File syllabusFile)? loaded,
    TResult? Function()? notFound,
    TResult? Function(String message)? error,
  }) {
    return notFound?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(File syllabusFile)? loaded,
    TResult Function()? notFound,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (notFound != null) {
      return notFound();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CourseDetailSyllabusStateInitial value) initial,
    required TResult Function(_CourseDetailSyllabusStateLoading value) loading,
    required TResult Function(_CourseDetailSyllabusStateLoaded value) loaded,
    required TResult Function(_CourseDetailSyllabusStateNotFound value)
        notFound,
    required TResult Function(_CourseDetailSyllabusStateError value) error,
  }) {
    return notFound(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CourseDetailSyllabusStateInitial value)? initial,
    TResult? Function(_CourseDetailSyllabusStateLoading value)? loading,
    TResult? Function(_CourseDetailSyllabusStateLoaded value)? loaded,
    TResult? Function(_CourseDetailSyllabusStateNotFound value)? notFound,
    TResult? Function(_CourseDetailSyllabusStateError value)? error,
  }) {
    return notFound?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CourseDetailSyllabusStateInitial value)? initial,
    TResult Function(_CourseDetailSyllabusStateLoading value)? loading,
    TResult Function(_CourseDetailSyllabusStateLoaded value)? loaded,
    TResult Function(_CourseDetailSyllabusStateNotFound value)? notFound,
    TResult Function(_CourseDetailSyllabusStateError value)? error,
    required TResult orElse(),
  }) {
    if (notFound != null) {
      return notFound(this);
    }
    return orElse();
  }
}

abstract class _CourseDetailSyllabusStateNotFound
    implements CourseDetailSyllabusState {
  const factory _CourseDetailSyllabusStateNotFound() =
      _$CourseDetailSyllabusStateNotFoundImpl;
}

/// @nodoc
abstract class _$$CourseDetailSyllabusStateErrorImplCopyWith<$Res> {
  factory _$$CourseDetailSyllabusStateErrorImplCopyWith(
          _$CourseDetailSyllabusStateErrorImpl value,
          $Res Function(_$CourseDetailSyllabusStateErrorImpl) then) =
      __$$CourseDetailSyllabusStateErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$CourseDetailSyllabusStateErrorImplCopyWithImpl<$Res>
    extends _$CourseDetailSyllabusStateCopyWithImpl<$Res,
        _$CourseDetailSyllabusStateErrorImpl>
    implements _$$CourseDetailSyllabusStateErrorImplCopyWith<$Res> {
  __$$CourseDetailSyllabusStateErrorImplCopyWithImpl(
      _$CourseDetailSyllabusStateErrorImpl _value,
      $Res Function(_$CourseDetailSyllabusStateErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of CourseDetailSyllabusState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$CourseDetailSyllabusStateErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CourseDetailSyllabusStateErrorImpl
    with DiagnosticableTreeMixin
    implements _CourseDetailSyllabusStateError {
  const _$CourseDetailSyllabusStateErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CourseDetailSyllabusState.error(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CourseDetailSyllabusState.error'))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CourseDetailSyllabusStateErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of CourseDetailSyllabusState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CourseDetailSyllabusStateErrorImplCopyWith<
          _$CourseDetailSyllabusStateErrorImpl>
      get copyWith => __$$CourseDetailSyllabusStateErrorImplCopyWithImpl<
          _$CourseDetailSyllabusStateErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(File syllabusFile) loaded,
    required TResult Function() notFound,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(File syllabusFile)? loaded,
    TResult? Function()? notFound,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(File syllabusFile)? loaded,
    TResult Function()? notFound,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CourseDetailSyllabusStateInitial value) initial,
    required TResult Function(_CourseDetailSyllabusStateLoading value) loading,
    required TResult Function(_CourseDetailSyllabusStateLoaded value) loaded,
    required TResult Function(_CourseDetailSyllabusStateNotFound value)
        notFound,
    required TResult Function(_CourseDetailSyllabusStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CourseDetailSyllabusStateInitial value)? initial,
    TResult? Function(_CourseDetailSyllabusStateLoading value)? loading,
    TResult? Function(_CourseDetailSyllabusStateLoaded value)? loaded,
    TResult? Function(_CourseDetailSyllabusStateNotFound value)? notFound,
    TResult? Function(_CourseDetailSyllabusStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CourseDetailSyllabusStateInitial value)? initial,
    TResult Function(_CourseDetailSyllabusStateLoading value)? loading,
    TResult Function(_CourseDetailSyllabusStateLoaded value)? loaded,
    TResult Function(_CourseDetailSyllabusStateNotFound value)? notFound,
    TResult Function(_CourseDetailSyllabusStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _CourseDetailSyllabusStateError
    implements CourseDetailSyllabusState {
  const factory _CourseDetailSyllabusStateError(final String message) =
      _$CourseDetailSyllabusStateErrorImpl;

  String get message;

  /// Create a copy of CourseDetailSyllabusState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CourseDetailSyllabusStateErrorImplCopyWith<
          _$CourseDetailSyllabusStateErrorImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CourseDetailGradesState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(CourseGradeInfo value) loaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(CourseGradeInfo value)? loaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(CourseGradeInfo value)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CourseDetailGradesStateInitial value) initial,
    required TResult Function(_CourseDetailGradesStateLoading value) loading,
    required TResult Function(_CourseDetailGradesStateLoaded value) loaded,
    required TResult Function(_CourseDetailGradesStateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CourseDetailGradesStateInitial value)? initial,
    TResult? Function(_CourseDetailGradesStateLoading value)? loading,
    TResult? Function(_CourseDetailGradesStateLoaded value)? loaded,
    TResult? Function(_CourseDetailGradesStateError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CourseDetailGradesStateInitial value)? initial,
    TResult Function(_CourseDetailGradesStateLoading value)? loading,
    TResult Function(_CourseDetailGradesStateLoaded value)? loaded,
    TResult Function(_CourseDetailGradesStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CourseDetailGradesStateCopyWith<$Res> {
  factory $CourseDetailGradesStateCopyWith(CourseDetailGradesState value,
          $Res Function(CourseDetailGradesState) then) =
      _$CourseDetailGradesStateCopyWithImpl<$Res, CourseDetailGradesState>;
}

/// @nodoc
class _$CourseDetailGradesStateCopyWithImpl<$Res,
        $Val extends CourseDetailGradesState>
    implements $CourseDetailGradesStateCopyWith<$Res> {
  _$CourseDetailGradesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CourseDetailGradesState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$CourseDetailGradesStateInitialImplCopyWith<$Res> {
  factory _$$CourseDetailGradesStateInitialImplCopyWith(
          _$CourseDetailGradesStateInitialImpl value,
          $Res Function(_$CourseDetailGradesStateInitialImpl) then) =
      __$$CourseDetailGradesStateInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CourseDetailGradesStateInitialImplCopyWithImpl<$Res>
    extends _$CourseDetailGradesStateCopyWithImpl<$Res,
        _$CourseDetailGradesStateInitialImpl>
    implements _$$CourseDetailGradesStateInitialImplCopyWith<$Res> {
  __$$CourseDetailGradesStateInitialImplCopyWithImpl(
      _$CourseDetailGradesStateInitialImpl _value,
      $Res Function(_$CourseDetailGradesStateInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of CourseDetailGradesState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CourseDetailGradesStateInitialImpl
    with DiagnosticableTreeMixin
    implements _CourseDetailGradesStateInitial {
  const _$CourseDetailGradesStateInitialImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CourseDetailGradesState.initial()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CourseDetailGradesState.initial'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CourseDetailGradesStateInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(CourseGradeInfo value) loaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(CourseGradeInfo value)? loaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(CourseGradeInfo value)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CourseDetailGradesStateInitial value) initial,
    required TResult Function(_CourseDetailGradesStateLoading value) loading,
    required TResult Function(_CourseDetailGradesStateLoaded value) loaded,
    required TResult Function(_CourseDetailGradesStateError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CourseDetailGradesStateInitial value)? initial,
    TResult? Function(_CourseDetailGradesStateLoading value)? loading,
    TResult? Function(_CourseDetailGradesStateLoaded value)? loaded,
    TResult? Function(_CourseDetailGradesStateError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CourseDetailGradesStateInitial value)? initial,
    TResult Function(_CourseDetailGradesStateLoading value)? loading,
    TResult Function(_CourseDetailGradesStateLoaded value)? loaded,
    TResult Function(_CourseDetailGradesStateError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _CourseDetailGradesStateInitial
    implements CourseDetailGradesState {
  const factory _CourseDetailGradesStateInitial() =
      _$CourseDetailGradesStateInitialImpl;
}

/// @nodoc
abstract class _$$CourseDetailGradesStateLoadingImplCopyWith<$Res> {
  factory _$$CourseDetailGradesStateLoadingImplCopyWith(
          _$CourseDetailGradesStateLoadingImpl value,
          $Res Function(_$CourseDetailGradesStateLoadingImpl) then) =
      __$$CourseDetailGradesStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CourseDetailGradesStateLoadingImplCopyWithImpl<$Res>
    extends _$CourseDetailGradesStateCopyWithImpl<$Res,
        _$CourseDetailGradesStateLoadingImpl>
    implements _$$CourseDetailGradesStateLoadingImplCopyWith<$Res> {
  __$$CourseDetailGradesStateLoadingImplCopyWithImpl(
      _$CourseDetailGradesStateLoadingImpl _value,
      $Res Function(_$CourseDetailGradesStateLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of CourseDetailGradesState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CourseDetailGradesStateLoadingImpl
    with DiagnosticableTreeMixin
    implements _CourseDetailGradesStateLoading {
  const _$CourseDetailGradesStateLoadingImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CourseDetailGradesState.loading()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CourseDetailGradesState.loading'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CourseDetailGradesStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(CourseGradeInfo value) loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(CourseGradeInfo value)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(CourseGradeInfo value)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CourseDetailGradesStateInitial value) initial,
    required TResult Function(_CourseDetailGradesStateLoading value) loading,
    required TResult Function(_CourseDetailGradesStateLoaded value) loaded,
    required TResult Function(_CourseDetailGradesStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CourseDetailGradesStateInitial value)? initial,
    TResult? Function(_CourseDetailGradesStateLoading value)? loading,
    TResult? Function(_CourseDetailGradesStateLoaded value)? loaded,
    TResult? Function(_CourseDetailGradesStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CourseDetailGradesStateInitial value)? initial,
    TResult Function(_CourseDetailGradesStateLoading value)? loading,
    TResult Function(_CourseDetailGradesStateLoaded value)? loaded,
    TResult Function(_CourseDetailGradesStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _CourseDetailGradesStateLoading
    implements CourseDetailGradesState {
  const factory _CourseDetailGradesStateLoading() =
      _$CourseDetailGradesStateLoadingImpl;
}

/// @nodoc
abstract class _$$CourseDetailGradesStateLoadedImplCopyWith<$Res> {
  factory _$$CourseDetailGradesStateLoadedImplCopyWith(
          _$CourseDetailGradesStateLoadedImpl value,
          $Res Function(_$CourseDetailGradesStateLoadedImpl) then) =
      __$$CourseDetailGradesStateLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({CourseGradeInfo value});
}

/// @nodoc
class __$$CourseDetailGradesStateLoadedImplCopyWithImpl<$Res>
    extends _$CourseDetailGradesStateCopyWithImpl<$Res,
        _$CourseDetailGradesStateLoadedImpl>
    implements _$$CourseDetailGradesStateLoadedImplCopyWith<$Res> {
  __$$CourseDetailGradesStateLoadedImplCopyWithImpl(
      _$CourseDetailGradesStateLoadedImpl _value,
      $Res Function(_$CourseDetailGradesStateLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of CourseDetailGradesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$CourseDetailGradesStateLoadedImpl(
      null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as CourseGradeInfo,
    ));
  }
}

/// @nodoc

class _$CourseDetailGradesStateLoadedImpl
    with DiagnosticableTreeMixin
    implements _CourseDetailGradesStateLoaded {
  const _$CourseDetailGradesStateLoadedImpl(this.value);

  @override
  final CourseGradeInfo value;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CourseDetailGradesState.loaded(value: $value)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CourseDetailGradesState.loaded'))
      ..add(DiagnosticsProperty('value', value));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CourseDetailGradesStateLoadedImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  /// Create a copy of CourseDetailGradesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CourseDetailGradesStateLoadedImplCopyWith<
          _$CourseDetailGradesStateLoadedImpl>
      get copyWith => __$$CourseDetailGradesStateLoadedImplCopyWithImpl<
          _$CourseDetailGradesStateLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(CourseGradeInfo value) loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(CourseGradeInfo value)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(CourseGradeInfo value)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CourseDetailGradesStateInitial value) initial,
    required TResult Function(_CourseDetailGradesStateLoading value) loading,
    required TResult Function(_CourseDetailGradesStateLoaded value) loaded,
    required TResult Function(_CourseDetailGradesStateError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CourseDetailGradesStateInitial value)? initial,
    TResult? Function(_CourseDetailGradesStateLoading value)? loading,
    TResult? Function(_CourseDetailGradesStateLoaded value)? loaded,
    TResult? Function(_CourseDetailGradesStateError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CourseDetailGradesStateInitial value)? initial,
    TResult Function(_CourseDetailGradesStateLoading value)? loading,
    TResult Function(_CourseDetailGradesStateLoaded value)? loaded,
    TResult Function(_CourseDetailGradesStateError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _CourseDetailGradesStateLoaded
    implements CourseDetailGradesState {
  const factory _CourseDetailGradesStateLoaded(final CourseGradeInfo value) =
      _$CourseDetailGradesStateLoadedImpl;

  CourseGradeInfo get value;

  /// Create a copy of CourseDetailGradesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CourseDetailGradesStateLoadedImplCopyWith<
          _$CourseDetailGradesStateLoadedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CourseDetailGradesStateErrorImplCopyWith<$Res> {
  factory _$$CourseDetailGradesStateErrorImplCopyWith(
          _$CourseDetailGradesStateErrorImpl value,
          $Res Function(_$CourseDetailGradesStateErrorImpl) then) =
      __$$CourseDetailGradesStateErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$CourseDetailGradesStateErrorImplCopyWithImpl<$Res>
    extends _$CourseDetailGradesStateCopyWithImpl<$Res,
        _$CourseDetailGradesStateErrorImpl>
    implements _$$CourseDetailGradesStateErrorImplCopyWith<$Res> {
  __$$CourseDetailGradesStateErrorImplCopyWithImpl(
      _$CourseDetailGradesStateErrorImpl _value,
      $Res Function(_$CourseDetailGradesStateErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of CourseDetailGradesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$CourseDetailGradesStateErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CourseDetailGradesStateErrorImpl
    with DiagnosticableTreeMixin
    implements _CourseDetailGradesStateError {
  const _$CourseDetailGradesStateErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CourseDetailGradesState.error(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CourseDetailGradesState.error'))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CourseDetailGradesStateErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of CourseDetailGradesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CourseDetailGradesStateErrorImplCopyWith<
          _$CourseDetailGradesStateErrorImpl>
      get copyWith => __$$CourseDetailGradesStateErrorImplCopyWithImpl<
          _$CourseDetailGradesStateErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(CourseGradeInfo value) loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(CourseGradeInfo value)? loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(CourseGradeInfo value)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CourseDetailGradesStateInitial value) initial,
    required TResult Function(_CourseDetailGradesStateLoading value) loading,
    required TResult Function(_CourseDetailGradesStateLoaded value) loaded,
    required TResult Function(_CourseDetailGradesStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CourseDetailGradesStateInitial value)? initial,
    TResult? Function(_CourseDetailGradesStateLoading value)? loading,
    TResult? Function(_CourseDetailGradesStateLoaded value)? loaded,
    TResult? Function(_CourseDetailGradesStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CourseDetailGradesStateInitial value)? initial,
    TResult Function(_CourseDetailGradesStateLoading value)? loading,
    TResult Function(_CourseDetailGradesStateLoaded value)? loaded,
    TResult Function(_CourseDetailGradesStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _CourseDetailGradesStateError
    implements CourseDetailGradesState {
  const factory _CourseDetailGradesStateError(final String message) =
      _$CourseDetailGradesStateErrorImpl;

  String get message;

  /// Create a copy of CourseDetailGradesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CourseDetailGradesStateErrorImplCopyWith<
          _$CourseDetailGradesStateErrorImpl>
      get copyWith => throw _privateConstructorUsedError;
}
