// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'career_page_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CareerPageState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            ProgramCurriculumProgress programCurriculumProgress,
            AcademicReport academicReport)
        success,
    required TResult Function(Object error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(ProgramCurriculumProgress programCurriculumProgress,
            AcademicReport academicReport)?
        success,
    TResult? Function(Object error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(ProgramCurriculumProgress programCurriculumProgress,
            AcademicReport academicReport)?
        success,
    TResult Function(Object error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CareerPageLoadingState value) loading,
    required TResult Function(CareerPageSuccessState value) success,
    required TResult Function(CareerPageErrorState value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CareerPageLoadingState value)? loading,
    TResult? Function(CareerPageSuccessState value)? success,
    TResult? Function(CareerPageErrorState value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CareerPageLoadingState value)? loading,
    TResult Function(CareerPageSuccessState value)? success,
    TResult Function(CareerPageErrorState value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CareerPageStateCopyWith<$Res> {
  factory $CareerPageStateCopyWith(
          CareerPageState value, $Res Function(CareerPageState) then) =
      _$CareerPageStateCopyWithImpl<$Res, CareerPageState>;
}

/// @nodoc
class _$CareerPageStateCopyWithImpl<$Res, $Val extends CareerPageState>
    implements $CareerPageStateCopyWith<$Res> {
  _$CareerPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CareerPageState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$CareerPageLoadingStateImplCopyWith<$Res> {
  factory _$$CareerPageLoadingStateImplCopyWith(
          _$CareerPageLoadingStateImpl value,
          $Res Function(_$CareerPageLoadingStateImpl) then) =
      __$$CareerPageLoadingStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CareerPageLoadingStateImplCopyWithImpl<$Res>
    extends _$CareerPageStateCopyWithImpl<$Res, _$CareerPageLoadingStateImpl>
    implements _$$CareerPageLoadingStateImplCopyWith<$Res> {
  __$$CareerPageLoadingStateImplCopyWithImpl(
      _$CareerPageLoadingStateImpl _value,
      $Res Function(_$CareerPageLoadingStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CareerPageState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CareerPageLoadingStateImpl
    with DiagnosticableTreeMixin
    implements CareerPageLoadingState {
  const _$CareerPageLoadingStateImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CareerPageState.loading()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'CareerPageState.loading'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CareerPageLoadingStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            ProgramCurriculumProgress programCurriculumProgress,
            AcademicReport academicReport)
        success,
    required TResult Function(Object error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(ProgramCurriculumProgress programCurriculumProgress,
            AcademicReport academicReport)?
        success,
    TResult? Function(Object error)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(ProgramCurriculumProgress programCurriculumProgress,
            AcademicReport academicReport)?
        success,
    TResult Function(Object error)? error,
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
    required TResult Function(CareerPageLoadingState value) loading,
    required TResult Function(CareerPageSuccessState value) success,
    required TResult Function(CareerPageErrorState value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CareerPageLoadingState value)? loading,
    TResult? Function(CareerPageSuccessState value)? success,
    TResult? Function(CareerPageErrorState value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CareerPageLoadingState value)? loading,
    TResult Function(CareerPageSuccessState value)? success,
    TResult Function(CareerPageErrorState value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class CareerPageLoadingState implements CareerPageState {
  const factory CareerPageLoadingState() = _$CareerPageLoadingStateImpl;
}

/// @nodoc
abstract class _$$CareerPageSuccessStateImplCopyWith<$Res> {
  factory _$$CareerPageSuccessStateImplCopyWith(
          _$CareerPageSuccessStateImpl value,
          $Res Function(_$CareerPageSuccessStateImpl) then) =
      __$$CareerPageSuccessStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {ProgramCurriculumProgress programCurriculumProgress,
      AcademicReport academicReport});

  $AcademicReportCopyWith<$Res> get academicReport;
}

/// @nodoc
class __$$CareerPageSuccessStateImplCopyWithImpl<$Res>
    extends _$CareerPageStateCopyWithImpl<$Res, _$CareerPageSuccessStateImpl>
    implements _$$CareerPageSuccessStateImplCopyWith<$Res> {
  __$$CareerPageSuccessStateImplCopyWithImpl(
      _$CareerPageSuccessStateImpl _value,
      $Res Function(_$CareerPageSuccessStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CareerPageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? programCurriculumProgress = null,
    Object? academicReport = null,
  }) {
    return _then(_$CareerPageSuccessStateImpl(
      programCurriculumProgress: null == programCurriculumProgress
          ? _value.programCurriculumProgress
          : programCurriculumProgress // ignore: cast_nullable_to_non_nullable
              as ProgramCurriculumProgress,
      academicReport: null == academicReport
          ? _value.academicReport
          : academicReport // ignore: cast_nullable_to_non_nullable
              as AcademicReport,
    ));
  }

  /// Create a copy of CareerPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AcademicReportCopyWith<$Res> get academicReport {
    return $AcademicReportCopyWith<$Res>(_value.academicReport, (value) {
      return _then(_value.copyWith(academicReport: value));
    });
  }
}

/// @nodoc

class _$CareerPageSuccessStateImpl
    with DiagnosticableTreeMixin
    implements CareerPageSuccessState {
  const _$CareerPageSuccessStateImpl(
      {required this.programCurriculumProgress, required this.academicReport});

  @override
  final ProgramCurriculumProgress programCurriculumProgress;
  @override
  final AcademicReport academicReport;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CareerPageState.success(programCurriculumProgress: $programCurriculumProgress, academicReport: $academicReport)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CareerPageState.success'))
      ..add(DiagnosticsProperty(
          'programCurriculumProgress', programCurriculumProgress))
      ..add(DiagnosticsProperty('academicReport', academicReport));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CareerPageSuccessStateImpl &&
            (identical(other.programCurriculumProgress,
                    programCurriculumProgress) ||
                other.programCurriculumProgress == programCurriculumProgress) &&
            (identical(other.academicReport, academicReport) ||
                other.academicReport == academicReport));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, programCurriculumProgress, academicReport);

  /// Create a copy of CareerPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CareerPageSuccessStateImplCopyWith<_$CareerPageSuccessStateImpl>
      get copyWith => __$$CareerPageSuccessStateImplCopyWithImpl<
          _$CareerPageSuccessStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            ProgramCurriculumProgress programCurriculumProgress,
            AcademicReport academicReport)
        success,
    required TResult Function(Object error) error,
  }) {
    return success(programCurriculumProgress, academicReport);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(ProgramCurriculumProgress programCurriculumProgress,
            AcademicReport academicReport)?
        success,
    TResult? Function(Object error)? error,
  }) {
    return success?.call(programCurriculumProgress, academicReport);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(ProgramCurriculumProgress programCurriculumProgress,
            AcademicReport academicReport)?
        success,
    TResult Function(Object error)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(programCurriculumProgress, academicReport);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CareerPageLoadingState value) loading,
    required TResult Function(CareerPageSuccessState value) success,
    required TResult Function(CareerPageErrorState value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CareerPageLoadingState value)? loading,
    TResult? Function(CareerPageSuccessState value)? success,
    TResult? Function(CareerPageErrorState value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CareerPageLoadingState value)? loading,
    TResult Function(CareerPageSuccessState value)? success,
    TResult Function(CareerPageErrorState value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class CareerPageSuccessState implements CareerPageState {
  const factory CareerPageSuccessState(
          {required final ProgramCurriculumProgress programCurriculumProgress,
          required final AcademicReport academicReport}) =
      _$CareerPageSuccessStateImpl;

  ProgramCurriculumProgress get programCurriculumProgress;
  AcademicReport get academicReport;

  /// Create a copy of CareerPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CareerPageSuccessStateImplCopyWith<_$CareerPageSuccessStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CareerPageErrorStateImplCopyWith<$Res> {
  factory _$$CareerPageErrorStateImplCopyWith(_$CareerPageErrorStateImpl value,
          $Res Function(_$CareerPageErrorStateImpl) then) =
      __$$CareerPageErrorStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Object error});
}

/// @nodoc
class __$$CareerPageErrorStateImplCopyWithImpl<$Res>
    extends _$CareerPageStateCopyWithImpl<$Res, _$CareerPageErrorStateImpl>
    implements _$$CareerPageErrorStateImplCopyWith<$Res> {
  __$$CareerPageErrorStateImplCopyWithImpl(_$CareerPageErrorStateImpl _value,
      $Res Function(_$CareerPageErrorStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CareerPageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$CareerPageErrorStateImpl(
      null == error ? _value.error : error,
    ));
  }
}

/// @nodoc

class _$CareerPageErrorStateImpl
    with DiagnosticableTreeMixin
    implements CareerPageErrorState {
  const _$CareerPageErrorStateImpl(this.error);

  @override
  final Object error;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CareerPageState.error(error: $error)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CareerPageState.error'))
      ..add(DiagnosticsProperty('error', error));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CareerPageErrorStateImpl &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error));

  /// Create a copy of CareerPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CareerPageErrorStateImplCopyWith<_$CareerPageErrorStateImpl>
      get copyWith =>
          __$$CareerPageErrorStateImplCopyWithImpl<_$CareerPageErrorStateImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            ProgramCurriculumProgress programCurriculumProgress,
            AcademicReport academicReport)
        success,
    required TResult Function(Object error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(ProgramCurriculumProgress programCurriculumProgress,
            AcademicReport academicReport)?
        success,
    TResult? Function(Object error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(ProgramCurriculumProgress programCurriculumProgress,
            AcademicReport academicReport)?
        success,
    TResult Function(Object error)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CareerPageLoadingState value) loading,
    required TResult Function(CareerPageSuccessState value) success,
    required TResult Function(CareerPageErrorState value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CareerPageLoadingState value)? loading,
    TResult? Function(CareerPageSuccessState value)? success,
    TResult? Function(CareerPageErrorState value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CareerPageLoadingState value)? loading,
    TResult Function(CareerPageSuccessState value)? success,
    TResult Function(CareerPageErrorState value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class CareerPageErrorState implements CareerPageState {
  const factory CareerPageErrorState(final Object error) =
      _$CareerPageErrorStateImpl;

  Object get error;

  /// Create a copy of CareerPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CareerPageErrorStateImplCopyWith<_$CareerPageErrorStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
