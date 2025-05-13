// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course_visibility_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CourseVisibilityState {
  bool get isLoading => throw _privateConstructorUsedError;
  Map<String, bool> get hiddenEvents => throw _privateConstructorUsedError;

  /// Create a copy of CourseVisibilityState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CourseVisibilityStateCopyWith<CourseVisibilityState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CourseVisibilityStateCopyWith<$Res> {
  factory $CourseVisibilityStateCopyWith(CourseVisibilityState value,
          $Res Function(CourseVisibilityState) then) =
      _$CourseVisibilityStateCopyWithImpl<$Res, CourseVisibilityState>;
  @useResult
  $Res call({bool isLoading, Map<String, bool> hiddenEvents});
}

/// @nodoc
class _$CourseVisibilityStateCopyWithImpl<$Res,
        $Val extends CourseVisibilityState>
    implements $CourseVisibilityStateCopyWith<$Res> {
  _$CourseVisibilityStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CourseVisibilityState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? hiddenEvents = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      hiddenEvents: null == hiddenEvents
          ? _value.hiddenEvents
          : hiddenEvents // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CourseVisibilityStateImplCopyWith<$Res>
    implements $CourseVisibilityStateCopyWith<$Res> {
  factory _$$CourseVisibilityStateImplCopyWith(
          _$CourseVisibilityStateImpl value,
          $Res Function(_$CourseVisibilityStateImpl) then) =
      __$$CourseVisibilityStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, Map<String, bool> hiddenEvents});
}

/// @nodoc
class __$$CourseVisibilityStateImplCopyWithImpl<$Res>
    extends _$CourseVisibilityStateCopyWithImpl<$Res,
        _$CourseVisibilityStateImpl>
    implements _$$CourseVisibilityStateImplCopyWith<$Res> {
  __$$CourseVisibilityStateImplCopyWithImpl(_$CourseVisibilityStateImpl _value,
      $Res Function(_$CourseVisibilityStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CourseVisibilityState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? hiddenEvents = null,
  }) {
    return _then(_$CourseVisibilityStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      hiddenEvents: null == hiddenEvents
          ? _value._hiddenEvents
          : hiddenEvents // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
    ));
  }
}

/// @nodoc

class _$CourseVisibilityStateImpl implements _CourseVisibilityState {
  const _$CourseVisibilityStateImpl(
      {this.isLoading = true, final Map<String, bool> hiddenEvents = const {}})
      : _hiddenEvents = hiddenEvents;

  @override
  @JsonKey()
  final bool isLoading;
  final Map<String, bool> _hiddenEvents;
  @override
  @JsonKey()
  Map<String, bool> get hiddenEvents {
    if (_hiddenEvents is EqualUnmodifiableMapView) return _hiddenEvents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_hiddenEvents);
  }

  @override
  String toString() {
    return 'CourseVisibilityState(isLoading: $isLoading, hiddenEvents: $hiddenEvents)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CourseVisibilityStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality()
                .equals(other._hiddenEvents, _hiddenEvents));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading,
      const DeepCollectionEquality().hash(_hiddenEvents));

  /// Create a copy of CourseVisibilityState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CourseVisibilityStateImplCopyWith<_$CourseVisibilityStateImpl>
      get copyWith => __$$CourseVisibilityStateImplCopyWithImpl<
          _$CourseVisibilityStateImpl>(this, _$identity);
}

abstract class _CourseVisibilityState implements CourseVisibilityState {
  const factory _CourseVisibilityState(
      {final bool isLoading,
      final Map<String, bool> hiddenEvents}) = _$CourseVisibilityStateImpl;

  @override
  bool get isLoading;
  @override
  Map<String, bool> get hiddenEvents;

  /// Create a copy of CourseVisibilityState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CourseVisibilityStateImplCopyWith<_$CourseVisibilityStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
