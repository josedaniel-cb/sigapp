// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'student_session_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$StudentSessionInfo {
  String get currentSemesterName => throw _privateConstructorUsedError;
  String get schoolName => throw _privateConstructorUsedError;

  /// Create a copy of StudentSessionInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StudentSessionInfoCopyWith<StudentSessionInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudentSessionInfoCopyWith<$Res> {
  factory $StudentSessionInfoCopyWith(
          StudentSessionInfo value, $Res Function(StudentSessionInfo) then) =
      _$StudentSessionInfoCopyWithImpl<$Res, StudentSessionInfo>;
  @useResult
  $Res call({String currentSemesterName, String schoolName});
}

/// @nodoc
class _$StudentSessionInfoCopyWithImpl<$Res, $Val extends StudentSessionInfo>
    implements $StudentSessionInfoCopyWith<$Res> {
  _$StudentSessionInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StudentSessionInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentSemesterName = null,
    Object? schoolName = null,
  }) {
    return _then(_value.copyWith(
      currentSemesterName: null == currentSemesterName
          ? _value.currentSemesterName
          : currentSemesterName // ignore: cast_nullable_to_non_nullable
              as String,
      schoolName: null == schoolName
          ? _value.schoolName
          : schoolName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StudentSessionInfoImplCopyWith<$Res>
    implements $StudentSessionInfoCopyWith<$Res> {
  factory _$$StudentSessionInfoImplCopyWith(_$StudentSessionInfoImpl value,
          $Res Function(_$StudentSessionInfoImpl) then) =
      __$$StudentSessionInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String currentSemesterName, String schoolName});
}

/// @nodoc
class __$$StudentSessionInfoImplCopyWithImpl<$Res>
    extends _$StudentSessionInfoCopyWithImpl<$Res, _$StudentSessionInfoImpl>
    implements _$$StudentSessionInfoImplCopyWith<$Res> {
  __$$StudentSessionInfoImplCopyWithImpl(_$StudentSessionInfoImpl _value,
      $Res Function(_$StudentSessionInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of StudentSessionInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentSemesterName = null,
    Object? schoolName = null,
  }) {
    return _then(_$StudentSessionInfoImpl(
      currentSemesterName: null == currentSemesterName
          ? _value.currentSemesterName
          : currentSemesterName // ignore: cast_nullable_to_non_nullable
              as String,
      schoolName: null == schoolName
          ? _value.schoolName
          : schoolName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$StudentSessionInfoImpl implements _StudentSessionInfo {
  _$StudentSessionInfoImpl(
      {required this.currentSemesterName, required this.schoolName});

  @override
  final String currentSemesterName;
  @override
  final String schoolName;

  @override
  String toString() {
    return 'StudentSessionInfo(currentSemesterName: $currentSemesterName, schoolName: $schoolName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudentSessionInfoImpl &&
            (identical(other.currentSemesterName, currentSemesterName) ||
                other.currentSemesterName == currentSemesterName) &&
            (identical(other.schoolName, schoolName) ||
                other.schoolName == schoolName));
  }

  @override
  int get hashCode => Object.hash(runtimeType, currentSemesterName, schoolName);

  /// Create a copy of StudentSessionInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StudentSessionInfoImplCopyWith<_$StudentSessionInfoImpl> get copyWith =>
      __$$StudentSessionInfoImplCopyWithImpl<_$StudentSessionInfoImpl>(
          this, _$identity);
}

abstract class _StudentSessionInfo implements StudentSessionInfo {
  factory _StudentSessionInfo(
      {required final String currentSemesterName,
      required final String schoolName}) = _$StudentSessionInfoImpl;

  @override
  String get currentSemesterName;
  @override
  String get schoolName;

  /// Create a copy of StudentSessionInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StudentSessionInfoImplCopyWith<_$StudentSessionInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
