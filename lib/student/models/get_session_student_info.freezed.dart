// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_session_student_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GetSessionStudentInfoModel {
  String get currentSemesterId => throw _privateConstructorUsedError;
  String get schoolName => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GetSessionStudentInfoModelCopyWith<GetSessionStudentInfoModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetSessionStudentInfoModelCopyWith<$Res> {
  factory $GetSessionStudentInfoModelCopyWith(GetSessionStudentInfoModel value,
          $Res Function(GetSessionStudentInfoModel) then) =
      _$GetSessionStudentInfoModelCopyWithImpl<$Res,
          GetSessionStudentInfoModel>;
  @useResult
  $Res call({String currentSemesterId, String schoolName});
}

/// @nodoc
class _$GetSessionStudentInfoModelCopyWithImpl<$Res,
        $Val extends GetSessionStudentInfoModel>
    implements $GetSessionStudentInfoModelCopyWith<$Res> {
  _$GetSessionStudentInfoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentSemesterId = null,
    Object? schoolName = null,
  }) {
    return _then(_value.copyWith(
      currentSemesterId: null == currentSemesterId
          ? _value.currentSemesterId
          : currentSemesterId // ignore: cast_nullable_to_non_nullable
              as String,
      schoolName: null == schoolName
          ? _value.schoolName
          : schoolName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetSessionStudentInfoModelImplCopyWith<$Res>
    implements $GetSessionStudentInfoModelCopyWith<$Res> {
  factory _$$GetSessionStudentInfoModelImplCopyWith(
          _$GetSessionStudentInfoModelImpl value,
          $Res Function(_$GetSessionStudentInfoModelImpl) then) =
      __$$GetSessionStudentInfoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String currentSemesterId, String schoolName});
}

/// @nodoc
class __$$GetSessionStudentInfoModelImplCopyWithImpl<$Res>
    extends _$GetSessionStudentInfoModelCopyWithImpl<$Res,
        _$GetSessionStudentInfoModelImpl>
    implements _$$GetSessionStudentInfoModelImplCopyWith<$Res> {
  __$$GetSessionStudentInfoModelImplCopyWithImpl(
      _$GetSessionStudentInfoModelImpl _value,
      $Res Function(_$GetSessionStudentInfoModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentSemesterId = null,
    Object? schoolName = null,
  }) {
    return _then(_$GetSessionStudentInfoModelImpl(
      currentSemesterId: null == currentSemesterId
          ? _value.currentSemesterId
          : currentSemesterId // ignore: cast_nullable_to_non_nullable
              as String,
      schoolName: null == schoolName
          ? _value.schoolName
          : schoolName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$GetSessionStudentInfoModelImpl implements _GetSessionStudentInfoModel {
  _$GetSessionStudentInfoModelImpl(
      {required this.currentSemesterId, required this.schoolName});

  @override
  final String currentSemesterId;
  @override
  final String schoolName;

  @override
  String toString() {
    return 'GetSessionStudentInfoModel(currentSemesterId: $currentSemesterId, schoolName: $schoolName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetSessionStudentInfoModelImpl &&
            (identical(other.currentSemesterId, currentSemesterId) ||
                other.currentSemesterId == currentSemesterId) &&
            (identical(other.schoolName, schoolName) ||
                other.schoolName == schoolName));
  }

  @override
  int get hashCode => Object.hash(runtimeType, currentSemesterId, schoolName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetSessionStudentInfoModelImplCopyWith<_$GetSessionStudentInfoModelImpl>
      get copyWith => __$$GetSessionStudentInfoModelImplCopyWithImpl<
          _$GetSessionStudentInfoModelImpl>(this, _$identity);
}

abstract class _GetSessionStudentInfoModel
    implements GetSessionStudentInfoModel {
  factory _GetSessionStudentInfoModel(
      {required final String currentSemesterId,
      required final String schoolName}) = _$GetSessionStudentInfoModelImpl;

  @override
  String get currentSemesterId;
  @override
  String get schoolName;
  @override
  @JsonKey(ignore: true)
  _$$GetSessionStudentInfoModelImplCopyWith<_$GetSessionStudentInfoModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
