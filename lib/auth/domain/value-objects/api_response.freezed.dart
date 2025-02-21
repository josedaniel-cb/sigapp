// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ApiResponse {
  ApiPathAndMethod get pathAndMethod => throw _privateConstructorUsedError;
  int get statusCode => throw _privateConstructorUsedError;
  Map<String, List<String>> get headers => throw _privateConstructorUsedError;

  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApiResponseCopyWith<ApiResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiResponseCopyWith<$Res> {
  factory $ApiResponseCopyWith(
          ApiResponse value, $Res Function(ApiResponse) then) =
      _$ApiResponseCopyWithImpl<$Res, ApiResponse>;
  @useResult
  $Res call(
      {ApiPathAndMethod pathAndMethod,
      int statusCode,
      Map<String, List<String>> headers});

  $ApiPathAndMethodCopyWith<$Res> get pathAndMethod;
}

/// @nodoc
class _$ApiResponseCopyWithImpl<$Res, $Val extends ApiResponse>
    implements $ApiResponseCopyWith<$Res> {
  _$ApiResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pathAndMethod = null,
    Object? statusCode = null,
    Object? headers = null,
  }) {
    return _then(_value.copyWith(
      pathAndMethod: null == pathAndMethod
          ? _value.pathAndMethod
          : pathAndMethod // ignore: cast_nullable_to_non_nullable
              as ApiPathAndMethod,
      statusCode: null == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
      headers: null == headers
          ? _value.headers
          : headers // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>,
    ) as $Val);
  }

  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ApiPathAndMethodCopyWith<$Res> get pathAndMethod {
    return $ApiPathAndMethodCopyWith<$Res>(_value.pathAndMethod, (value) {
      return _then(_value.copyWith(pathAndMethod: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ApiResponseImplCopyWith<$Res>
    implements $ApiResponseCopyWith<$Res> {
  factory _$$ApiResponseImplCopyWith(
          _$ApiResponseImpl value, $Res Function(_$ApiResponseImpl) then) =
      __$$ApiResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ApiPathAndMethod pathAndMethod,
      int statusCode,
      Map<String, List<String>> headers});

  @override
  $ApiPathAndMethodCopyWith<$Res> get pathAndMethod;
}

/// @nodoc
class __$$ApiResponseImplCopyWithImpl<$Res>
    extends _$ApiResponseCopyWithImpl<$Res, _$ApiResponseImpl>
    implements _$$ApiResponseImplCopyWith<$Res> {
  __$$ApiResponseImplCopyWithImpl(
      _$ApiResponseImpl _value, $Res Function(_$ApiResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pathAndMethod = null,
    Object? statusCode = null,
    Object? headers = null,
  }) {
    return _then(_$ApiResponseImpl(
      pathAndMethod: null == pathAndMethod
          ? _value.pathAndMethod
          : pathAndMethod // ignore: cast_nullable_to_non_nullable
              as ApiPathAndMethod,
      statusCode: null == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
      headers: null == headers
          ? _value._headers
          : headers // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>,
    ));
  }
}

/// @nodoc

class _$ApiResponseImpl implements _ApiResponse {
  _$ApiResponseImpl(
      {required this.pathAndMethod,
      required this.statusCode,
      required final Map<String, List<String>> headers})
      : _headers = headers;

  @override
  final ApiPathAndMethod pathAndMethod;
  @override
  final int statusCode;
  final Map<String, List<String>> _headers;
  @override
  Map<String, List<String>> get headers {
    if (_headers is EqualUnmodifiableMapView) return _headers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_headers);
  }

  @override
  String toString() {
    return 'ApiResponse(pathAndMethod: $pathAndMethod, statusCode: $statusCode, headers: $headers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiResponseImpl &&
            (identical(other.pathAndMethod, pathAndMethod) ||
                other.pathAndMethod == pathAndMethod) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            const DeepCollectionEquality().equals(other._headers, _headers));
  }

  @override
  int get hashCode => Object.hash(runtimeType, pathAndMethod, statusCode,
      const DeepCollectionEquality().hash(_headers));

  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiResponseImplCopyWith<_$ApiResponseImpl> get copyWith =>
      __$$ApiResponseImplCopyWithImpl<_$ApiResponseImpl>(this, _$identity);
}

abstract class _ApiResponse implements ApiResponse {
  factory _ApiResponse(
      {required final ApiPathAndMethod pathAndMethod,
      required final int statusCode,
      required final Map<String, List<String>> headers}) = _$ApiResponseImpl;

  @override
  ApiPathAndMethod get pathAndMethod;
  @override
  int get statusCode;
  @override
  Map<String, List<String>> get headers;

  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApiResponseImplCopyWith<_$ApiResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
