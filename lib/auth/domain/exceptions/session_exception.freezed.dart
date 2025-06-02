// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_exception.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SessionException {

 String get message; dynamic get originalError;
/// Create a copy of SessionException
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionExceptionCopyWith<SessionException> get copyWith => _$SessionExceptionCopyWithImpl<SessionException>(this as SessionException, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionException&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.originalError, originalError));
}


@override
int get hashCode => Object.hash(runtimeType,message,const DeepCollectionEquality().hash(originalError));

@override
String toString() {
  return 'SessionException(message: $message, originalError: $originalError)';
}


}

/// @nodoc
abstract mixin class $SessionExceptionCopyWith<$Res>  {
  factory $SessionExceptionCopyWith(SessionException value, $Res Function(SessionException) _then) = _$SessionExceptionCopyWithImpl;
@useResult
$Res call({
 String message, dynamic originalError
});




}
/// @nodoc
class _$SessionExceptionCopyWithImpl<$Res>
    implements $SessionExceptionCopyWith<$Res> {
  _$SessionExceptionCopyWithImpl(this._self, this._then);

  final SessionException _self;
  final $Res Function(SessionException) _then;

/// Create a copy of SessionException
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = null,Object? originalError = freezed,}) {
  return _then(_self.copyWith(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,originalError: freezed == originalError ? _self.originalError : originalError // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

}


/// @nodoc


class NetworkSessionException implements SessionException {
  const NetworkSessionException({required this.message, required this.originalError});
  

@override final  String message;
@override final  dynamic originalError;

/// Create a copy of SessionException
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NetworkSessionExceptionCopyWith<NetworkSessionException> get copyWith => _$NetworkSessionExceptionCopyWithImpl<NetworkSessionException>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworkSessionException&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.originalError, originalError));
}


@override
int get hashCode => Object.hash(runtimeType,message,const DeepCollectionEquality().hash(originalError));

@override
String toString() {
  return 'SessionException.networkError(message: $message, originalError: $originalError)';
}


}

/// @nodoc
abstract mixin class $NetworkSessionExceptionCopyWith<$Res> implements $SessionExceptionCopyWith<$Res> {
  factory $NetworkSessionExceptionCopyWith(NetworkSessionException value, $Res Function(NetworkSessionException) _then) = _$NetworkSessionExceptionCopyWithImpl;
@override @useResult
$Res call({
 String message, dynamic originalError
});




}
/// @nodoc
class _$NetworkSessionExceptionCopyWithImpl<$Res>
    implements $NetworkSessionExceptionCopyWith<$Res> {
  _$NetworkSessionExceptionCopyWithImpl(this._self, this._then);

  final NetworkSessionException _self;
  final $Res Function(NetworkSessionException) _then;

/// Create a copy of SessionException
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? originalError = freezed,}) {
  return _then(NetworkSessionException(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,originalError: freezed == originalError ? _self.originalError : originalError // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}

/// @nodoc


class RefreshSessionException implements SessionException {
  const RefreshSessionException({required this.message, required this.originalError});
  

@override final  String message;
@override final  dynamic originalError;

/// Create a copy of SessionException
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RefreshSessionExceptionCopyWith<RefreshSessionException> get copyWith => _$RefreshSessionExceptionCopyWithImpl<RefreshSessionException>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RefreshSessionException&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.originalError, originalError));
}


@override
int get hashCode => Object.hash(runtimeType,message,const DeepCollectionEquality().hash(originalError));

@override
String toString() {
  return 'SessionException.refreshError(message: $message, originalError: $originalError)';
}


}

/// @nodoc
abstract mixin class $RefreshSessionExceptionCopyWith<$Res> implements $SessionExceptionCopyWith<$Res> {
  factory $RefreshSessionExceptionCopyWith(RefreshSessionException value, $Res Function(RefreshSessionException) _then) = _$RefreshSessionExceptionCopyWithImpl;
@override @useResult
$Res call({
 String message, dynamic originalError
});




}
/// @nodoc
class _$RefreshSessionExceptionCopyWithImpl<$Res>
    implements $RefreshSessionExceptionCopyWith<$Res> {
  _$RefreshSessionExceptionCopyWithImpl(this._self, this._then);

  final RefreshSessionException _self;
  final $Res Function(RefreshSessionException) _then;

/// Create a copy of SessionException
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? originalError = freezed,}) {
  return _then(RefreshSessionException(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,originalError: freezed == originalError ? _self.originalError : originalError // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}

/// @nodoc


class AuthenticationSessionException implements SessionException {
  const AuthenticationSessionException({required this.message, required this.originalError});
  

@override final  String message;
@override final  dynamic originalError;

/// Create a copy of SessionException
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthenticationSessionExceptionCopyWith<AuthenticationSessionException> get copyWith => _$AuthenticationSessionExceptionCopyWithImpl<AuthenticationSessionException>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthenticationSessionException&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.originalError, originalError));
}


@override
int get hashCode => Object.hash(runtimeType,message,const DeepCollectionEquality().hash(originalError));

@override
String toString() {
  return 'SessionException.authenticationError(message: $message, originalError: $originalError)';
}


}

/// @nodoc
abstract mixin class $AuthenticationSessionExceptionCopyWith<$Res> implements $SessionExceptionCopyWith<$Res> {
  factory $AuthenticationSessionExceptionCopyWith(AuthenticationSessionException value, $Res Function(AuthenticationSessionException) _then) = _$AuthenticationSessionExceptionCopyWithImpl;
@override @useResult
$Res call({
 String message, dynamic originalError
});




}
/// @nodoc
class _$AuthenticationSessionExceptionCopyWithImpl<$Res>
    implements $AuthenticationSessionExceptionCopyWith<$Res> {
  _$AuthenticationSessionExceptionCopyWithImpl(this._self, this._then);

  final AuthenticationSessionException _self;
  final $Res Function(AuthenticationSessionException) _then;

/// Create a copy of SessionException
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? originalError = freezed,}) {
  return _then(AuthenticationSessionException(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,originalError: freezed == originalError ? _self.originalError : originalError // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}

/// @nodoc


class StudentInfoSessionException implements SessionException {
  const StudentInfoSessionException({required this.message, required this.originalError});
  

@override final  String message;
@override final  dynamic originalError;

/// Create a copy of SessionException
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudentInfoSessionExceptionCopyWith<StudentInfoSessionException> get copyWith => _$StudentInfoSessionExceptionCopyWithImpl<StudentInfoSessionException>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudentInfoSessionException&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.originalError, originalError));
}


@override
int get hashCode => Object.hash(runtimeType,message,const DeepCollectionEquality().hash(originalError));

@override
String toString() {
  return 'SessionException.studentInfoError(message: $message, originalError: $originalError)';
}


}

/// @nodoc
abstract mixin class $StudentInfoSessionExceptionCopyWith<$Res> implements $SessionExceptionCopyWith<$Res> {
  factory $StudentInfoSessionExceptionCopyWith(StudentInfoSessionException value, $Res Function(StudentInfoSessionException) _then) = _$StudentInfoSessionExceptionCopyWithImpl;
@override @useResult
$Res call({
 String message, dynamic originalError
});




}
/// @nodoc
class _$StudentInfoSessionExceptionCopyWithImpl<$Res>
    implements $StudentInfoSessionExceptionCopyWith<$Res> {
  _$StudentInfoSessionExceptionCopyWithImpl(this._self, this._then);

  final StudentInfoSessionException _self;
  final $Res Function(StudentInfoSessionException) _then;

/// Create a copy of SessionException
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? originalError = freezed,}) {
  return _then(StudentInfoSessionException(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,originalError: freezed == originalError ? _self.originalError : originalError // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}

/// @nodoc


class PendingSurveySessionException implements SessionException {
  const PendingSurveySessionException({required this.message, required this.originalError});
  

@override final  String message;
@override final  dynamic originalError;

/// Create a copy of SessionException
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PendingSurveySessionExceptionCopyWith<PendingSurveySessionException> get copyWith => _$PendingSurveySessionExceptionCopyWithImpl<PendingSurveySessionException>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PendingSurveySessionException&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.originalError, originalError));
}


@override
int get hashCode => Object.hash(runtimeType,message,const DeepCollectionEquality().hash(originalError));

@override
String toString() {
  return 'SessionException.pendingSurveyError(message: $message, originalError: $originalError)';
}


}

/// @nodoc
abstract mixin class $PendingSurveySessionExceptionCopyWith<$Res> implements $SessionExceptionCopyWith<$Res> {
  factory $PendingSurveySessionExceptionCopyWith(PendingSurveySessionException value, $Res Function(PendingSurveySessionException) _then) = _$PendingSurveySessionExceptionCopyWithImpl;
@override @useResult
$Res call({
 String message, dynamic originalError
});




}
/// @nodoc
class _$PendingSurveySessionExceptionCopyWithImpl<$Res>
    implements $PendingSurveySessionExceptionCopyWith<$Res> {
  _$PendingSurveySessionExceptionCopyWithImpl(this._self, this._then);

  final PendingSurveySessionException _self;
  final $Res Function(PendingSurveySessionException) _then;

/// Create a copy of SessionException
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? originalError = freezed,}) {
  return _then(PendingSurveySessionException(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,originalError: freezed == originalError ? _self.originalError : originalError // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}

/// @nodoc


class UnknownSessionException implements SessionException {
  const UnknownSessionException({required this.message, required this.originalError});
  

@override final  String message;
@override final  dynamic originalError;

/// Create a copy of SessionException
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnknownSessionExceptionCopyWith<UnknownSessionException> get copyWith => _$UnknownSessionExceptionCopyWithImpl<UnknownSessionException>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnknownSessionException&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.originalError, originalError));
}


@override
int get hashCode => Object.hash(runtimeType,message,const DeepCollectionEquality().hash(originalError));

@override
String toString() {
  return 'SessionException.unknownError(message: $message, originalError: $originalError)';
}


}

/// @nodoc
abstract mixin class $UnknownSessionExceptionCopyWith<$Res> implements $SessionExceptionCopyWith<$Res> {
  factory $UnknownSessionExceptionCopyWith(UnknownSessionException value, $Res Function(UnknownSessionException) _then) = _$UnknownSessionExceptionCopyWithImpl;
@override @useResult
$Res call({
 String message, dynamic originalError
});




}
/// @nodoc
class _$UnknownSessionExceptionCopyWithImpl<$Res>
    implements $UnknownSessionExceptionCopyWith<$Res> {
  _$UnknownSessionExceptionCopyWithImpl(this._self, this._then);

  final UnknownSessionException _self;
  final $Res Function(UnknownSessionException) _then;

/// Create a copy of SessionException
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? originalError = freezed,}) {
  return _then(UnknownSessionException(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,originalError: freezed == originalError ? _self.originalError : originalError // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}

// dart format on
