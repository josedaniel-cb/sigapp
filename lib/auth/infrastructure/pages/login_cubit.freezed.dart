// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LoginState implements DiagnosticableTreeMixin {

 String get username; String get password; LoginStatus get status;
/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginStateCopyWith<LoginState> get copyWith => _$LoginStateCopyWithImpl<LoginState>(this as LoginState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'LoginState'))
    ..add(DiagnosticsProperty('username', username))..add(DiagnosticsProperty('password', password))..add(DiagnosticsProperty('status', status));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginState&&(identical(other.username, username) || other.username == username)&&(identical(other.password, password) || other.password == password)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,username,password,status);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'LoginState(username: $username, password: $password, status: $status)';
}


}

/// @nodoc
abstract mixin class $LoginStateCopyWith<$Res>  {
  factory $LoginStateCopyWith(LoginState value, $Res Function(LoginState) _then) = _$LoginStateCopyWithImpl;
@useResult
$Res call({
 String username, String password, LoginStatus status
});


$LoginStatusCopyWith<$Res> get status;

}
/// @nodoc
class _$LoginStateCopyWithImpl<$Res>
    implements $LoginStateCopyWith<$Res> {
  _$LoginStateCopyWithImpl(this._self, this._then);

  final LoginState _self;
  final $Res Function(LoginState) _then;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? username = null,Object? password = null,Object? status = null,}) {
  return _then(_self.copyWith(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoginStatus,
  ));
}
/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoginStatusCopyWith<$Res> get status {
  
  return $LoginStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}


/// @nodoc


class _LoginState with DiagnosticableTreeMixin implements LoginState {
  const _LoginState({required this.username, required this.password, required this.status});
  

@override final  String username;
@override final  String password;
@override final  LoginStatus status;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginStateCopyWith<_LoginState> get copyWith => __$LoginStateCopyWithImpl<_LoginState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'LoginState'))
    ..add(DiagnosticsProperty('username', username))..add(DiagnosticsProperty('password', password))..add(DiagnosticsProperty('status', status));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginState&&(identical(other.username, username) || other.username == username)&&(identical(other.password, password) || other.password == password)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,username,password,status);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'LoginState(username: $username, password: $password, status: $status)';
}


}

/// @nodoc
abstract mixin class _$LoginStateCopyWith<$Res> implements $LoginStateCopyWith<$Res> {
  factory _$LoginStateCopyWith(_LoginState value, $Res Function(_LoginState) _then) = __$LoginStateCopyWithImpl;
@override @useResult
$Res call({
 String username, String password, LoginStatus status
});


@override $LoginStatusCopyWith<$Res> get status;

}
/// @nodoc
class __$LoginStateCopyWithImpl<$Res>
    implements _$LoginStateCopyWith<$Res> {
  __$LoginStateCopyWithImpl(this._self, this._then);

  final _LoginState _self;
  final $Res Function(_LoginState) _then;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? username = null,Object? password = null,Object? status = null,}) {
  return _then(_LoginState(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoginStatus,
  ));
}

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoginStatusCopyWith<$Res> get status {
  
  return $LoginStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}

/// @nodoc
mixin _$LoginStatus implements DiagnosticableTreeMixin {




@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'LoginStatus'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginStatus);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'LoginStatus()';
}


}

/// @nodoc
class $LoginStatusCopyWith<$Res>  {
$LoginStatusCopyWith(LoginStatus _, $Res Function(LoginStatus) __);
}


/// @nodoc


class LoginInitial with DiagnosticableTreeMixin implements LoginStatus {
  const LoginInitial();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'LoginStatus.initial'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'LoginStatus.initial()';
}


}




/// @nodoc


class LoginLoading with DiagnosticableTreeMixin implements LoginStatus {
  const LoginLoading();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'LoginStatus.loading'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'LoginStatus.loading()';
}


}




/// @nodoc


class LoginSuccess with DiagnosticableTreeMixin implements LoginStatus {
  const LoginSuccess();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'LoginStatus.success'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'LoginStatus.success()';
}


}




/// @nodoc


class LoginError with DiagnosticableTreeMixin implements LoginStatus {
  const LoginError(this.message);
  

 final  String message;

/// Create a copy of LoginStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginErrorCopyWith<LoginError> get copyWith => _$LoginErrorCopyWithImpl<LoginError>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'LoginStatus.error'))
    ..add(DiagnosticsProperty('message', message));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'LoginStatus.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $LoginErrorCopyWith<$Res> implements $LoginStatusCopyWith<$Res> {
  factory $LoginErrorCopyWith(LoginError value, $Res Function(LoginError) _then) = _$LoginErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$LoginErrorCopyWithImpl<$Res>
    implements $LoginErrorCopyWith<$Res> {
  _$LoginErrorCopyWithImpl(this._self, this._then);

  final LoginError _self;
  final $Res Function(LoginError) _then;

/// Create a copy of LoginStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(LoginError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
