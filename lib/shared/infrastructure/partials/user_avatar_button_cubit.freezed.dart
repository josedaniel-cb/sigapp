// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_avatar_button_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserAvatarButtonState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserAvatarButtonState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UserAvatarButtonState()';
}


}

/// @nodoc
class $UserAvatarButtonStateCopyWith<$Res>  {
$UserAvatarButtonStateCopyWith(UserAvatarButtonState _, $Res Function(UserAvatarButtonState) __);
}


/// @nodoc


class UserAvatarButtonInitialState implements UserAvatarButtonState {
   UserAvatarButtonInitialState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserAvatarButtonInitialState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UserAvatarButtonState.initial()';
}


}




/// @nodoc


class UserAvatarButtonLoadingState implements UserAvatarButtonState {
   UserAvatarButtonLoadingState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserAvatarButtonLoadingState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UserAvatarButtonState.loading()';
}


}




/// @nodoc


class UserAvatarButtonSuccessState implements UserAvatarButtonState {
   UserAvatarButtonSuccessState({required this.data, this.errorMessage});
  

 final  AcademicInfoData data;
 final  String? errorMessage;

/// Create a copy of UserAvatarButtonState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserAvatarButtonSuccessStateCopyWith<UserAvatarButtonSuccessState> get copyWith => _$UserAvatarButtonSuccessStateCopyWithImpl<UserAvatarButtonSuccessState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserAvatarButtonSuccessState&&(identical(other.data, data) || other.data == data)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,data,errorMessage);

@override
String toString() {
  return 'UserAvatarButtonState.success(data: $data, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $UserAvatarButtonSuccessStateCopyWith<$Res> implements $UserAvatarButtonStateCopyWith<$Res> {
  factory $UserAvatarButtonSuccessStateCopyWith(UserAvatarButtonSuccessState value, $Res Function(UserAvatarButtonSuccessState) _then) = _$UserAvatarButtonSuccessStateCopyWithImpl;
@useResult
$Res call({
 AcademicInfoData data, String? errorMessage
});




}
/// @nodoc
class _$UserAvatarButtonSuccessStateCopyWithImpl<$Res>
    implements $UserAvatarButtonSuccessStateCopyWith<$Res> {
  _$UserAvatarButtonSuccessStateCopyWithImpl(this._self, this._then);

  final UserAvatarButtonSuccessState _self;
  final $Res Function(UserAvatarButtonSuccessState) _then;

/// Create a copy of UserAvatarButtonState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,Object? errorMessage = freezed,}) {
  return _then(UserAvatarButtonSuccessState(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as AcademicInfoData,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class UserAvatarButtonErrorState implements UserAvatarButtonState {
   UserAvatarButtonErrorState(this.error);
  

 final  dynamic error;

/// Create a copy of UserAvatarButtonState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserAvatarButtonErrorStateCopyWith<UserAvatarButtonErrorState> get copyWith => _$UserAvatarButtonErrorStateCopyWithImpl<UserAvatarButtonErrorState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserAvatarButtonErrorState&&const DeepCollectionEquality().equals(other.error, error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(error));

@override
String toString() {
  return 'UserAvatarButtonState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class $UserAvatarButtonErrorStateCopyWith<$Res> implements $UserAvatarButtonStateCopyWith<$Res> {
  factory $UserAvatarButtonErrorStateCopyWith(UserAvatarButtonErrorState value, $Res Function(UserAvatarButtonErrorState) _then) = _$UserAvatarButtonErrorStateCopyWithImpl;
@useResult
$Res call({
 dynamic error
});




}
/// @nodoc
class _$UserAvatarButtonErrorStateCopyWithImpl<$Res>
    implements $UserAvatarButtonErrorStateCopyWith<$Res> {
  _$UserAvatarButtonErrorStateCopyWithImpl(this._self, this._then);

  final UserAvatarButtonErrorState _self;
  final $Res Function(UserAvatarButtonErrorState) _then;

/// Create a copy of UserAvatarButtonState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = freezed,}) {
  return _then(UserAvatarButtonErrorState(
freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}

// dart format on
