// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scheduled_courses_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ScheduledCoursesPageState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<ScheduledCourse> scheduledCourses,
            List<ScheduledCourse> filteredCourses, String searchQuery)
        success,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<ScheduledCourse> scheduledCourses,
            List<ScheduledCourse> filteredCourses, String searchQuery)?
        success,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<ScheduledCourse> scheduledCourses,
            List<ScheduledCourse> filteredCourses, String searchQuery)?
        success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CoursesPageLoadingState value) loading,
    required TResult Function(ScheduledCoursesPageSuccessState value) success,
    required TResult Function(CoursesPageErrorState value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CoursesPageLoadingState value)? loading,
    TResult? Function(ScheduledCoursesPageSuccessState value)? success,
    TResult? Function(CoursesPageErrorState value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CoursesPageLoadingState value)? loading,
    TResult Function(ScheduledCoursesPageSuccessState value)? success,
    TResult Function(CoursesPageErrorState value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScheduledCoursesPageStateCopyWith<$Res> {
  factory $ScheduledCoursesPageStateCopyWith(ScheduledCoursesPageState value,
          $Res Function(ScheduledCoursesPageState) then) =
      _$ScheduledCoursesPageStateCopyWithImpl<$Res, ScheduledCoursesPageState>;
}

/// @nodoc
class _$ScheduledCoursesPageStateCopyWithImpl<$Res,
        $Val extends ScheduledCoursesPageState>
    implements $ScheduledCoursesPageStateCopyWith<$Res> {
  _$ScheduledCoursesPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ScheduledCoursesPageState
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
    extends _$ScheduledCoursesPageStateCopyWithImpl<$Res,
        _$CoursesPageLoadingStateImpl>
    implements _$$CoursesPageLoadingStateImplCopyWith<$Res> {
  __$$CoursesPageLoadingStateImplCopyWithImpl(
      _$CoursesPageLoadingStateImpl _value,
      $Res Function(_$CoursesPageLoadingStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ScheduledCoursesPageState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CoursesPageLoadingStateImpl
    with DiagnosticableTreeMixin
    implements CoursesPageLoadingState {
  const _$CoursesPageLoadingStateImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ScheduledCoursesPageState.loading()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ScheduledCoursesPageState.loading'));
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
    required TResult Function(List<ScheduledCourse> scheduledCourses,
            List<ScheduledCourse> filteredCourses, String searchQuery)
        success,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<ScheduledCourse> scheduledCourses,
            List<ScheduledCourse> filteredCourses, String searchQuery)?
        success,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<ScheduledCourse> scheduledCourses,
            List<ScheduledCourse> filteredCourses, String searchQuery)?
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
    required TResult Function(ScheduledCoursesPageSuccessState value) success,
    required TResult Function(CoursesPageErrorState value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CoursesPageLoadingState value)? loading,
    TResult? Function(ScheduledCoursesPageSuccessState value)? success,
    TResult? Function(CoursesPageErrorState value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CoursesPageLoadingState value)? loading,
    TResult Function(ScheduledCoursesPageSuccessState value)? success,
    TResult Function(CoursesPageErrorState value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class CoursesPageLoadingState implements ScheduledCoursesPageState {
  const factory CoursesPageLoadingState() = _$CoursesPageLoadingStateImpl;
}

/// @nodoc
abstract class _$$ScheduledCoursesPageSuccessStateImplCopyWith<$Res> {
  factory _$$ScheduledCoursesPageSuccessStateImplCopyWith(
          _$ScheduledCoursesPageSuccessStateImpl value,
          $Res Function(_$ScheduledCoursesPageSuccessStateImpl) then) =
      __$$ScheduledCoursesPageSuccessStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<ScheduledCourse> scheduledCourses,
      List<ScheduledCourse> filteredCourses,
      String searchQuery});
}

/// @nodoc
class __$$ScheduledCoursesPageSuccessStateImplCopyWithImpl<$Res>
    extends _$ScheduledCoursesPageStateCopyWithImpl<$Res,
        _$ScheduledCoursesPageSuccessStateImpl>
    implements _$$ScheduledCoursesPageSuccessStateImplCopyWith<$Res> {
  __$$ScheduledCoursesPageSuccessStateImplCopyWithImpl(
      _$ScheduledCoursesPageSuccessStateImpl _value,
      $Res Function(_$ScheduledCoursesPageSuccessStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ScheduledCoursesPageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scheduledCourses = null,
    Object? filteredCourses = null,
    Object? searchQuery = null,
  }) {
    return _then(_$ScheduledCoursesPageSuccessStateImpl(
      scheduledCourses: null == scheduledCourses
          ? _value._scheduledCourses
          : scheduledCourses // ignore: cast_nullable_to_non_nullable
              as List<ScheduledCourse>,
      filteredCourses: null == filteredCourses
          ? _value._filteredCourses
          : filteredCourses // ignore: cast_nullable_to_non_nullable
              as List<ScheduledCourse>,
      searchQuery: null == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ScheduledCoursesPageSuccessStateImpl
    with DiagnosticableTreeMixin
    implements ScheduledCoursesPageSuccessState {
  const _$ScheduledCoursesPageSuccessStateImpl(
      {required final List<ScheduledCourse> scheduledCourses,
      required final List<ScheduledCourse> filteredCourses,
      required this.searchQuery})
      : _scheduledCourses = scheduledCourses,
        _filteredCourses = filteredCourses;

  final List<ScheduledCourse> _scheduledCourses;
  @override
  List<ScheduledCourse> get scheduledCourses {
    if (_scheduledCourses is EqualUnmodifiableListView)
      return _scheduledCourses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_scheduledCourses);
  }

  final List<ScheduledCourse> _filteredCourses;
  @override
  List<ScheduledCourse> get filteredCourses {
    if (_filteredCourses is EqualUnmodifiableListView) return _filteredCourses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filteredCourses);
  }

  @override
  final String searchQuery;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ScheduledCoursesPageState.success(scheduledCourses: $scheduledCourses, filteredCourses: $filteredCourses, searchQuery: $searchQuery)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ScheduledCoursesPageState.success'))
      ..add(DiagnosticsProperty('scheduledCourses', scheduledCourses))
      ..add(DiagnosticsProperty('filteredCourses', filteredCourses))
      ..add(DiagnosticsProperty('searchQuery', searchQuery));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScheduledCoursesPageSuccessStateImpl &&
            const DeepCollectionEquality()
                .equals(other._scheduledCourses, _scheduledCourses) &&
            const DeepCollectionEquality()
                .equals(other._filteredCourses, _filteredCourses) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_scheduledCourses),
      const DeepCollectionEquality().hash(_filteredCourses),
      searchQuery);

  /// Create a copy of ScheduledCoursesPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScheduledCoursesPageSuccessStateImplCopyWith<
          _$ScheduledCoursesPageSuccessStateImpl>
      get copyWith => __$$ScheduledCoursesPageSuccessStateImplCopyWithImpl<
          _$ScheduledCoursesPageSuccessStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<ScheduledCourse> scheduledCourses,
            List<ScheduledCourse> filteredCourses, String searchQuery)
        success,
    required TResult Function(String message) error,
  }) {
    return success(scheduledCourses, filteredCourses, searchQuery);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<ScheduledCourse> scheduledCourses,
            List<ScheduledCourse> filteredCourses, String searchQuery)?
        success,
    TResult? Function(String message)? error,
  }) {
    return success?.call(scheduledCourses, filteredCourses, searchQuery);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<ScheduledCourse> scheduledCourses,
            List<ScheduledCourse> filteredCourses, String searchQuery)?
        success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(scheduledCourses, filteredCourses, searchQuery);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CoursesPageLoadingState value) loading,
    required TResult Function(ScheduledCoursesPageSuccessState value) success,
    required TResult Function(CoursesPageErrorState value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CoursesPageLoadingState value)? loading,
    TResult? Function(ScheduledCoursesPageSuccessState value)? success,
    TResult? Function(CoursesPageErrorState value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CoursesPageLoadingState value)? loading,
    TResult Function(ScheduledCoursesPageSuccessState value)? success,
    TResult Function(CoursesPageErrorState value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class ScheduledCoursesPageSuccessState
    implements ScheduledCoursesPageState {
  const factory ScheduledCoursesPageSuccessState(
          {required final List<ScheduledCourse> scheduledCourses,
          required final List<ScheduledCourse> filteredCourses,
          required final String searchQuery}) =
      _$ScheduledCoursesPageSuccessStateImpl;

  List<ScheduledCourse> get scheduledCourses;
  List<ScheduledCourse> get filteredCourses;
  String get searchQuery;

  /// Create a copy of ScheduledCoursesPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScheduledCoursesPageSuccessStateImplCopyWith<
          _$ScheduledCoursesPageSuccessStateImpl>
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
    extends _$ScheduledCoursesPageStateCopyWithImpl<$Res,
        _$CoursesPageErrorStateImpl>
    implements _$$CoursesPageErrorStateImplCopyWith<$Res> {
  __$$CoursesPageErrorStateImplCopyWithImpl(_$CoursesPageErrorStateImpl _value,
      $Res Function(_$CoursesPageErrorStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ScheduledCoursesPageState
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
    return 'ScheduledCoursesPageState.error(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ScheduledCoursesPageState.error'))
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

  /// Create a copy of ScheduledCoursesPageState
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
    required TResult Function(List<ScheduledCourse> scheduledCourses,
            List<ScheduledCourse> filteredCourses, String searchQuery)
        success,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<ScheduledCourse> scheduledCourses,
            List<ScheduledCourse> filteredCourses, String searchQuery)?
        success,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<ScheduledCourse> scheduledCourses,
            List<ScheduledCourse> filteredCourses, String searchQuery)?
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
    required TResult Function(ScheduledCoursesPageSuccessState value) success,
    required TResult Function(CoursesPageErrorState value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CoursesPageLoadingState value)? loading,
    TResult? Function(ScheduledCoursesPageSuccessState value)? success,
    TResult? Function(CoursesPageErrorState value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CoursesPageLoadingState value)? loading,
    TResult Function(ScheduledCoursesPageSuccessState value)? success,
    TResult Function(CoursesPageErrorState value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class CoursesPageErrorState implements ScheduledCoursesPageState {
  const factory CoursesPageErrorState(final String message) =
      _$CoursesPageErrorStateImpl;

  String get message;

  /// Create a copy of ScheduledCoursesPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CoursesPageErrorStateImplCopyWith<_$CoursesPageErrorStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
