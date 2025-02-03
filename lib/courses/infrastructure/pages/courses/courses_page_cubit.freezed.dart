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
mixin _$CoursesPageState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            List<RawEnrolledCourse> courses, String? errorMessage)
        success,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<RawEnrolledCourse> courses, String? errorMessage)?
        success,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<RawEnrolledCourse> courses, String? errorMessage)?
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

class _$CoursesPageLoadingStateImpl implements CoursesPageLoadingState {
  const _$CoursesPageLoadingStateImpl();

  @override
  String toString() {
    return 'CoursesPageState.loading()';
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
            List<RawEnrolledCourse> courses, String? errorMessage)
        success,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<RawEnrolledCourse> courses, String? errorMessage)?
        success,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<RawEnrolledCourse> courses, String? errorMessage)?
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
  $Res call({List<RawEnrolledCourse> courses, String? errorMessage});
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
    Object? courses = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$CoursesPageSuccessStateImpl(
      courses: null == courses
          ? _value._courses
          : courses // ignore: cast_nullable_to_non_nullable
              as List<RawEnrolledCourse>,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$CoursesPageSuccessStateImpl implements CoursesPageSuccessState {
  const _$CoursesPageSuccessStateImpl(
      {required final List<RawEnrolledCourse> courses, this.errorMessage})
      : _courses = courses;

  final List<RawEnrolledCourse> _courses;
  @override
  List<RawEnrolledCourse> get courses {
    if (_courses is EqualUnmodifiableListView) return _courses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_courses);
  }

  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'CoursesPageState.success(courses: $courses, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CoursesPageSuccessStateImpl &&
            const DeepCollectionEquality().equals(other._courses, _courses) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_courses), errorMessage);

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
            List<RawEnrolledCourse> courses, String? errorMessage)
        success,
    required TResult Function(String message) error,
  }) {
    return success(courses, errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<RawEnrolledCourse> courses, String? errorMessage)?
        success,
    TResult? Function(String message)? error,
  }) {
    return success?.call(courses, errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<RawEnrolledCourse> courses, String? errorMessage)?
        success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(courses, errorMessage);
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
      {required final List<RawEnrolledCourse> courses,
      final String? errorMessage}) = _$CoursesPageSuccessStateImpl;

  List<RawEnrolledCourse> get courses;
  String? get errorMessage;

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

class _$CoursesPageErrorStateImpl implements CoursesPageErrorState {
  const _$CoursesPageErrorStateImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'CoursesPageState.error(message: $message)';
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
            List<RawEnrolledCourse> courses, String? errorMessage)
        success,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<RawEnrolledCourse> courses, String? errorMessage)?
        success,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<RawEnrolledCourse> courses, String? errorMessage)?
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
