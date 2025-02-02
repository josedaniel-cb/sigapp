// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'default_semester_id.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DefaultSemester {
  bool get isLast => throw _privateConstructorUsedError;
  List<SemesterScheduleSemesterMetadata> get availableSemesters =>
      throw _privateConstructorUsedError;
  SemesterScheduleSemesterMetadata get semester =>
      throw _privateConstructorUsedError;

  /// Create a copy of DefaultSemester
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DefaultSemesterCopyWith<DefaultSemester> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DefaultSemesterCopyWith<$Res> {
  factory $DefaultSemesterCopyWith(
          DefaultSemester value, $Res Function(DefaultSemester) then) =
      _$DefaultSemesterCopyWithImpl<$Res, DefaultSemester>;
  @useResult
  $Res call(
      {bool isLast,
      List<SemesterScheduleSemesterMetadata> availableSemesters,
      SemesterScheduleSemesterMetadata semester});

  $SemesterScheduleSemesterMetadataCopyWith<$Res> get semester;
}

/// @nodoc
class _$DefaultSemesterCopyWithImpl<$Res, $Val extends DefaultSemester>
    implements $DefaultSemesterCopyWith<$Res> {
  _$DefaultSemesterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DefaultSemester
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLast = null,
    Object? availableSemesters = null,
    Object? semester = null,
  }) {
    return _then(_value.copyWith(
      isLast: null == isLast
          ? _value.isLast
          : isLast // ignore: cast_nullable_to_non_nullable
              as bool,
      availableSemesters: null == availableSemesters
          ? _value.availableSemesters
          : availableSemesters // ignore: cast_nullable_to_non_nullable
              as List<SemesterScheduleSemesterMetadata>,
      semester: null == semester
          ? _value.semester
          : semester // ignore: cast_nullable_to_non_nullable
              as SemesterScheduleSemesterMetadata,
    ) as $Val);
  }

  /// Create a copy of DefaultSemester
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SemesterScheduleSemesterMetadataCopyWith<$Res> get semester {
    return $SemesterScheduleSemesterMetadataCopyWith<$Res>(_value.semester,
        (value) {
      return _then(_value.copyWith(semester: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DefaultSemesterImplCopyWith<$Res>
    implements $DefaultSemesterCopyWith<$Res> {
  factory _$$DefaultSemesterImplCopyWith(_$DefaultSemesterImpl value,
          $Res Function(_$DefaultSemesterImpl) then) =
      __$$DefaultSemesterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLast,
      List<SemesterScheduleSemesterMetadata> availableSemesters,
      SemesterScheduleSemesterMetadata semester});

  @override
  $SemesterScheduleSemesterMetadataCopyWith<$Res> get semester;
}

/// @nodoc
class __$$DefaultSemesterImplCopyWithImpl<$Res>
    extends _$DefaultSemesterCopyWithImpl<$Res, _$DefaultSemesterImpl>
    implements _$$DefaultSemesterImplCopyWith<$Res> {
  __$$DefaultSemesterImplCopyWithImpl(
      _$DefaultSemesterImpl _value, $Res Function(_$DefaultSemesterImpl) _then)
      : super(_value, _then);

  /// Create a copy of DefaultSemester
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLast = null,
    Object? availableSemesters = null,
    Object? semester = null,
  }) {
    return _then(_$DefaultSemesterImpl(
      isLast: null == isLast
          ? _value.isLast
          : isLast // ignore: cast_nullable_to_non_nullable
              as bool,
      availableSemesters: null == availableSemesters
          ? _value._availableSemesters
          : availableSemesters // ignore: cast_nullable_to_non_nullable
              as List<SemesterScheduleSemesterMetadata>,
      semester: null == semester
          ? _value.semester
          : semester // ignore: cast_nullable_to_non_nullable
              as SemesterScheduleSemesterMetadata,
    ));
  }
}

/// @nodoc

class _$DefaultSemesterImpl implements _DefaultSemester {
  _$DefaultSemesterImpl(
      {required this.isLast,
      required final List<SemesterScheduleSemesterMetadata> availableSemesters,
      required this.semester})
      : _availableSemesters = availableSemesters;

  @override
  final bool isLast;
  final List<SemesterScheduleSemesterMetadata> _availableSemesters;
  @override
  List<SemesterScheduleSemesterMetadata> get availableSemesters {
    if (_availableSemesters is EqualUnmodifiableListView)
      return _availableSemesters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableSemesters);
  }

  @override
  final SemesterScheduleSemesterMetadata semester;

  @override
  String toString() {
    return 'DefaultSemester(isLast: $isLast, availableSemesters: $availableSemesters, semester: $semester)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DefaultSemesterImpl &&
            (identical(other.isLast, isLast) || other.isLast == isLast) &&
            const DeepCollectionEquality()
                .equals(other._availableSemesters, _availableSemesters) &&
            (identical(other.semester, semester) ||
                other.semester == semester));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLast,
      const DeepCollectionEquality().hash(_availableSemesters), semester);

  /// Create a copy of DefaultSemester
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DefaultSemesterImplCopyWith<_$DefaultSemesterImpl> get copyWith =>
      __$$DefaultSemesterImplCopyWithImpl<_$DefaultSemesterImpl>(
          this, _$identity);
}

abstract class _DefaultSemester implements DefaultSemester {
  factory _DefaultSemester(
      {required final bool isLast,
      required final List<SemesterScheduleSemesterMetadata> availableSemesters,
      required final SemesterScheduleSemesterMetadata
          semester}) = _$DefaultSemesterImpl;

  @override
  bool get isLast;
  @override
  List<SemesterScheduleSemesterMetadata> get availableSemesters;
  @override
  SemesterScheduleSemesterMetadata get semester;

  /// Create a copy of DefaultSemester
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DefaultSemesterImplCopyWith<_$DefaultSemesterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
