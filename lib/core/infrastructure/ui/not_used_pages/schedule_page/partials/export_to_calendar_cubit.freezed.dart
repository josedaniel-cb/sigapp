// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'export_to_calendar_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ExportToCalendarState implements DiagnosticableTreeMixin {




@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ExportToCalendarState'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExportToCalendarState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ExportToCalendarState()';
}


}

/// @nodoc
class $ExportToCalendarStateCopyWith<$Res>  {
$ExportToCalendarStateCopyWith(ExportToCalendarState _, $Res Function(ExportToCalendarState) __);
}


/// @nodoc


class LoadingState with DiagnosticableTreeMixin implements ExportToCalendarState {
  const LoadingState();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ExportToCalendarState.loading'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadingState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ExportToCalendarState.loading()';
}


}




/// @nodoc


class SuccessState with DiagnosticableTreeMixin implements ExportToCalendarState {
  const SuccessState({required final  List<Calendar> calendars, required this.selectedCalendar}): _calendars = calendars;
  

 final  List<Calendar> _calendars;
 List<Calendar> get calendars {
  if (_calendars is EqualUnmodifiableListView) return _calendars;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_calendars);
}

 final  Calendar selectedCalendar;

/// Create a copy of ExportToCalendarState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SuccessStateCopyWith<SuccessState> get copyWith => _$SuccessStateCopyWithImpl<SuccessState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ExportToCalendarState.success'))
    ..add(DiagnosticsProperty('calendars', calendars))..add(DiagnosticsProperty('selectedCalendar', selectedCalendar));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SuccessState&&const DeepCollectionEquality().equals(other._calendars, _calendars)&&(identical(other.selectedCalendar, selectedCalendar) || other.selectedCalendar == selectedCalendar));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_calendars),selectedCalendar);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ExportToCalendarState.success(calendars: $calendars, selectedCalendar: $selectedCalendar)';
}


}

/// @nodoc
abstract mixin class $SuccessStateCopyWith<$Res> implements $ExportToCalendarStateCopyWith<$Res> {
  factory $SuccessStateCopyWith(SuccessState value, $Res Function(SuccessState) _then) = _$SuccessStateCopyWithImpl;
@useResult
$Res call({
 List<Calendar> calendars, Calendar selectedCalendar
});




}
/// @nodoc
class _$SuccessStateCopyWithImpl<$Res>
    implements $SuccessStateCopyWith<$Res> {
  _$SuccessStateCopyWithImpl(this._self, this._then);

  final SuccessState _self;
  final $Res Function(SuccessState) _then;

/// Create a copy of ExportToCalendarState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? calendars = null,Object? selectedCalendar = null,}) {
  return _then(SuccessState(
calendars: null == calendars ? _self._calendars : calendars // ignore: cast_nullable_to_non_nullable
as List<Calendar>,selectedCalendar: null == selectedCalendar ? _self.selectedCalendar : selectedCalendar // ignore: cast_nullable_to_non_nullable
as Calendar,
  ));
}


}

/// @nodoc


class ErrorState with DiagnosticableTreeMixin implements ExportToCalendarState {
  const ErrorState(this.message);
  

 final  String message;

/// Create a copy of ExportToCalendarState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorStateCopyWith<ErrorState> get copyWith => _$ErrorStateCopyWithImpl<ErrorState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ExportToCalendarState.error'))
    ..add(DiagnosticsProperty('message', message));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ErrorState&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ExportToCalendarState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ErrorStateCopyWith<$Res> implements $ExportToCalendarStateCopyWith<$Res> {
  factory $ErrorStateCopyWith(ErrorState value, $Res Function(ErrorState) _then) = _$ErrorStateCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ErrorStateCopyWithImpl<$Res>
    implements $ErrorStateCopyWith<$Res> {
  _$ErrorStateCopyWithImpl(this._self, this._then);

  final ErrorState _self;
  final $Res Function(ErrorState) _then;

/// Create a copy of ExportToCalendarState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ErrorState(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
