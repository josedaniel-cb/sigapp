// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_course_requirements.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetCourseRequirementsModel _$GetCourseRequirementsModelFromJson(
    Map<String, dynamic> json) {
  return _GetCourseRequirementsModel.fromJson(json);
}

/// @nodoc
mixin _$GetCourseRequirementsModel {
  String get CodCursoPlan => throw _privateConstructorUsedError;
  String get CodCursoRequisito => throw _privateConstructorUsedError;
  String get DescCursoRequisito => throw _privateConstructorUsedError;
  String get Nota => throw _privateConstructorUsedError;
  String get Semestre => throw _privateConstructorUsedError;

  /// Serializes this GetCourseRequirementsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetCourseRequirementsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetCourseRequirementsModelCopyWith<GetCourseRequirementsModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetCourseRequirementsModelCopyWith<$Res> {
  factory $GetCourseRequirementsModelCopyWith(GetCourseRequirementsModel value,
          $Res Function(GetCourseRequirementsModel) then) =
      _$GetCourseRequirementsModelCopyWithImpl<$Res,
          GetCourseRequirementsModel>;
  @useResult
  $Res call(
      {String CodCursoPlan,
      String CodCursoRequisito,
      String DescCursoRequisito,
      String Nota,
      String Semestre});
}

/// @nodoc
class _$GetCourseRequirementsModelCopyWithImpl<$Res,
        $Val extends GetCourseRequirementsModel>
    implements $GetCourseRequirementsModelCopyWith<$Res> {
  _$GetCourseRequirementsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetCourseRequirementsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? CodCursoPlan = null,
    Object? CodCursoRequisito = null,
    Object? DescCursoRequisito = null,
    Object? Nota = null,
    Object? Semestre = null,
  }) {
    return _then(_value.copyWith(
      CodCursoPlan: null == CodCursoPlan
          ? _value.CodCursoPlan
          : CodCursoPlan // ignore: cast_nullable_to_non_nullable
              as String,
      CodCursoRequisito: null == CodCursoRequisito
          ? _value.CodCursoRequisito
          : CodCursoRequisito // ignore: cast_nullable_to_non_nullable
              as String,
      DescCursoRequisito: null == DescCursoRequisito
          ? _value.DescCursoRequisito
          : DescCursoRequisito // ignore: cast_nullable_to_non_nullable
              as String,
      Nota: null == Nota
          ? _value.Nota
          : Nota // ignore: cast_nullable_to_non_nullable
              as String,
      Semestre: null == Semestre
          ? _value.Semestre
          : Semestre // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetCourseRequirementsModelImplCopyWith<$Res>
    implements $GetCourseRequirementsModelCopyWith<$Res> {
  factory _$$GetCourseRequirementsModelImplCopyWith(
          _$GetCourseRequirementsModelImpl value,
          $Res Function(_$GetCourseRequirementsModelImpl) then) =
      __$$GetCourseRequirementsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String CodCursoPlan,
      String CodCursoRequisito,
      String DescCursoRequisito,
      String Nota,
      String Semestre});
}

/// @nodoc
class __$$GetCourseRequirementsModelImplCopyWithImpl<$Res>
    extends _$GetCourseRequirementsModelCopyWithImpl<$Res,
        _$GetCourseRequirementsModelImpl>
    implements _$$GetCourseRequirementsModelImplCopyWith<$Res> {
  __$$GetCourseRequirementsModelImplCopyWithImpl(
      _$GetCourseRequirementsModelImpl _value,
      $Res Function(_$GetCourseRequirementsModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetCourseRequirementsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? CodCursoPlan = null,
    Object? CodCursoRequisito = null,
    Object? DescCursoRequisito = null,
    Object? Nota = null,
    Object? Semestre = null,
  }) {
    return _then(_$GetCourseRequirementsModelImpl(
      CodCursoPlan: null == CodCursoPlan
          ? _value.CodCursoPlan
          : CodCursoPlan // ignore: cast_nullable_to_non_nullable
              as String,
      CodCursoRequisito: null == CodCursoRequisito
          ? _value.CodCursoRequisito
          : CodCursoRequisito // ignore: cast_nullable_to_non_nullable
              as String,
      DescCursoRequisito: null == DescCursoRequisito
          ? _value.DescCursoRequisito
          : DescCursoRequisito // ignore: cast_nullable_to_non_nullable
              as String,
      Nota: null == Nota
          ? _value.Nota
          : Nota // ignore: cast_nullable_to_non_nullable
              as String,
      Semestre: null == Semestre
          ? _value.Semestre
          : Semestre // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetCourseRequirementsModelImpl implements _GetCourseRequirementsModel {
  _$GetCourseRequirementsModelImpl(
      {required this.CodCursoPlan,
      required this.CodCursoRequisito,
      required this.DescCursoRequisito,
      required this.Nota,
      required this.Semestre});

  factory _$GetCourseRequirementsModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GetCourseRequirementsModelImplFromJson(json);

  @override
  final String CodCursoPlan;
  @override
  final String CodCursoRequisito;
  @override
  final String DescCursoRequisito;
  @override
  final String Nota;
  @override
  final String Semestre;

  @override
  String toString() {
    return 'GetCourseRequirementsModel(CodCursoPlan: $CodCursoPlan, CodCursoRequisito: $CodCursoRequisito, DescCursoRequisito: $DescCursoRequisito, Nota: $Nota, Semestre: $Semestre)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetCourseRequirementsModelImpl &&
            (identical(other.CodCursoPlan, CodCursoPlan) ||
                other.CodCursoPlan == CodCursoPlan) &&
            (identical(other.CodCursoRequisito, CodCursoRequisito) ||
                other.CodCursoRequisito == CodCursoRequisito) &&
            (identical(other.DescCursoRequisito, DescCursoRequisito) ||
                other.DescCursoRequisito == DescCursoRequisito) &&
            (identical(other.Nota, Nota) || other.Nota == Nota) &&
            (identical(other.Semestre, Semestre) ||
                other.Semestre == Semestre));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, CodCursoPlan, CodCursoRequisito,
      DescCursoRequisito, Nota, Semestre);

  /// Create a copy of GetCourseRequirementsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetCourseRequirementsModelImplCopyWith<_$GetCourseRequirementsModelImpl>
      get copyWith => __$$GetCourseRequirementsModelImplCopyWithImpl<
          _$GetCourseRequirementsModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetCourseRequirementsModelImplToJson(
      this,
    );
  }
}

abstract class _GetCourseRequirementsModel
    implements GetCourseRequirementsModel {
  factory _GetCourseRequirementsModel(
      {required final String CodCursoPlan,
      required final String CodCursoRequisito,
      required final String DescCursoRequisito,
      required final String Nota,
      required final String Semestre}) = _$GetCourseRequirementsModelImpl;

  factory _GetCourseRequirementsModel.fromJson(Map<String, dynamic> json) =
      _$GetCourseRequirementsModelImpl.fromJson;

  @override
  String get CodCursoPlan;
  @override
  String get CodCursoRequisito;
  @override
  String get DescCursoRequisito;
  @override
  String get Nota;
  @override
  String get Semestre;

  /// Create a copy of GetCourseRequirementsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetCourseRequirementsModelImplCopyWith<_$GetCourseRequirementsModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
