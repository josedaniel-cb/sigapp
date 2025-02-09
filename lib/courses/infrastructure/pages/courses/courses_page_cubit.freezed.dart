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
mixin _$CoursesPageWidgetItem {
  RawEnrolledCourse get data => throw _privateConstructorUsedError;
  SyllabusState? get syllabusState => throw _privateConstructorUsedError;
  File? get syllabusFile => throw _privateConstructorUsedError;

  /// Create a copy of CoursesPageWidgetItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CoursesPageWidgetItemCopyWith<CoursesPageWidgetItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CoursesPageWidgetItemCopyWith<$Res> {
  factory $CoursesPageWidgetItemCopyWith(CoursesPageWidgetItem value,
          $Res Function(CoursesPageWidgetItem) then) =
      _$CoursesPageWidgetItemCopyWithImpl<$Res, CoursesPageWidgetItem>;
  @useResult
  $Res call(
      {RawEnrolledCourse data,
      SyllabusState? syllabusState,
      File? syllabusFile});

  $RawEnrolledCourseCopyWith<$Res> get data;
}

/// @nodoc
class _$CoursesPageWidgetItemCopyWithImpl<$Res,
        $Val extends CoursesPageWidgetItem>
    implements $CoursesPageWidgetItemCopyWith<$Res> {
  _$CoursesPageWidgetItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CoursesPageWidgetItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? syllabusState = freezed,
    Object? syllabusFile = freezed,
  }) {
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as RawEnrolledCourse,
      syllabusState: freezed == syllabusState
          ? _value.syllabusState
          : syllabusState // ignore: cast_nullable_to_non_nullable
              as SyllabusState?,
      syllabusFile: freezed == syllabusFile
          ? _value.syllabusFile
          : syllabusFile // ignore: cast_nullable_to_non_nullable
              as File?,
    ) as $Val);
  }

  /// Create a copy of CoursesPageWidgetItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RawEnrolledCourseCopyWith<$Res> get data {
    return $RawEnrolledCourseCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CoursesPageWidgetItemImplCopyWith<$Res>
    implements $CoursesPageWidgetItemCopyWith<$Res> {
  factory _$$CoursesPageWidgetItemImplCopyWith(
          _$CoursesPageWidgetItemImpl value,
          $Res Function(_$CoursesPageWidgetItemImpl) then) =
      __$$CoursesPageWidgetItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {RawEnrolledCourse data,
      SyllabusState? syllabusState,
      File? syllabusFile});

  @override
  $RawEnrolledCourseCopyWith<$Res> get data;
}

/// @nodoc
class __$$CoursesPageWidgetItemImplCopyWithImpl<$Res>
    extends _$CoursesPageWidgetItemCopyWithImpl<$Res,
        _$CoursesPageWidgetItemImpl>
    implements _$$CoursesPageWidgetItemImplCopyWith<$Res> {
  __$$CoursesPageWidgetItemImplCopyWithImpl(_$CoursesPageWidgetItemImpl _value,
      $Res Function(_$CoursesPageWidgetItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of CoursesPageWidgetItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? syllabusState = freezed,
    Object? syllabusFile = freezed,
  }) {
    return _then(_$CoursesPageWidgetItemImpl(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as RawEnrolledCourse,
      syllabusState: freezed == syllabusState
          ? _value.syllabusState
          : syllabusState // ignore: cast_nullable_to_non_nullable
              as SyllabusState?,
      syllabusFile: freezed == syllabusFile
          ? _value.syllabusFile
          : syllabusFile // ignore: cast_nullable_to_non_nullable
              as File?,
    ));
  }
}

/// @nodoc

class _$CoursesPageWidgetItemImpl
    with DiagnosticableTreeMixin
    implements _CoursesPageWidgetItem {
  _$CoursesPageWidgetItemImpl(
      {required this.data, this.syllabusState, this.syllabusFile});

  @override
  final RawEnrolledCourse data;
  @override
  final SyllabusState? syllabusState;
  @override
  final File? syllabusFile;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CoursesPageWidgetItem(data: $data, syllabusState: $syllabusState, syllabusFile: $syllabusFile)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CoursesPageWidgetItem'))
      ..add(DiagnosticsProperty('data', data))
      ..add(DiagnosticsProperty('syllabusState', syllabusState))
      ..add(DiagnosticsProperty('syllabusFile', syllabusFile));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CoursesPageWidgetItemImpl &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.syllabusState, syllabusState) ||
                other.syllabusState == syllabusState) &&
            (identical(other.syllabusFile, syllabusFile) ||
                other.syllabusFile == syllabusFile));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, data, syllabusState, syllabusFile);

  /// Create a copy of CoursesPageWidgetItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CoursesPageWidgetItemImplCopyWith<_$CoursesPageWidgetItemImpl>
      get copyWith => __$$CoursesPageWidgetItemImplCopyWithImpl<
          _$CoursesPageWidgetItemImpl>(this, _$identity);
}

abstract class _CoursesPageWidgetItem implements CoursesPageWidgetItem {
  factory _CoursesPageWidgetItem(
      {required final RawEnrolledCourse data,
      final SyllabusState? syllabusState,
      final File? syllabusFile}) = _$CoursesPageWidgetItemImpl;

  @override
  RawEnrolledCourse get data;
  @override
  SyllabusState? get syllabusState;
  @override
  File? get syllabusFile;

  /// Create a copy of CoursesPageWidgetItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CoursesPageWidgetItemImplCopyWith<_$CoursesPageWidgetItemImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CoursesPageState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            List<CoursesPageWidgetItem> courses, String? errorMessage)
        success,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
            List<CoursesPageWidgetItem> courses, String? errorMessage)?
        success,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<CoursesPageWidgetItem> courses, String? errorMessage)?
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
            List<CoursesPageWidgetItem> courses, String? errorMessage)
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
            List<CoursesPageWidgetItem> courses, String? errorMessage)?
        success,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<CoursesPageWidgetItem> courses, String? errorMessage)?
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
  $Res call({List<CoursesPageWidgetItem> courses, String? errorMessage});
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
              as List<CoursesPageWidgetItem>,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$CoursesPageSuccessStateImpl
    with DiagnosticableTreeMixin
    implements CoursesPageSuccessState {
  const _$CoursesPageSuccessStateImpl(
      {required final List<CoursesPageWidgetItem> courses, this.errorMessage})
      : _courses = courses;

  final List<CoursesPageWidgetItem> _courses;
  @override
  List<CoursesPageWidgetItem> get courses {
    if (_courses is EqualUnmodifiableListView) return _courses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_courses);
  }

  @override
  final String? errorMessage;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CoursesPageState.success(courses: $courses, errorMessage: $errorMessage)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CoursesPageState.success'))
      ..add(DiagnosticsProperty('courses', courses))
      ..add(DiagnosticsProperty('errorMessage', errorMessage));
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
            List<CoursesPageWidgetItem> courses, String? errorMessage)
        success,
    required TResult Function(String message) error,
  }) {
    return success(courses, errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
            List<CoursesPageWidgetItem> courses, String? errorMessage)?
        success,
    TResult? Function(String message)? error,
  }) {
    return success?.call(courses, errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<CoursesPageWidgetItem> courses, String? errorMessage)?
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
      {required final List<CoursesPageWidgetItem> courses,
      final String? errorMessage}) = _$CoursesPageSuccessStateImpl;

  List<CoursesPageWidgetItem> get courses;
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
            List<CoursesPageWidgetItem> courses, String? errorMessage)
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
            List<CoursesPageWidgetItem> courses, String? errorMessage)?
        success,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<CoursesPageWidgetItem> courses, String? errorMessage)?
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
