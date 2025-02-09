// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'semester_context.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SemesterContext {
  bool get isLast => throw _privateConstructorUsedError;
  List<SemesterScheduleSemesterMetadata> get availableSemesters =>
      throw _privateConstructorUsedError;
  SemesterScheduleSemesterMetadata get defaultSemester =>
      throw _privateConstructorUsedError;

  /// Create a copy of SemesterContext
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SemesterContextCopyWith<SemesterContext> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SemesterContextCopyWith<$Res> {
  factory $SemesterContextCopyWith(
          SemesterContext value, $Res Function(SemesterContext) then) =
      _$SemesterContextCopyWithImpl<$Res, SemesterContext>;
  @useResult
  $Res call(
      {bool isLast,
      List<SemesterScheduleSemesterMetadata> availableSemesters,
      SemesterScheduleSemesterMetadata defaultSemester});
}

/// @nodoc
class _$SemesterContextCopyWithImpl<$Res, $Val extends SemesterContext>
    implements $SemesterContextCopyWith<$Res> {
  _$SemesterContextCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SemesterContext
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLast = null,
    Object? availableSemesters = null,
    Object? defaultSemester = null,
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
      defaultSemester: null == defaultSemester
          ? _value.defaultSemester
          : defaultSemester // ignore: cast_nullable_to_non_nullable
              as SemesterScheduleSemesterMetadata,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SemesterContextImplCopyWith<$Res>
    implements $SemesterContextCopyWith<$Res> {
  factory _$$SemesterContextImplCopyWith(_$SemesterContextImpl value,
          $Res Function(_$SemesterContextImpl) then) =
      __$$SemesterContextImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLast,
      List<SemesterScheduleSemesterMetadata> availableSemesters,
      SemesterScheduleSemesterMetadata defaultSemester});
}

/// @nodoc
class __$$SemesterContextImplCopyWithImpl<$Res>
    extends _$SemesterContextCopyWithImpl<$Res, _$SemesterContextImpl>
    implements _$$SemesterContextImplCopyWith<$Res> {
  __$$SemesterContextImplCopyWithImpl(
      _$SemesterContextImpl _value, $Res Function(_$SemesterContextImpl) _then)
      : super(_value, _then);

  /// Create a copy of SemesterContext
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLast = null,
    Object? availableSemesters = null,
    Object? defaultSemester = null,
  }) {
    return _then(_$SemesterContextImpl(
      isLast: null == isLast
          ? _value.isLast
          : isLast // ignore: cast_nullable_to_non_nullable
              as bool,
      availableSemesters: null == availableSemesters
          ? _value._availableSemesters
          : availableSemesters // ignore: cast_nullable_to_non_nullable
              as List<SemesterScheduleSemesterMetadata>,
      defaultSemester: null == defaultSemester
          ? _value.defaultSemester
          : defaultSemester // ignore: cast_nullable_to_non_nullable
              as SemesterScheduleSemesterMetadata,
    ));
  }
}

/// @nodoc

class _$SemesterContextImpl implements _SemesterContext {
  _$SemesterContextImpl(
      {required this.isLast,
      required final List<SemesterScheduleSemesterMetadata> availableSemesters,
      required this.defaultSemester})
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
  final SemesterScheduleSemesterMetadata defaultSemester;

  @override
  String toString() {
    return 'SemesterContext(isLast: $isLast, availableSemesters: $availableSemesters, defaultSemester: $defaultSemester)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SemesterContextImpl &&
            (identical(other.isLast, isLast) || other.isLast == isLast) &&
            const DeepCollectionEquality()
                .equals(other._availableSemesters, _availableSemesters) &&
            (identical(other.defaultSemester, defaultSemester) ||
                other.defaultSemester == defaultSemester));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLast,
      const DeepCollectionEquality().hash(_availableSemesters),
      defaultSemester);

  /// Create a copy of SemesterContext
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SemesterContextImplCopyWith<_$SemesterContextImpl> get copyWith =>
      __$$SemesterContextImplCopyWithImpl<_$SemesterContextImpl>(
          this, _$identity);
}

abstract class _SemesterContext implements SemesterContext {
  factory _SemesterContext(
      {required final bool isLast,
      required final List<SemesterScheduleSemesterMetadata> availableSemesters,
      required final SemesterScheduleSemesterMetadata
          defaultSemester}) = _$SemesterContextImpl;

  @override
  bool get isLast;
  @override
  List<SemesterScheduleSemesterMetadata> get availableSemesters;
  @override
  SemesterScheduleSemesterMetadata get defaultSemester;

  /// Create a copy of SemesterContext
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SemesterContextImplCopyWith<_$SemesterContextImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
