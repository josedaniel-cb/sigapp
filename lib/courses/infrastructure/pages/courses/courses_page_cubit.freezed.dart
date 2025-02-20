// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'courses_page_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EnrolledCoursesState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<EnrolledCourse> value) success,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<EnrolledCourse> value)? success,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<EnrolledCourse> value)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EnrolledCoursesLoadingState value) loading,
    required TResult Function(EnrolledCoursesSuccessState value) success,
    required TResult Function(EnrolledCoursesErrorState value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EnrolledCoursesLoadingState value)? loading,
    TResult? Function(EnrolledCoursesSuccessState value)? success,
    TResult? Function(EnrolledCoursesErrorState value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EnrolledCoursesLoadingState value)? loading,
    TResult Function(EnrolledCoursesSuccessState value)? success,
    TResult Function(EnrolledCoursesErrorState value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EnrolledCoursesStateCopyWith<$Res> {
  factory $EnrolledCoursesStateCopyWith(EnrolledCoursesState value,
          $Res Function(EnrolledCoursesState) then) =
      _$EnrolledCoursesStateCopyWithImpl<$Res, EnrolledCoursesState>;
}

/// @nodoc
class _$EnrolledCoursesStateCopyWithImpl<$Res,
        $Val extends EnrolledCoursesState>
    implements $EnrolledCoursesStateCopyWith<$Res> {
  _$EnrolledCoursesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EnrolledCoursesState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$EnrolledCoursesLoadingStateImplCopyWith<$Res> {
  factory _$$EnrolledCoursesLoadingStateImplCopyWith(
          _$EnrolledCoursesLoadingStateImpl value,
          $Res Function(_$EnrolledCoursesLoadingStateImpl) then) =
      __$$EnrolledCoursesLoadingStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$EnrolledCoursesLoadingStateImplCopyWithImpl<$Res>
    extends _$EnrolledCoursesStateCopyWithImpl<$Res,
        _$EnrolledCoursesLoadingStateImpl>
    implements _$$EnrolledCoursesLoadingStateImplCopyWith<$Res> {
  __$$EnrolledCoursesLoadingStateImplCopyWithImpl(
      _$EnrolledCoursesLoadingStateImpl _value,
      $Res Function(_$EnrolledCoursesLoadingStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of EnrolledCoursesState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$EnrolledCoursesLoadingStateImpl
    with DiagnosticableTreeMixin
    implements EnrolledCoursesLoadingState {
  const _$EnrolledCoursesLoadingStateImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'EnrolledCoursesState.loading()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'EnrolledCoursesState.loading'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EnrolledCoursesLoadingStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<EnrolledCourse> value) success,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<EnrolledCourse> value)? success,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<EnrolledCourse> value)? success,
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
    required TResult Function(EnrolledCoursesLoadingState value) loading,
    required TResult Function(EnrolledCoursesSuccessState value) success,
    required TResult Function(EnrolledCoursesErrorState value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EnrolledCoursesLoadingState value)? loading,
    TResult? Function(EnrolledCoursesSuccessState value)? success,
    TResult? Function(EnrolledCoursesErrorState value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EnrolledCoursesLoadingState value)? loading,
    TResult Function(EnrolledCoursesSuccessState value)? success,
    TResult Function(EnrolledCoursesErrorState value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class EnrolledCoursesLoadingState implements EnrolledCoursesState {
  const factory EnrolledCoursesLoadingState() =
      _$EnrolledCoursesLoadingStateImpl;
}

/// @nodoc
abstract class _$$EnrolledCoursesSuccessStateImplCopyWith<$Res> {
  factory _$$EnrolledCoursesSuccessStateImplCopyWith(
          _$EnrolledCoursesSuccessStateImpl value,
          $Res Function(_$EnrolledCoursesSuccessStateImpl) then) =
      __$$EnrolledCoursesSuccessStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<EnrolledCourse> value});
}

/// @nodoc
class __$$EnrolledCoursesSuccessStateImplCopyWithImpl<$Res>
    extends _$EnrolledCoursesStateCopyWithImpl<$Res,
        _$EnrolledCoursesSuccessStateImpl>
    implements _$$EnrolledCoursesSuccessStateImplCopyWith<$Res> {
  __$$EnrolledCoursesSuccessStateImplCopyWithImpl(
      _$EnrolledCoursesSuccessStateImpl _value,
      $Res Function(_$EnrolledCoursesSuccessStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of EnrolledCoursesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$EnrolledCoursesSuccessStateImpl(
      value: null == value
          ? _value._value
          : value // ignore: cast_nullable_to_non_nullable
              as List<EnrolledCourse>,
    ));
  }
}

/// @nodoc

class _$EnrolledCoursesSuccessStateImpl
    with DiagnosticableTreeMixin
    implements EnrolledCoursesSuccessState {
  const _$EnrolledCoursesSuccessStateImpl(
      {required final List<EnrolledCourse> value})
      : _value = value;

  final List<EnrolledCourse> _value;
  @override
  List<EnrolledCourse> get value {
    if (_value is EqualUnmodifiableListView) return _value;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'EnrolledCoursesState.success(value: $value)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'EnrolledCoursesState.success'))
      ..add(DiagnosticsProperty('value', value));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EnrolledCoursesSuccessStateImpl &&
            const DeepCollectionEquality().equals(other._value, _value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_value));

  /// Create a copy of EnrolledCoursesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EnrolledCoursesSuccessStateImplCopyWith<_$EnrolledCoursesSuccessStateImpl>
      get copyWith => __$$EnrolledCoursesSuccessStateImplCopyWithImpl<
          _$EnrolledCoursesSuccessStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<EnrolledCourse> value) success,
    required TResult Function(String message) error,
  }) {
    return success(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<EnrolledCourse> value)? success,
    TResult? Function(String message)? error,
  }) {
    return success?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<EnrolledCourse> value)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EnrolledCoursesLoadingState value) loading,
    required TResult Function(EnrolledCoursesSuccessState value) success,
    required TResult Function(EnrolledCoursesErrorState value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EnrolledCoursesLoadingState value)? loading,
    TResult? Function(EnrolledCoursesSuccessState value)? success,
    TResult? Function(EnrolledCoursesErrorState value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EnrolledCoursesLoadingState value)? loading,
    TResult Function(EnrolledCoursesSuccessState value)? success,
    TResult Function(EnrolledCoursesErrorState value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class EnrolledCoursesSuccessState implements EnrolledCoursesState {
  const factory EnrolledCoursesSuccessState(
          {required final List<EnrolledCourse> value}) =
      _$EnrolledCoursesSuccessStateImpl;

  List<EnrolledCourse> get value;

  /// Create a copy of EnrolledCoursesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EnrolledCoursesSuccessStateImplCopyWith<_$EnrolledCoursesSuccessStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EnrolledCoursesErrorStateImplCopyWith<$Res> {
  factory _$$EnrolledCoursesErrorStateImplCopyWith(
          _$EnrolledCoursesErrorStateImpl value,
          $Res Function(_$EnrolledCoursesErrorStateImpl) then) =
      __$$EnrolledCoursesErrorStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$EnrolledCoursesErrorStateImplCopyWithImpl<$Res>
    extends _$EnrolledCoursesStateCopyWithImpl<$Res,
        _$EnrolledCoursesErrorStateImpl>
    implements _$$EnrolledCoursesErrorStateImplCopyWith<$Res> {
  __$$EnrolledCoursesErrorStateImplCopyWithImpl(
      _$EnrolledCoursesErrorStateImpl _value,
      $Res Function(_$EnrolledCoursesErrorStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of EnrolledCoursesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$EnrolledCoursesErrorStateImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$EnrolledCoursesErrorStateImpl
    with DiagnosticableTreeMixin
    implements EnrolledCoursesErrorState {
  const _$EnrolledCoursesErrorStateImpl(this.message);

  @override
  final String message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'EnrolledCoursesState.error(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'EnrolledCoursesState.error'))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EnrolledCoursesErrorStateImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of EnrolledCoursesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EnrolledCoursesErrorStateImplCopyWith<_$EnrolledCoursesErrorStateImpl>
      get copyWith => __$$EnrolledCoursesErrorStateImplCopyWithImpl<
          _$EnrolledCoursesErrorStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<EnrolledCourse> value) success,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<EnrolledCourse> value)? success,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<EnrolledCourse> value)? success,
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
    required TResult Function(EnrolledCoursesLoadingState value) loading,
    required TResult Function(EnrolledCoursesSuccessState value) success,
    required TResult Function(EnrolledCoursesErrorState value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EnrolledCoursesLoadingState value)? loading,
    TResult? Function(EnrolledCoursesSuccessState value)? success,
    TResult? Function(EnrolledCoursesErrorState value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EnrolledCoursesLoadingState value)? loading,
    TResult Function(EnrolledCoursesSuccessState value)? success,
    TResult Function(EnrolledCoursesErrorState value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class EnrolledCoursesErrorState implements EnrolledCoursesState {
  const factory EnrolledCoursesErrorState(final String message) =
      _$EnrolledCoursesErrorStateImpl;

  String get message;

  /// Create a copy of EnrolledCoursesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EnrolledCoursesErrorStateImplCopyWith<_$EnrolledCoursesErrorStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CoursesPageState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            AcademicReport academicReport,
            SemesterContext semesterContext,
            SemesterScheduleSemesterMetadata selectedSemester,
            EnrolledCoursesState enrolledCourses)
        success,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
            AcademicReport academicReport,
            SemesterContext semesterContext,
            SemesterScheduleSemesterMetadata selectedSemester,
            EnrolledCoursesState enrolledCourses)?
        success,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            AcademicReport academicReport,
            SemesterContext semesterContext,
            SemesterScheduleSemesterMetadata selectedSemester,
            EnrolledCoursesState enrolledCourses)?
        success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CoursesPageLoadingState value) loading,
    required TResult Function(CoursesPageSuccessState value) success,
    required TResult Function(CoursesPageErrorState value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CoursesPageLoadingState value)? loading,
    TResult? Function(CoursesPageSuccessState value)? success,
    TResult? Function(CoursesPageErrorState value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CoursesPageLoadingState value)? loading,
    TResult Function(CoursesPageSuccessState value)? success,
    TResult Function(CoursesPageErrorState value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CoursesPageStateCopyWith<$Res> {
  factory $CoursesPageStateCopyWith(
          CoursesPageState value, $Res Function(CoursesPageState) then) =
      _$CoursesPageStateCopyWithImpl<$Res, CoursesPageState>;
}

/// @nodoc
class _$CoursesPageStateCopyWithImpl<$Res, $Val extends CoursesPageState>
    implements $CoursesPageStateCopyWith<$Res> {
  _$CoursesPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CoursesPageState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$CoursesPageLoadingStateImplCopyWith<$Res> {
  factory _$$CoursesPageLoadingStateImplCopyWith(
          _$CoursesPageLoadingStateImpl value,
          $Res Function(_$CoursesPageLoadingStateImpl) then) =
      __$$CoursesPageLoadingStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CoursesPageLoadingStateImplCopyWithImpl<$Res>
    extends _$CoursesPageStateCopyWithImpl<$Res, _$CoursesPageLoadingStateImpl>
    implements _$$CoursesPageLoadingStateImplCopyWith<$Res> {
  __$$CoursesPageLoadingStateImplCopyWithImpl(
      _$CoursesPageLoadingStateImpl _value,
      $Res Function(_$CoursesPageLoadingStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CoursesPageState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CoursesPageLoadingStateImpl
    with DiagnosticableTreeMixin
    implements CoursesPageLoadingState {
  const _$CoursesPageLoadingStateImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CoursesPageState.loading()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'CoursesPageState.loading'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CoursesPageLoadingStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            AcademicReport academicReport,
            SemesterContext semesterContext,
            SemesterScheduleSemesterMetadata selectedSemester,
            EnrolledCoursesState enrolledCourses)
        success,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
            AcademicReport academicReport,
            SemesterContext semesterContext,
            SemesterScheduleSemesterMetadata selectedSemester,
            EnrolledCoursesState enrolledCourses)?
        success,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            AcademicReport academicReport,
            SemesterContext semesterContext,
            SemesterScheduleSemesterMetadata selectedSemester,
            EnrolledCoursesState enrolledCourses)?
        success,
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
    required TResult Function(CoursesPageLoadingState value) loading,
    required TResult Function(CoursesPageSuccessState value) success,
    required TResult Function(CoursesPageErrorState value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CoursesPageLoadingState value)? loading,
    TResult? Function(CoursesPageSuccessState value)? success,
    TResult? Function(CoursesPageErrorState value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CoursesPageLoadingState value)? loading,
    TResult Function(CoursesPageSuccessState value)? success,
    TResult Function(CoursesPageErrorState value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class CoursesPageLoadingState implements CoursesPageState {
  const factory CoursesPageLoadingState() = _$CoursesPageLoadingStateImpl;
}

/// @nodoc
abstract class _$$CoursesPageSuccessStateImplCopyWith<$Res> {
  factory _$$CoursesPageSuccessStateImplCopyWith(
          _$CoursesPageSuccessStateImpl value,
          $Res Function(_$CoursesPageSuccessStateImpl) then) =
      __$$CoursesPageSuccessStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {AcademicReport academicReport,
      SemesterContext semesterContext,
      SemesterScheduleSemesterMetadata selectedSemester,
      EnrolledCoursesState enrolledCourses});

  $AcademicReportCopyWith<$Res> get academicReport;
  $SemesterContextCopyWith<$Res> get semesterContext;
  $EnrolledCoursesStateCopyWith<$Res> get enrolledCourses;
}

/// @nodoc
class __$$CoursesPageSuccessStateImplCopyWithImpl<$Res>
    extends _$CoursesPageStateCopyWithImpl<$Res, _$CoursesPageSuccessStateImpl>
    implements _$$CoursesPageSuccessStateImplCopyWith<$Res> {
  __$$CoursesPageSuccessStateImplCopyWithImpl(
      _$CoursesPageSuccessStateImpl _value,
      $Res Function(_$CoursesPageSuccessStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CoursesPageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? academicReport = null,
    Object? semesterContext = null,
    Object? selectedSemester = null,
    Object? enrolledCourses = null,
  }) {
    return _then(_$CoursesPageSuccessStateImpl(
      academicReport: null == academicReport
          ? _value.academicReport
          : academicReport // ignore: cast_nullable_to_non_nullable
              as AcademicReport,
      semesterContext: null == semesterContext
          ? _value.semesterContext
          : semesterContext // ignore: cast_nullable_to_non_nullable
              as SemesterContext,
      selectedSemester: null == selectedSemester
          ? _value.selectedSemester
          : selectedSemester // ignore: cast_nullable_to_non_nullable
              as SemesterScheduleSemesterMetadata,
      enrolledCourses: null == enrolledCourses
          ? _value.enrolledCourses
          : enrolledCourses // ignore: cast_nullable_to_non_nullable
              as EnrolledCoursesState,
    ));
  }

  /// Create a copy of CoursesPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AcademicReportCopyWith<$Res> get academicReport {
    return $AcademicReportCopyWith<$Res>(_value.academicReport, (value) {
      return _then(_value.copyWith(academicReport: value));
    });
  }

  /// Create a copy of CoursesPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SemesterContextCopyWith<$Res> get semesterContext {
    return $SemesterContextCopyWith<$Res>(_value.semesterContext, (value) {
      return _then(_value.copyWith(semesterContext: value));
    });
  }

  /// Create a copy of CoursesPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EnrolledCoursesStateCopyWith<$Res> get enrolledCourses {
    return $EnrolledCoursesStateCopyWith<$Res>(_value.enrolledCourses, (value) {
      return _then(_value.copyWith(enrolledCourses: value));
    });
  }
}

/// @nodoc

class _$CoursesPageSuccessStateImpl
    with DiagnosticableTreeMixin
    implements CoursesPageSuccessState {
  const _$CoursesPageSuccessStateImpl(
      {required this.academicReport,
      required this.semesterContext,
      required this.selectedSemester,
      required this.enrolledCourses});

  @override
  final AcademicReport academicReport;
  @override
  final SemesterContext semesterContext;
  @override
  final SemesterScheduleSemesterMetadata selectedSemester;
  @override
  final EnrolledCoursesState enrolledCourses;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CoursesPageState.success(academicReport: $academicReport, semesterContext: $semesterContext, selectedSemester: $selectedSemester, enrolledCourses: $enrolledCourses)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CoursesPageState.success'))
      ..add(DiagnosticsProperty('academicReport', academicReport))
      ..add(DiagnosticsProperty('semesterContext', semesterContext))
      ..add(DiagnosticsProperty('selectedSemester', selectedSemester))
      ..add(DiagnosticsProperty('enrolledCourses', enrolledCourses));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CoursesPageSuccessStateImpl &&
            (identical(other.academicReport, academicReport) ||
                other.academicReport == academicReport) &&
            (identical(other.semesterContext, semesterContext) ||
                other.semesterContext == semesterContext) &&
            (identical(other.selectedSemester, selectedSemester) ||
                other.selectedSemester == selectedSemester) &&
            (identical(other.enrolledCourses, enrolledCourses) ||
                other.enrolledCourses == enrolledCourses));
  }

  @override
  int get hashCode => Object.hash(runtimeType, academicReport, semesterContext,
      selectedSemester, enrolledCourses);

  /// Create a copy of CoursesPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CoursesPageSuccessStateImplCopyWith<_$CoursesPageSuccessStateImpl>
      get copyWith => __$$CoursesPageSuccessStateImplCopyWithImpl<
          _$CoursesPageSuccessStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            AcademicReport academicReport,
            SemesterContext semesterContext,
            SemesterScheduleSemesterMetadata selectedSemester,
            EnrolledCoursesState enrolledCourses)
        success,
    required TResult Function(String message) error,
  }) {
    return success(
        academicReport, semesterContext, selectedSemester, enrolledCourses);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
            AcademicReport academicReport,
            SemesterContext semesterContext,
            SemesterScheduleSemesterMetadata selectedSemester,
            EnrolledCoursesState enrolledCourses)?
        success,
    TResult? Function(String message)? error,
  }) {
    return success?.call(
        academicReport, semesterContext, selectedSemester, enrolledCourses);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            AcademicReport academicReport,
            SemesterContext semesterContext,
            SemesterScheduleSemesterMetadata selectedSemester,
            EnrolledCoursesState enrolledCourses)?
        success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(
          academicReport, semesterContext, selectedSemester, enrolledCourses);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CoursesPageLoadingState value) loading,
    required TResult Function(CoursesPageSuccessState value) success,
    required TResult Function(CoursesPageErrorState value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CoursesPageLoadingState value)? loading,
    TResult? Function(CoursesPageSuccessState value)? success,
    TResult? Function(CoursesPageErrorState value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CoursesPageLoadingState value)? loading,
    TResult Function(CoursesPageSuccessState value)? success,
    TResult Function(CoursesPageErrorState value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class CoursesPageSuccessState implements CoursesPageState {
  const factory CoursesPageSuccessState(
          {required final AcademicReport academicReport,
          required final SemesterContext semesterContext,
          required final SemesterScheduleSemesterMetadata selectedSemester,
          required final EnrolledCoursesState enrolledCourses}) =
      _$CoursesPageSuccessStateImpl;

  AcademicReport get academicReport;
  SemesterContext get semesterContext;
  SemesterScheduleSemesterMetadata get selectedSemester;
  EnrolledCoursesState get enrolledCourses;

  /// Create a copy of CoursesPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CoursesPageSuccessStateImplCopyWith<_$CoursesPageSuccessStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CoursesPageErrorStateImplCopyWith<$Res> {
  factory _$$CoursesPageErrorStateImplCopyWith(
          _$CoursesPageErrorStateImpl value,
          $Res Function(_$CoursesPageErrorStateImpl) then) =
      __$$CoursesPageErrorStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$CoursesPageErrorStateImplCopyWithImpl<$Res>
    extends _$CoursesPageStateCopyWithImpl<$Res, _$CoursesPageErrorStateImpl>
    implements _$$CoursesPageErrorStateImplCopyWith<$Res> {
  __$$CoursesPageErrorStateImplCopyWithImpl(_$CoursesPageErrorStateImpl _value,
      $Res Function(_$CoursesPageErrorStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CoursesPageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$CoursesPageErrorStateImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CoursesPageErrorStateImpl
    with DiagnosticableTreeMixin
    implements CoursesPageErrorState {
  const _$CoursesPageErrorStateImpl(this.message);

  @override
  final String message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CoursesPageState.error(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CoursesPageState.error'))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CoursesPageErrorStateImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of CoursesPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CoursesPageErrorStateImplCopyWith<_$CoursesPageErrorStateImpl>
      get copyWith => __$$CoursesPageErrorStateImplCopyWithImpl<
          _$CoursesPageErrorStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            AcademicReport academicReport,
            SemesterContext semesterContext,
            SemesterScheduleSemesterMetadata selectedSemester,
            EnrolledCoursesState enrolledCourses)
        success,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
            AcademicReport academicReport,
            SemesterContext semesterContext,
            SemesterScheduleSemesterMetadata selectedSemester,
            EnrolledCoursesState enrolledCourses)?
        success,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            AcademicReport academicReport,
            SemesterContext semesterContext,
            SemesterScheduleSemesterMetadata selectedSemester,
            EnrolledCoursesState enrolledCourses)?
        success,
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
    required TResult Function(CoursesPageLoadingState value) loading,
    required TResult Function(CoursesPageSuccessState value) success,
    required TResult Function(CoursesPageErrorState value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CoursesPageLoadingState value)? loading,
    TResult? Function(CoursesPageSuccessState value)? success,
    TResult? Function(CoursesPageErrorState value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CoursesPageLoadingState value)? loading,
    TResult Function(CoursesPageSuccessState value)? success,
    TResult Function(CoursesPageErrorState value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class CoursesPageErrorState implements CoursesPageState {
  const factory CoursesPageErrorState(final String message) =
      _$CoursesPageErrorStateImpl;

  String get message;

  /// Create a copy of CoursesPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CoursesPageErrorStateImplCopyWith<_$CoursesPageErrorStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
