// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course_visibility_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CourseVisibilityState {

 bool get isLoading; Map<String, bool> get hiddenEvents;
/// Create a copy of CourseVisibilityState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CourseVisibilityStateCopyWith<CourseVisibilityState> get copyWith => _$CourseVisibilityStateCopyWithImpl<CourseVisibilityState>(this as CourseVisibilityState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CourseVisibilityState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.hiddenEvents, hiddenEvents));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(hiddenEvents));

@override
String toString() {
  return 'CourseVisibilityState(isLoading: $isLoading, hiddenEvents: $hiddenEvents)';
}


}

/// @nodoc
abstract mixin class $CourseVisibilityStateCopyWith<$Res>  {
  factory $CourseVisibilityStateCopyWith(CourseVisibilityState value, $Res Function(CourseVisibilityState) _then) = _$CourseVisibilityStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, Map<String, bool> hiddenEvents
});




}
/// @nodoc
class _$CourseVisibilityStateCopyWithImpl<$Res>
    implements $CourseVisibilityStateCopyWith<$Res> {
  _$CourseVisibilityStateCopyWithImpl(this._self, this._then);

  final CourseVisibilityState _self;
  final $Res Function(CourseVisibilityState) _then;

/// Create a copy of CourseVisibilityState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? hiddenEvents = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,hiddenEvents: null == hiddenEvents ? _self.hiddenEvents : hiddenEvents // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,
  ));
}

}


/// @nodoc


class _CourseVisibilityState implements CourseVisibilityState {
  const _CourseVisibilityState({this.isLoading = true, final  Map<String, bool> hiddenEvents = const {}}): _hiddenEvents = hiddenEvents;
  

@override@JsonKey() final  bool isLoading;
 final  Map<String, bool> _hiddenEvents;
@override@JsonKey() Map<String, bool> get hiddenEvents {
  if (_hiddenEvents is EqualUnmodifiableMapView) return _hiddenEvents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_hiddenEvents);
}


/// Create a copy of CourseVisibilityState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CourseVisibilityStateCopyWith<_CourseVisibilityState> get copyWith => __$CourseVisibilityStateCopyWithImpl<_CourseVisibilityState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CourseVisibilityState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._hiddenEvents, _hiddenEvents));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_hiddenEvents));

@override
String toString() {
  return 'CourseVisibilityState(isLoading: $isLoading, hiddenEvents: $hiddenEvents)';
}


}

/// @nodoc
abstract mixin class _$CourseVisibilityStateCopyWith<$Res> implements $CourseVisibilityStateCopyWith<$Res> {
  factory _$CourseVisibilityStateCopyWith(_CourseVisibilityState value, $Res Function(_CourseVisibilityState) _then) = __$CourseVisibilityStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, Map<String, bool> hiddenEvents
});




}
/// @nodoc
class __$CourseVisibilityStateCopyWithImpl<$Res>
    implements _$CourseVisibilityStateCopyWith<$Res> {
  __$CourseVisibilityStateCopyWithImpl(this._self, this._then);

  final _CourseVisibilityState _self;
  final $Res Function(_CourseVisibilityState) _then;

/// Create a copy of CourseVisibilityState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? hiddenEvents = null,}) {
  return _then(_CourseVisibilityState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,hiddenEvents: null == hiddenEvents ? _self._hiddenEvents : hiddenEvents // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,
  ));
}


}

// dart format on
