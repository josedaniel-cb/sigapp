// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ApiResponse {

 ApiPathAndMethod get pathAndMethod; int get statusCode; Map<String, List<String>> get headers;
/// Create a copy of ApiResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApiResponseCopyWith<ApiResponse> get copyWith => _$ApiResponseCopyWithImpl<ApiResponse>(this as ApiResponse, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApiResponse&&(identical(other.pathAndMethod, pathAndMethod) || other.pathAndMethod == pathAndMethod)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&const DeepCollectionEquality().equals(other.headers, headers));
}


@override
int get hashCode => Object.hash(runtimeType,pathAndMethod,statusCode,const DeepCollectionEquality().hash(headers));

@override
String toString() {
  return 'ApiResponse(pathAndMethod: $pathAndMethod, statusCode: $statusCode, headers: $headers)';
}


}

/// @nodoc
abstract mixin class $ApiResponseCopyWith<$Res>  {
  factory $ApiResponseCopyWith(ApiResponse value, $Res Function(ApiResponse) _then) = _$ApiResponseCopyWithImpl;
@useResult
$Res call({
 ApiPathAndMethod pathAndMethod, int statusCode, Map<String, List<String>> headers
});


$ApiPathAndMethodCopyWith<$Res> get pathAndMethod;

}
/// @nodoc
class _$ApiResponseCopyWithImpl<$Res>
    implements $ApiResponseCopyWith<$Res> {
  _$ApiResponseCopyWithImpl(this._self, this._then);

  final ApiResponse _self;
  final $Res Function(ApiResponse) _then;

/// Create a copy of ApiResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pathAndMethod = null,Object? statusCode = null,Object? headers = null,}) {
  return _then(_self.copyWith(
pathAndMethod: null == pathAndMethod ? _self.pathAndMethod : pathAndMethod // ignore: cast_nullable_to_non_nullable
as ApiPathAndMethod,statusCode: null == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int,headers: null == headers ? _self.headers : headers // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>,
  ));
}
/// Create a copy of ApiResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiPathAndMethodCopyWith<$Res> get pathAndMethod {
  
  return $ApiPathAndMethodCopyWith<$Res>(_self.pathAndMethod, (value) {
    return _then(_self.copyWith(pathAndMethod: value));
  });
}
}


/// @nodoc


class _ApiResponse implements ApiResponse {
   _ApiResponse({required this.pathAndMethod, required this.statusCode, required final  Map<String, List<String>> headers}): _headers = headers;
  

@override final  ApiPathAndMethod pathAndMethod;
@override final  int statusCode;
 final  Map<String, List<String>> _headers;
@override Map<String, List<String>> get headers {
  if (_headers is EqualUnmodifiableMapView) return _headers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_headers);
}


/// Create a copy of ApiResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApiResponseCopyWith<_ApiResponse> get copyWith => __$ApiResponseCopyWithImpl<_ApiResponse>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApiResponse&&(identical(other.pathAndMethod, pathAndMethod) || other.pathAndMethod == pathAndMethod)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&const DeepCollectionEquality().equals(other._headers, _headers));
}


@override
int get hashCode => Object.hash(runtimeType,pathAndMethod,statusCode,const DeepCollectionEquality().hash(_headers));

@override
String toString() {
  return 'ApiResponse(pathAndMethod: $pathAndMethod, statusCode: $statusCode, headers: $headers)';
}


}

/// @nodoc
abstract mixin class _$ApiResponseCopyWith<$Res> implements $ApiResponseCopyWith<$Res> {
  factory _$ApiResponseCopyWith(_ApiResponse value, $Res Function(_ApiResponse) _then) = __$ApiResponseCopyWithImpl;
@override @useResult
$Res call({
 ApiPathAndMethod pathAndMethod, int statusCode, Map<String, List<String>> headers
});


@override $ApiPathAndMethodCopyWith<$Res> get pathAndMethod;

}
/// @nodoc
class __$ApiResponseCopyWithImpl<$Res>
    implements _$ApiResponseCopyWith<$Res> {
  __$ApiResponseCopyWithImpl(this._self, this._then);

  final _ApiResponse _self;
  final $Res Function(_ApiResponse) _then;

/// Create a copy of ApiResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pathAndMethod = null,Object? statusCode = null,Object? headers = null,}) {
  return _then(_ApiResponse(
pathAndMethod: null == pathAndMethod ? _self.pathAndMethod : pathAndMethod // ignore: cast_nullable_to_non_nullable
as ApiPathAndMethod,statusCode: null == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int,headers: null == headers ? _self._headers : headers // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>,
  ));
}

/// Create a copy of ApiResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiPathAndMethodCopyWith<$Res> get pathAndMethod {
  
  return $ApiPathAndMethodCopyWith<$Res>(_self.pathAndMethod, (value) {
    return _then(_self.copyWith(pathAndMethod: value));
  });
}
}

// dart format on
