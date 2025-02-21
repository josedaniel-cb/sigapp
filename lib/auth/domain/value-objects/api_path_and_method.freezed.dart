// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_path_and_method.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ApiPathAndMethod {
  ApiMethod get method => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;

  /// Create a copy of ApiPathAndMethod
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApiPathAndMethodCopyWith<ApiPathAndMethod> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiPathAndMethodCopyWith<$Res> {
  factory $ApiPathAndMethodCopyWith(
          ApiPathAndMethod value, $Res Function(ApiPathAndMethod) then) =
      _$ApiPathAndMethodCopyWithImpl<$Res, ApiPathAndMethod>;
  @useResult
  $Res call({ApiMethod method, String path});
}

/// @nodoc
class _$ApiPathAndMethodCopyWithImpl<$Res, $Val extends ApiPathAndMethod>
    implements $ApiPathAndMethodCopyWith<$Res> {
  _$ApiPathAndMethodCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApiPathAndMethod
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? method = null,
    Object? path = null,
  }) {
    return _then(_value.copyWith(
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as ApiMethod,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ApiPathAndMethodImplCopyWith<$Res>
    implements $ApiPathAndMethodCopyWith<$Res> {
  factory _$$ApiPathAndMethodImplCopyWith(_$ApiPathAndMethodImpl value,
          $Res Function(_$ApiPathAndMethodImpl) then) =
      __$$ApiPathAndMethodImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ApiMethod method, String path});
}

/// @nodoc
class __$$ApiPathAndMethodImplCopyWithImpl<$Res>
    extends _$ApiPathAndMethodCopyWithImpl<$Res, _$ApiPathAndMethodImpl>
    implements _$$ApiPathAndMethodImplCopyWith<$Res> {
  __$$ApiPathAndMethodImplCopyWithImpl(_$ApiPathAndMethodImpl _value,
      $Res Function(_$ApiPathAndMethodImpl) _then)
      : super(_value, _then);

  /// Create a copy of ApiPathAndMethod
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? method = null,
    Object? path = null,
  }) {
    return _then(_$ApiPathAndMethodImpl(
      null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as ApiMethod,
      null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ApiPathAndMethodImpl implements _ApiPathAndMethod {
  _$ApiPathAndMethodImpl(this.method, this.path);

  @override
  final ApiMethod method;
  @override
  final String path;

  @override
  String toString() {
    return 'ApiPathAndMethod(method: $method, path: $path)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiPathAndMethodImpl &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.path, path) || other.path == path));
  }

  @override
  int get hashCode => Object.hash(runtimeType, method, path);

  /// Create a copy of ApiPathAndMethod
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiPathAndMethodImplCopyWith<_$ApiPathAndMethodImpl> get copyWith =>
      __$$ApiPathAndMethodImplCopyWithImpl<_$ApiPathAndMethodImpl>(
          this, _$identity);
}

abstract class _ApiPathAndMethod implements ApiPathAndMethod {
  factory _ApiPathAndMethod(final ApiMethod method, final String path) =
      _$ApiPathAndMethodImpl;

  @override
  ApiMethod get method;
  @override
  String get path;

  /// Create a copy of ApiPathAndMethod
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApiPathAndMethodImplCopyWith<_$ApiPathAndMethodImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
