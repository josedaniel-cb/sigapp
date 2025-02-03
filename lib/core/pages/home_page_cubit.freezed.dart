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
  int get selectedTabIndex =>
      throw _privateConstructorUsedError; // required SemesterContext semesterContext,
  String? get errorMessage => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int selectedTabIndex, String? errorMessage)
        success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int selectedTabIndex, String? errorMessage)? success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int selectedTabIndex, String? errorMessage)? success,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HomePageSuccessState value) success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HomePageSuccessState value)? success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HomePageSuccessState value)? success,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of HomePageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomePageStateCopyWith<HomePageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomePageStateCopyWith<$Res> {
  factory $HomePageStateCopyWith(
          HomePageState value, $Res Function(HomePageState) then) =
      _$HomePageStateCopyWithImpl<$Res, HomePageState>;
  @useResult
  $Res call({int selectedTabIndex, String? errorMessage});
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
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedTabIndex = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      selectedTabIndex: null == selectedTabIndex
          ? _value.selectedTabIndex
          : selectedTabIndex // ignore: cast_nullable_to_non_nullable
              as int,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HomePageSuccessStateImplCopyWith<$Res>
    implements $HomePageStateCopyWith<$Res> {
  factory _$$HomePageSuccessStateImplCopyWith(_$HomePageSuccessStateImpl value,
          $Res Function(_$HomePageSuccessStateImpl) then) =
      __$$HomePageSuccessStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int selectedTabIndex, String? errorMessage});
}

/// @nodoc
class __$$HomePageSuccessStateImplCopyWithImpl<$Res>
    extends _$HomePageStateCopyWithImpl<$Res, _$HomePageSuccessStateImpl>
    implements _$$HomePageSuccessStateImplCopyWith<$Res> {
  __$$HomePageSuccessStateImplCopyWithImpl(_$HomePageSuccessStateImpl _value,
      $Res Function(_$HomePageSuccessStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomePageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedTabIndex = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$HomePageSuccessStateImpl(
      selectedTabIndex: null == selectedTabIndex
          ? _value.selectedTabIndex
          : selectedTabIndex // ignore: cast_nullable_to_non_nullable
              as int,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$HomePageSuccessStateImpl
    with DiagnosticableTreeMixin
    implements HomePageSuccessState {
  const _$HomePageSuccessStateImpl(
      {required this.selectedTabIndex, this.errorMessage});

  @override
  final int selectedTabIndex;
// required SemesterContext semesterContext,
  @override
  final String? errorMessage;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'HomePageState.success(selectedTabIndex: $selectedTabIndex, errorMessage: $errorMessage)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'HomePageState.success'))
      ..add(DiagnosticsProperty('selectedTabIndex', selectedTabIndex))
      ..add(DiagnosticsProperty('errorMessage', errorMessage));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomePageSuccessStateImpl &&
            (identical(other.selectedTabIndex, selectedTabIndex) ||
                other.selectedTabIndex == selectedTabIndex) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedTabIndex, errorMessage);

  /// Create a copy of HomePageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomePageSuccessStateImplCopyWith<_$HomePageSuccessStateImpl>
      get copyWith =>
          __$$HomePageSuccessStateImplCopyWithImpl<_$HomePageSuccessStateImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int selectedTabIndex, String? errorMessage)
        success,
  }) {
    return success(selectedTabIndex, errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int selectedTabIndex, String? errorMessage)? success,
  }) {
    return success?.call(selectedTabIndex, errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int selectedTabIndex, String? errorMessage)? success,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(selectedTabIndex, errorMessage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HomePageSuccessState value) success,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HomePageSuccessState value)? success,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HomePageSuccessState value)? success,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class HomePageSuccessState implements HomePageState {
  const factory HomePageSuccessState(
      {required final int selectedTabIndex,
      final String? errorMessage}) = _$HomePageSuccessStateImpl;

  @override
  int get selectedTabIndex; // required SemesterContext semesterContext,
  @override
  String? get errorMessage;

  /// Create a copy of HomePageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomePageSuccessStateImplCopyWith<_$HomePageSuccessStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
