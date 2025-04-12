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
  List<ScheduledTermIdentifier> get availableSemesters =>
      throw _privateConstructorUsedError;
  ScheduledTermIdentifier get defaultSemester =>
      throw _privateConstructorUsedError;
  bool get isLast => throw _privateConstructorUsedError;

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
      {List<ScheduledTermIdentifier> availableSemesters,
      ScheduledTermIdentifier defaultSemester,
      bool isLast});
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
    Object? availableSemesters = null,
    Object? defaultSemester = null,
    Object? isLast = null,
  }) {
    return _then(_value.copyWith(
      availableSemesters: null == availableSemesters
          ? _value.availableSemesters
          : availableSemesters // ignore: cast_nullable_to_non_nullable
              as List<ScheduledTermIdentifier>,
      defaultSemester: null == defaultSemester
          ? _value.defaultSemester
          : defaultSemester // ignore: cast_nullable_to_non_nullable
              as ScheduledTermIdentifier,
      isLast: null == isLast
          ? _value.isLast
          : isLast // ignore: cast_nullable_to_non_nullable
              as bool,
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
      {List<ScheduledTermIdentifier> availableSemesters,
      ScheduledTermIdentifier defaultSemester,
      bool isLast});
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
    Object? availableSemesters = null,
    Object? defaultSemester = null,
    Object? isLast = null,
  }) {
    return _then(_$SemesterContextImpl(
      availableSemesters: null == availableSemesters
          ? _value._availableSemesters
          : availableSemesters // ignore: cast_nullable_to_non_nullable
              as List<ScheduledTermIdentifier>,
      defaultSemester: null == defaultSemester
          ? _value.defaultSemester
          : defaultSemester // ignore: cast_nullable_to_non_nullable
              as ScheduledTermIdentifier,
      isLast: null == isLast
          ? _value.isLast
          : isLast // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SemesterContextImpl implements _SemesterContext {
  _$SemesterContextImpl(
      {required final List<ScheduledTermIdentifier> availableSemesters,
      required this.defaultSemester,
      required this.isLast})
      : _availableSemesters = availableSemesters;

  final List<ScheduledTermIdentifier> _availableSemesters;
  @override
  List<ScheduledTermIdentifier> get availableSemesters {
    if (_availableSemesters is EqualUnmodifiableListView)
      return _availableSemesters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableSemesters);
  }

  @override
  final ScheduledTermIdentifier defaultSemester;
  @override
  final bool isLast;

  @override
  String toString() {
    return 'SemesterContext(availableSemesters: $availableSemesters, defaultSemester: $defaultSemester, isLast: $isLast)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SemesterContextImpl &&
            const DeepCollectionEquality()
                .equals(other._availableSemesters, _availableSemesters) &&
            (identical(other.defaultSemester, defaultSemester) ||
                other.defaultSemester == defaultSemester) &&
            (identical(other.isLast, isLast) || other.isLast == isLast));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_availableSemesters),
      defaultSemester,
      isLast);

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
      {required final List<ScheduledTermIdentifier> availableSemesters,
      required final ScheduledTermIdentifier defaultSemester,
      required final bool isLast}) = _$SemesterContextImpl;

  @override
  List<ScheduledTermIdentifier> get availableSemesters;
  @override
  ScheduledTermIdentifier get defaultSemester;
  @override
  bool get isLast;

  /// Create a copy of SemesterContext
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SemesterContextImplCopyWith<_$SemesterContextImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
