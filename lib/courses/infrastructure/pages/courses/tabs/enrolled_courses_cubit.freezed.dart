// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'enrolled_courses_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EnrolledCoursesTabWidgetItem {
  RawEnrolledCourse get data => throw _privateConstructorUsedError;
  SyllabusState? get syllabusState => throw _privateConstructorUsedError;
  File? get syllabusFile => throw _privateConstructorUsedError;

  /// Create a copy of EnrolledCoursesTabWidgetItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EnrolledCoursesTabWidgetItemCopyWith<EnrolledCoursesTabWidgetItem>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EnrolledCoursesTabWidgetItemCopyWith<$Res> {
  factory $EnrolledCoursesTabWidgetItemCopyWith(
          EnrolledCoursesTabWidgetItem value,
          $Res Function(EnrolledCoursesTabWidgetItem) then) =
      _$EnrolledCoursesTabWidgetItemCopyWithImpl<$Res,
          EnrolledCoursesTabWidgetItem>;
  @useResult
  $Res call(
      {RawEnrolledCourse data,
      SyllabusState? syllabusState,
      File? syllabusFile});

  $RawEnrolledCourseCopyWith<$Res> get data;
}

/// @nodoc
class _$EnrolledCoursesTabWidgetItemCopyWithImpl<$Res,
        $Val extends EnrolledCoursesTabWidgetItem>
    implements $EnrolledCoursesTabWidgetItemCopyWith<$Res> {
  _$EnrolledCoursesTabWidgetItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EnrolledCoursesTabWidgetItem
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

  /// Create a copy of EnrolledCoursesTabWidgetItem
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
abstract class _$$EnrolledCoursesTabWidgetItemImplCopyWith<$Res>
    implements $EnrolledCoursesTabWidgetItemCopyWith<$Res> {
  factory _$$EnrolledCoursesTabWidgetItemImplCopyWith(
          _$EnrolledCoursesTabWidgetItemImpl value,
          $Res Function(_$EnrolledCoursesTabWidgetItemImpl) then) =
      __$$EnrolledCoursesTabWidgetItemImplCopyWithImpl<$Res>;
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
class __$$EnrolledCoursesTabWidgetItemImplCopyWithImpl<$Res>
    extends _$EnrolledCoursesTabWidgetItemCopyWithImpl<$Res,
        _$EnrolledCoursesTabWidgetItemImpl>
    implements _$$EnrolledCoursesTabWidgetItemImplCopyWith<$Res> {
  __$$EnrolledCoursesTabWidgetItemImplCopyWithImpl(
      _$EnrolledCoursesTabWidgetItemImpl _value,
      $Res Function(_$EnrolledCoursesTabWidgetItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of EnrolledCoursesTabWidgetItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? syllabusState = freezed,
    Object? syllabusFile = freezed,
  }) {
    return _then(_$EnrolledCoursesTabWidgetItemImpl(
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

class _$EnrolledCoursesTabWidgetItemImpl
    with DiagnosticableTreeMixin
    implements _EnrolledCoursesTabWidgetItem {
  _$EnrolledCoursesTabWidgetItemImpl(
      {required this.data, this.syllabusState, this.syllabusFile});

  @override
  final RawEnrolledCourse data;
  @override
  final SyllabusState? syllabusState;
  @override
  final File? syllabusFile;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'EnrolledCoursesTabWidgetItem(data: $data, syllabusState: $syllabusState, syllabusFile: $syllabusFile)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'EnrolledCoursesTabWidgetItem'))
      ..add(DiagnosticsProperty('data', data))
      ..add(DiagnosticsProperty('syllabusState', syllabusState))
      ..add(DiagnosticsProperty('syllabusFile', syllabusFile));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EnrolledCoursesTabWidgetItemImpl &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.syllabusState, syllabusState) ||
                other.syllabusState == syllabusState) &&
            (identical(other.syllabusFile, syllabusFile) ||
                other.syllabusFile == syllabusFile));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, data, syllabusState, syllabusFile);

  /// Create a copy of EnrolledCoursesTabWidgetItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EnrolledCoursesTabWidgetItemImplCopyWith<
          _$EnrolledCoursesTabWidgetItemImpl>
      get copyWith => __$$EnrolledCoursesTabWidgetItemImplCopyWithImpl<
          _$EnrolledCoursesTabWidgetItemImpl>(this, _$identity);
}

abstract class _EnrolledCoursesTabWidgetItem
    implements EnrolledCoursesTabWidgetItem {
  factory _EnrolledCoursesTabWidgetItem(
      {required final RawEnrolledCourse data,
      final SyllabusState? syllabusState,
      final File? syllabusFile}) = _$EnrolledCoursesTabWidgetItemImpl;

  @override
  RawEnrolledCourse get data;
  @override
  SyllabusState? get syllabusState;
  @override
  File? get syllabusFile;

  /// Create a copy of EnrolledCoursesTabWidgetItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EnrolledCoursesTabWidgetItemImplCopyWith<
          _$EnrolledCoursesTabWidgetItemImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$EnrolledCoursesTabState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            List<EnrolledCoursesTabWidgetItem> courses, String? errorMessage)
        success,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
            List<EnrolledCoursesTabWidgetItem> courses, String? errorMessage)?
        success,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            List<EnrolledCoursesTabWidgetItem> courses, String? errorMessage)?
        success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EnrolledCoursesTabLoadingState value) loading,
    required TResult Function(EnrolledCoursesTabSuccessState value) success,
    required TResult Function(EnrolledCoursesTabErrorState value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EnrolledCoursesTabLoadingState value)? loading,
    TResult? Function(EnrolledCoursesTabSuccessState value)? success,
    TResult? Function(EnrolledCoursesTabErrorState value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EnrolledCoursesTabLoadingState value)? loading,
    TResult Function(EnrolledCoursesTabSuccessState value)? success,
    TResult Function(EnrolledCoursesTabErrorState value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EnrolledCoursesTabStateCopyWith<$Res> {
  factory $EnrolledCoursesTabStateCopyWith(EnrolledCoursesTabState value,
          $Res Function(EnrolledCoursesTabState) then) =
      _$EnrolledCoursesTabStateCopyWithImpl<$Res, EnrolledCoursesTabState>;
}

/// @nodoc
class _$EnrolledCoursesTabStateCopyWithImpl<$Res,
        $Val extends EnrolledCoursesTabState>
    implements $EnrolledCoursesTabStateCopyWith<$Res> {
  _$EnrolledCoursesTabStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EnrolledCoursesTabState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$EnrolledCoursesTabLoadingStateImplCopyWith<$Res> {
  factory _$$EnrolledCoursesTabLoadingStateImplCopyWith(
          _$EnrolledCoursesTabLoadingStateImpl value,
          $Res Function(_$EnrolledCoursesTabLoadingStateImpl) then) =
      __$$EnrolledCoursesTabLoadingStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$EnrolledCoursesTabLoadingStateImplCopyWithImpl<$Res>
    extends _$EnrolledCoursesTabStateCopyWithImpl<$Res,
        _$EnrolledCoursesTabLoadingStateImpl>
    implements _$$EnrolledCoursesTabLoadingStateImplCopyWith<$Res> {
  __$$EnrolledCoursesTabLoadingStateImplCopyWithImpl(
      _$EnrolledCoursesTabLoadingStateImpl _value,
      $Res Function(_$EnrolledCoursesTabLoadingStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of EnrolledCoursesTabState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$EnrolledCoursesTabLoadingStateImpl
    with DiagnosticableTreeMixin
    implements EnrolledCoursesTabLoadingState {
  const _$EnrolledCoursesTabLoadingStateImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'EnrolledCoursesTabState.loading()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'EnrolledCoursesTabState.loading'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EnrolledCoursesTabLoadingStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            List<EnrolledCoursesTabWidgetItem> courses, String? errorMessage)
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
            List<EnrolledCoursesTabWidgetItem> courses, String? errorMessage)?
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
            List<EnrolledCoursesTabWidgetItem> courses, String? errorMessage)?
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
    required TResult Function(EnrolledCoursesTabLoadingState value) loading,
    required TResult Function(EnrolledCoursesTabSuccessState value) success,
    required TResult Function(EnrolledCoursesTabErrorState value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EnrolledCoursesTabLoadingState value)? loading,
    TResult? Function(EnrolledCoursesTabSuccessState value)? success,
    TResult? Function(EnrolledCoursesTabErrorState value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EnrolledCoursesTabLoadingState value)? loading,
    TResult Function(EnrolledCoursesTabSuccessState value)? success,
    TResult Function(EnrolledCoursesTabErrorState value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class EnrolledCoursesTabLoadingState
    implements EnrolledCoursesTabState {
  const factory EnrolledCoursesTabLoadingState() =
      _$EnrolledCoursesTabLoadingStateImpl;
}

/// @nodoc
abstract class _$$EnrolledCoursesTabSuccessStateImplCopyWith<$Res> {
  factory _$$EnrolledCoursesTabSuccessStateImplCopyWith(
          _$EnrolledCoursesTabSuccessStateImpl value,
          $Res Function(_$EnrolledCoursesTabSuccessStateImpl) then) =
      __$$EnrolledCoursesTabSuccessStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<EnrolledCoursesTabWidgetItem> courses, String? errorMessage});
}

/// @nodoc
class __$$EnrolledCoursesTabSuccessStateImplCopyWithImpl<$Res>
    extends _$EnrolledCoursesTabStateCopyWithImpl<$Res,
        _$EnrolledCoursesTabSuccessStateImpl>
    implements _$$EnrolledCoursesTabSuccessStateImplCopyWith<$Res> {
  __$$EnrolledCoursesTabSuccessStateImplCopyWithImpl(
      _$EnrolledCoursesTabSuccessStateImpl _value,
      $Res Function(_$EnrolledCoursesTabSuccessStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of EnrolledCoursesTabState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? courses = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$EnrolledCoursesTabSuccessStateImpl(
      courses: null == courses
          ? _value._courses
          : courses // ignore: cast_nullable_to_non_nullable
              as List<EnrolledCoursesTabWidgetItem>,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$EnrolledCoursesTabSuccessStateImpl
    with DiagnosticableTreeMixin
    implements EnrolledCoursesTabSuccessState {
  const _$EnrolledCoursesTabSuccessStateImpl(
      {required final List<EnrolledCoursesTabWidgetItem> courses,
      this.errorMessage})
      : _courses = courses;

  final List<EnrolledCoursesTabWidgetItem> _courses;
  @override
  List<EnrolledCoursesTabWidgetItem> get courses {
    if (_courses is EqualUnmodifiableListView) return _courses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_courses);
  }

  @override
  final String? errorMessage;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'EnrolledCoursesTabState.success(courses: $courses, errorMessage: $errorMessage)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'EnrolledCoursesTabState.success'))
      ..add(DiagnosticsProperty('courses', courses))
      ..add(DiagnosticsProperty('errorMessage', errorMessage));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EnrolledCoursesTabSuccessStateImpl &&
            const DeepCollectionEquality().equals(other._courses, _courses) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_courses), errorMessage);

  /// Create a copy of EnrolledCoursesTabState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EnrolledCoursesTabSuccessStateImplCopyWith<
          _$EnrolledCoursesTabSuccessStateImpl>
      get copyWith => __$$EnrolledCoursesTabSuccessStateImplCopyWithImpl<
          _$EnrolledCoursesTabSuccessStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            List<EnrolledCoursesTabWidgetItem> courses, String? errorMessage)
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
            List<EnrolledCoursesTabWidgetItem> courses, String? errorMessage)?
        success,
    TResult? Function(String message)? error,
  }) {
    return success?.call(courses, errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            List<EnrolledCoursesTabWidgetItem> courses, String? errorMessage)?
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
    required TResult Function(EnrolledCoursesTabLoadingState value) loading,
    required TResult Function(EnrolledCoursesTabSuccessState value) success,
    required TResult Function(EnrolledCoursesTabErrorState value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EnrolledCoursesTabLoadingState value)? loading,
    TResult? Function(EnrolledCoursesTabSuccessState value)? success,
    TResult? Function(EnrolledCoursesTabErrorState value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EnrolledCoursesTabLoadingState value)? loading,
    TResult Function(EnrolledCoursesTabSuccessState value)? success,
    TResult Function(EnrolledCoursesTabErrorState value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class EnrolledCoursesTabSuccessState
    implements EnrolledCoursesTabState {
  const factory EnrolledCoursesTabSuccessState(
      {required final List<EnrolledCoursesTabWidgetItem> courses,
      final String? errorMessage}) = _$EnrolledCoursesTabSuccessStateImpl;

  List<EnrolledCoursesTabWidgetItem> get courses;
  String? get errorMessage;

  /// Create a copy of EnrolledCoursesTabState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EnrolledCoursesTabSuccessStateImplCopyWith<
          _$EnrolledCoursesTabSuccessStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EnrolledCoursesTabErrorStateImplCopyWith<$Res> {
  factory _$$EnrolledCoursesTabErrorStateImplCopyWith(
          _$EnrolledCoursesTabErrorStateImpl value,
          $Res Function(_$EnrolledCoursesTabErrorStateImpl) then) =
      __$$EnrolledCoursesTabErrorStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$EnrolledCoursesTabErrorStateImplCopyWithImpl<$Res>
    extends _$EnrolledCoursesTabStateCopyWithImpl<$Res,
        _$EnrolledCoursesTabErrorStateImpl>
    implements _$$EnrolledCoursesTabErrorStateImplCopyWith<$Res> {
  __$$EnrolledCoursesTabErrorStateImplCopyWithImpl(
      _$EnrolledCoursesTabErrorStateImpl _value,
      $Res Function(_$EnrolledCoursesTabErrorStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of EnrolledCoursesTabState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$EnrolledCoursesTabErrorStateImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$EnrolledCoursesTabErrorStateImpl
    with DiagnosticableTreeMixin
    implements EnrolledCoursesTabErrorState {
  const _$EnrolledCoursesTabErrorStateImpl(this.message);

  @override
  final String message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'EnrolledCoursesTabState.error(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'EnrolledCoursesTabState.error'))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EnrolledCoursesTabErrorStateImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of EnrolledCoursesTabState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EnrolledCoursesTabErrorStateImplCopyWith<
          _$EnrolledCoursesTabErrorStateImpl>
      get copyWith => __$$EnrolledCoursesTabErrorStateImplCopyWithImpl<
          _$EnrolledCoursesTabErrorStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            List<EnrolledCoursesTabWidgetItem> courses, String? errorMessage)
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
            List<EnrolledCoursesTabWidgetItem> courses, String? errorMessage)?
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
            List<EnrolledCoursesTabWidgetItem> courses, String? errorMessage)?
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
    required TResult Function(EnrolledCoursesTabLoadingState value) loading,
    required TResult Function(EnrolledCoursesTabSuccessState value) success,
    required TResult Function(EnrolledCoursesTabErrorState value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EnrolledCoursesTabLoadingState value)? loading,
    TResult? Function(EnrolledCoursesTabSuccessState value)? success,
    TResult? Function(EnrolledCoursesTabErrorState value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EnrolledCoursesTabLoadingState value)? loading,
    TResult Function(EnrolledCoursesTabSuccessState value)? success,
    TResult Function(EnrolledCoursesTabErrorState value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class EnrolledCoursesTabErrorState implements EnrolledCoursesTabState {
  const factory EnrolledCoursesTabErrorState(final String message) =
      _$EnrolledCoursesTabErrorStateImpl;

  String get message;

  /// Create a copy of EnrolledCoursesTabState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EnrolledCoursesTabErrorStateImplCopyWith<
          _$EnrolledCoursesTabErrorStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
