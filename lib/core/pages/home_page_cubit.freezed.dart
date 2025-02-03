// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_page_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HomePageState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(int selectedIndex,
            DefaultSemester defaultSemester, String? errorMessage)
        ready,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(int selectedIndex, DefaultSemester defaultSemester,
            String? errorMessage)?
        ready,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(int selectedIndex, DefaultSemester defaultSemester,
            String? errorMessage)?
        ready,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HomePageLoadingState value) loading,
    required TResult Function(HomePageReadyState value) ready,
    required TResult Function(HomePageErrorState value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HomePageLoadingState value)? loading,
    TResult? Function(HomePageReadyState value)? ready,
    TResult? Function(HomePageErrorState value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HomePageLoadingState value)? loading,
    TResult Function(HomePageReadyState value)? ready,
    TResult Function(HomePageErrorState value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomePageStateCopyWith<$Res> {
  factory $HomePageStateCopyWith(
          HomePageState value, $Res Function(HomePageState) then) =
      _$HomePageStateCopyWithImpl<$Res, HomePageState>;
}

/// @nodoc
class _$HomePageStateCopyWithImpl<$Res, $Val extends HomePageState>
    implements $HomePageStateCopyWith<$Res> {
  _$HomePageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomePageState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$HomePageLoadingStateImplCopyWith<$Res> {
  factory _$$HomePageLoadingStateImplCopyWith(_$HomePageLoadingStateImpl value,
          $Res Function(_$HomePageLoadingStateImpl) then) =
      __$$HomePageLoadingStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$HomePageLoadingStateImplCopyWithImpl<$Res>
    extends _$HomePageStateCopyWithImpl<$Res, _$HomePageLoadingStateImpl>
    implements _$$HomePageLoadingStateImplCopyWith<$Res> {
  __$$HomePageLoadingStateImplCopyWithImpl(_$HomePageLoadingStateImpl _value,
      $Res Function(_$HomePageLoadingStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomePageState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$HomePageLoadingStateImpl
    with DiagnosticableTreeMixin
    implements HomePageLoadingState {
  const _$HomePageLoadingStateImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'HomePageState.loading()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'HomePageState.loading'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomePageLoadingStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(int selectedIndex,
            DefaultSemester defaultSemester, String? errorMessage)
        ready,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(int selectedIndex, DefaultSemester defaultSemester,
            String? errorMessage)?
        ready,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(int selectedIndex, DefaultSemester defaultSemester,
            String? errorMessage)?
        ready,
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
    required TResult Function(HomePageLoadingState value) loading,
    required TResult Function(HomePageReadyState value) ready,
    required TResult Function(HomePageErrorState value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HomePageLoadingState value)? loading,
    TResult? Function(HomePageReadyState value)? ready,
    TResult? Function(HomePageErrorState value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HomePageLoadingState value)? loading,
    TResult Function(HomePageReadyState value)? ready,
    TResult Function(HomePageErrorState value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class HomePageLoadingState implements HomePageState {
  const factory HomePageLoadingState() = _$HomePageLoadingStateImpl;
}

/// @nodoc
abstract class _$$HomePageReadyStateImplCopyWith<$Res> {
  factory _$$HomePageReadyStateImplCopyWith(_$HomePageReadyStateImpl value,
          $Res Function(_$HomePageReadyStateImpl) then) =
      __$$HomePageReadyStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {int selectedIndex,
      DefaultSemester defaultSemester,
      String? errorMessage});

  $DefaultSemesterCopyWith<$Res> get defaultSemester;
}

/// @nodoc
class __$$HomePageReadyStateImplCopyWithImpl<$Res>
    extends _$HomePageStateCopyWithImpl<$Res, _$HomePageReadyStateImpl>
    implements _$$HomePageReadyStateImplCopyWith<$Res> {
  __$$HomePageReadyStateImplCopyWithImpl(_$HomePageReadyStateImpl _value,
      $Res Function(_$HomePageReadyStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomePageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedIndex = null,
    Object? defaultSemester = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$HomePageReadyStateImpl(
      selectedIndex: null == selectedIndex
          ? _value.selectedIndex
          : selectedIndex // ignore: cast_nullable_to_non_nullable
              as int,
      defaultSemester: null == defaultSemester
          ? _value.defaultSemester
          : defaultSemester // ignore: cast_nullable_to_non_nullable
              as DefaultSemester,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of HomePageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DefaultSemesterCopyWith<$Res> get defaultSemester {
    return $DefaultSemesterCopyWith<$Res>(_value.defaultSemester, (value) {
      return _then(_value.copyWith(defaultSemester: value));
    });
  }
}

/// @nodoc

class _$HomePageReadyStateImpl
    with DiagnosticableTreeMixin
    implements HomePageReadyState {
  const _$HomePageReadyStateImpl(
      {required this.selectedIndex,
      required this.defaultSemester,
      this.errorMessage});

  @override
  final int selectedIndex;
  @override
  final DefaultSemester defaultSemester;
  @override
  final String? errorMessage;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'HomePageState.ready(selectedIndex: $selectedIndex, defaultSemester: $defaultSemester, errorMessage: $errorMessage)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'HomePageState.ready'))
      ..add(DiagnosticsProperty('selectedIndex', selectedIndex))
      ..add(DiagnosticsProperty('defaultSemester', defaultSemester))
      ..add(DiagnosticsProperty('errorMessage', errorMessage));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomePageReadyStateImpl &&
            (identical(other.selectedIndex, selectedIndex) ||
                other.selectedIndex == selectedIndex) &&
            (identical(other.defaultSemester, defaultSemester) ||
                other.defaultSemester == defaultSemester) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, selectedIndex, defaultSemester, errorMessage);

  /// Create a copy of HomePageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomePageReadyStateImplCopyWith<_$HomePageReadyStateImpl> get copyWith =>
      __$$HomePageReadyStateImplCopyWithImpl<_$HomePageReadyStateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(int selectedIndex,
            DefaultSemester defaultSemester, String? errorMessage)
        ready,
    required TResult Function(String message) error,
  }) {
    return ready(selectedIndex, defaultSemester, errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(int selectedIndex, DefaultSemester defaultSemester,
            String? errorMessage)?
        ready,
    TResult? Function(String message)? error,
  }) {
    return ready?.call(selectedIndex, defaultSemester, errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(int selectedIndex, DefaultSemester defaultSemester,
            String? errorMessage)?
        ready,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (ready != null) {
      return ready(selectedIndex, defaultSemester, errorMessage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HomePageLoadingState value) loading,
    required TResult Function(HomePageReadyState value) ready,
    required TResult Function(HomePageErrorState value) error,
  }) {
    return ready(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HomePageLoadingState value)? loading,
    TResult? Function(HomePageReadyState value)? ready,
    TResult? Function(HomePageErrorState value)? error,
  }) {
    return ready?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HomePageLoadingState value)? loading,
    TResult Function(HomePageReadyState value)? ready,
    TResult Function(HomePageErrorState value)? error,
    required TResult orElse(),
  }) {
    if (ready != null) {
      return ready(this);
    }
    return orElse();
  }
}

abstract class HomePageReadyState implements HomePageState {
  const factory HomePageReadyState(
      {required final int selectedIndex,
      required final DefaultSemester defaultSemester,
      final String? errorMessage}) = _$HomePageReadyStateImpl;

  int get selectedIndex;
  DefaultSemester get defaultSemester;
  String? get errorMessage;

  /// Create a copy of HomePageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomePageReadyStateImplCopyWith<_$HomePageReadyStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$HomePageErrorStateImplCopyWith<$Res> {
  factory _$$HomePageErrorStateImplCopyWith(_$HomePageErrorStateImpl value,
          $Res Function(_$HomePageErrorStateImpl) then) =
      __$$HomePageErrorStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$HomePageErrorStateImplCopyWithImpl<$Res>
    extends _$HomePageStateCopyWithImpl<$Res, _$HomePageErrorStateImpl>
    implements _$$HomePageErrorStateImplCopyWith<$Res> {
  __$$HomePageErrorStateImplCopyWithImpl(_$HomePageErrorStateImpl _value,
      $Res Function(_$HomePageErrorStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomePageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$HomePageErrorStateImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$HomePageErrorStateImpl
    with DiagnosticableTreeMixin
    implements HomePageErrorState {
  const _$HomePageErrorStateImpl(this.message);

  @override
  final String message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'HomePageState.error(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'HomePageState.error'))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomePageErrorStateImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of HomePageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomePageErrorStateImplCopyWith<_$HomePageErrorStateImpl> get copyWith =>
      __$$HomePageErrorStateImplCopyWithImpl<_$HomePageErrorStateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(int selectedIndex,
            DefaultSemester defaultSemester, String? errorMessage)
        ready,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(int selectedIndex, DefaultSemester defaultSemester,
            String? errorMessage)?
        ready,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(int selectedIndex, DefaultSemester defaultSemester,
            String? errorMessage)?
        ready,
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
    required TResult Function(HomePageLoadingState value) loading,
    required TResult Function(HomePageReadyState value) ready,
    required TResult Function(HomePageErrorState value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HomePageLoadingState value)? loading,
    TResult? Function(HomePageReadyState value)? ready,
    TResult? Function(HomePageErrorState value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HomePageLoadingState value)? loading,
    TResult Function(HomePageReadyState value)? ready,
    TResult Function(HomePageErrorState value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class HomePageErrorState implements HomePageState {
  const factory HomePageErrorState(final String message) =
      _$HomePageErrorStateImpl;

  String get message;

  /// Create a copy of HomePageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomePageErrorStateImplCopyWith<_$HomePageErrorStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
