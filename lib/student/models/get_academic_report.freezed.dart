// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_academic_report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetAcademicReportModel _$GetAcademicReportModelFromJson(
    Map<String, dynamic> json) {
  return _GetAcademicReportModel.fromJson(json);
}

/// @nodoc
mixin _$GetAcademicReportModel {
  String get Facultad => throw _privateConstructorUsedError;
  String get NomAlumno => throw _privateConstructorUsedError;
  String get Promocion => throw _privateConstructorUsedError;
  String get SemestreIngreso => throw _privateConstructorUsedError;
  String get SemestrePlan => throw _privateConstructorUsedError;
  String? get UltSemestre => throw _privateConstructorUsedError;
  double get PPA => throw _privateConstructorUsedError;
  double get PPAAprob => throw _privateConstructorUsedError;
  double get UPPS => throw _privateConstructorUsedError;
  int get TotalCredAprob => throw _privateConstructorUsedError;
  int get CredObligPlan => throw _privateConstructorUsedError;
  int get CredElectPlan => throw _privateConstructorUsedError;
  int get CredObligAprob => throw _privateConstructorUsedError;
  int get CredElectAprob => throw _privateConstructorUsedError;

  /// Serializes this GetAcademicReportModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetAcademicReportModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetAcademicReportModelCopyWith<GetAcademicReportModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetAcademicReportModelCopyWith<$Res> {
  factory $GetAcademicReportModelCopyWith(GetAcademicReportModel value,
          $Res Function(GetAcademicReportModel) then) =
      _$GetAcademicReportModelCopyWithImpl<$Res, GetAcademicReportModel>;
  @useResult
  $Res call(
      {String Facultad,
      String NomAlumno,
      String Promocion,
      String SemestreIngreso,
      String SemestrePlan,
      String? UltSemestre,
      double PPA,
      double PPAAprob,
      double UPPS,
      int TotalCredAprob,
      int CredObligPlan,
      int CredElectPlan,
      int CredObligAprob,
      int CredElectAprob});
}

/// @nodoc
class _$GetAcademicReportModelCopyWithImpl<$Res,
        $Val extends GetAcademicReportModel>
    implements $GetAcademicReportModelCopyWith<$Res> {
  _$GetAcademicReportModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetAcademicReportModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? Facultad = null,
    Object? NomAlumno = null,
    Object? Promocion = null,
    Object? SemestreIngreso = null,
    Object? SemestrePlan = null,
    Object? UltSemestre = freezed,
    Object? PPA = null,
    Object? PPAAprob = null,
    Object? UPPS = null,
    Object? TotalCredAprob = null,
    Object? CredObligPlan = null,
    Object? CredElectPlan = null,
    Object? CredObligAprob = null,
    Object? CredElectAprob = null,
  }) {
    return _then(_value.copyWith(
      Facultad: null == Facultad
          ? _value.Facultad
          : Facultad // ignore: cast_nullable_to_non_nullable
              as String,
      NomAlumno: null == NomAlumno
          ? _value.NomAlumno
          : NomAlumno // ignore: cast_nullable_to_non_nullable
              as String,
      Promocion: null == Promocion
          ? _value.Promocion
          : Promocion // ignore: cast_nullable_to_non_nullable
              as String,
      SemestreIngreso: null == SemestreIngreso
          ? _value.SemestreIngreso
          : SemestreIngreso // ignore: cast_nullable_to_non_nullable
              as String,
      SemestrePlan: null == SemestrePlan
          ? _value.SemestrePlan
          : SemestrePlan // ignore: cast_nullable_to_non_nullable
              as String,
      UltSemestre: freezed == UltSemestre
          ? _value.UltSemestre
          : UltSemestre // ignore: cast_nullable_to_non_nullable
              as String?,
      PPA: null == PPA
          ? _value.PPA
          : PPA // ignore: cast_nullable_to_non_nullable
              as double,
      PPAAprob: null == PPAAprob
          ? _value.PPAAprob
          : PPAAprob // ignore: cast_nullable_to_non_nullable
              as double,
      UPPS: null == UPPS
          ? _value.UPPS
          : UPPS // ignore: cast_nullable_to_non_nullable
              as double,
      TotalCredAprob: null == TotalCredAprob
          ? _value.TotalCredAprob
          : TotalCredAprob // ignore: cast_nullable_to_non_nullable
              as int,
      CredObligPlan: null == CredObligPlan
          ? _value.CredObligPlan
          : CredObligPlan // ignore: cast_nullable_to_non_nullable
              as int,
      CredElectPlan: null == CredElectPlan
          ? _value.CredElectPlan
          : CredElectPlan // ignore: cast_nullable_to_non_nullable
              as int,
      CredObligAprob: null == CredObligAprob
          ? _value.CredObligAprob
          : CredObligAprob // ignore: cast_nullable_to_non_nullable
              as int,
      CredElectAprob: null == CredElectAprob
          ? _value.CredElectAprob
          : CredElectAprob // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetAcademicReportModelImplCopyWith<$Res>
    implements $GetAcademicReportModelCopyWith<$Res> {
  factory _$$GetAcademicReportModelImplCopyWith(
          _$GetAcademicReportModelImpl value,
          $Res Function(_$GetAcademicReportModelImpl) then) =
      __$$GetAcademicReportModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String Facultad,
      String NomAlumno,
      String Promocion,
      String SemestreIngreso,
      String SemestrePlan,
      String? UltSemestre,
      double PPA,
      double PPAAprob,
      double UPPS,
      int TotalCredAprob,
      int CredObligPlan,
      int CredElectPlan,
      int CredObligAprob,
      int CredElectAprob});
}

/// @nodoc
class __$$GetAcademicReportModelImplCopyWithImpl<$Res>
    extends _$GetAcademicReportModelCopyWithImpl<$Res,
        _$GetAcademicReportModelImpl>
    implements _$$GetAcademicReportModelImplCopyWith<$Res> {
  __$$GetAcademicReportModelImplCopyWithImpl(
      _$GetAcademicReportModelImpl _value,
      $Res Function(_$GetAcademicReportModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetAcademicReportModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? Facultad = null,
    Object? NomAlumno = null,
    Object? Promocion = null,
    Object? SemestreIngreso = null,
    Object? SemestrePlan = null,
    Object? UltSemestre = freezed,
    Object? PPA = null,
    Object? PPAAprob = null,
    Object? UPPS = null,
    Object? TotalCredAprob = null,
    Object? CredObligPlan = null,
    Object? CredElectPlan = null,
    Object? CredObligAprob = null,
    Object? CredElectAprob = null,
  }) {
    return _then(_$GetAcademicReportModelImpl(
      Facultad: null == Facultad
          ? _value.Facultad
          : Facultad // ignore: cast_nullable_to_non_nullable
              as String,
      NomAlumno: null == NomAlumno
          ? _value.NomAlumno
          : NomAlumno // ignore: cast_nullable_to_non_nullable
              as String,
      Promocion: null == Promocion
          ? _value.Promocion
          : Promocion // ignore: cast_nullable_to_non_nullable
              as String,
      SemestreIngreso: null == SemestreIngreso
          ? _value.SemestreIngreso
          : SemestreIngreso // ignore: cast_nullable_to_non_nullable
              as String,
      SemestrePlan: null == SemestrePlan
          ? _value.SemestrePlan
          : SemestrePlan // ignore: cast_nullable_to_non_nullable
              as String,
      UltSemestre: freezed == UltSemestre
          ? _value.UltSemestre
          : UltSemestre // ignore: cast_nullable_to_non_nullable
              as String?,
      PPA: null == PPA
          ? _value.PPA
          : PPA // ignore: cast_nullable_to_non_nullable
              as double,
      PPAAprob: null == PPAAprob
          ? _value.PPAAprob
          : PPAAprob // ignore: cast_nullable_to_non_nullable
              as double,
      UPPS: null == UPPS
          ? _value.UPPS
          : UPPS // ignore: cast_nullable_to_non_nullable
              as double,
      TotalCredAprob: null == TotalCredAprob
          ? _value.TotalCredAprob
          : TotalCredAprob // ignore: cast_nullable_to_non_nullable
              as int,
      CredObligPlan: null == CredObligPlan
          ? _value.CredObligPlan
          : CredObligPlan // ignore: cast_nullable_to_non_nullable
              as int,
      CredElectPlan: null == CredElectPlan
          ? _value.CredElectPlan
          : CredElectPlan // ignore: cast_nullable_to_non_nullable
              as int,
      CredObligAprob: null == CredObligAprob
          ? _value.CredObligAprob
          : CredObligAprob // ignore: cast_nullable_to_non_nullable
              as int,
      CredElectAprob: null == CredElectAprob
          ? _value.CredElectAprob
          : CredElectAprob // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetAcademicReportModelImpl
    with DiagnosticableTreeMixin
    implements _GetAcademicReportModel {
  const _$GetAcademicReportModelImpl(
      {required this.Facultad,
      required this.NomAlumno,
      required this.Promocion,
      required this.SemestreIngreso,
      required this.SemestrePlan,
      required this.UltSemestre,
      required this.PPA,
      required this.PPAAprob,
      required this.UPPS,
      required this.TotalCredAprob,
      required this.CredObligPlan,
      required this.CredElectPlan,
      required this.CredObligAprob,
      required this.CredElectAprob});

  factory _$GetAcademicReportModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GetAcademicReportModelImplFromJson(json);

  @override
  final String Facultad;
  @override
  final String NomAlumno;
  @override
  final String Promocion;
  @override
  final String SemestreIngreso;
  @override
  final String SemestrePlan;
  @override
  final String? UltSemestre;
  @override
  final double PPA;
  @override
  final double PPAAprob;
  @override
  final double UPPS;
  @override
  final int TotalCredAprob;
  @override
  final int CredObligPlan;
  @override
  final int CredElectPlan;
  @override
  final int CredObligAprob;
  @override
  final int CredElectAprob;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'GetAcademicReportModel(Facultad: $Facultad, NomAlumno: $NomAlumno, Promocion: $Promocion, SemestreIngreso: $SemestreIngreso, SemestrePlan: $SemestrePlan, UltSemestre: $UltSemestre, PPA: $PPA, PPAAprob: $PPAAprob, UPPS: $UPPS, TotalCredAprob: $TotalCredAprob, CredObligPlan: $CredObligPlan, CredElectPlan: $CredElectPlan, CredObligAprob: $CredObligAprob, CredElectAprob: $CredElectAprob)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'GetAcademicReportModel'))
      ..add(DiagnosticsProperty('Facultad', Facultad))
      ..add(DiagnosticsProperty('NomAlumno', NomAlumno))
      ..add(DiagnosticsProperty('Promocion', Promocion))
      ..add(DiagnosticsProperty('SemestreIngreso', SemestreIngreso))
      ..add(DiagnosticsProperty('SemestrePlan', SemestrePlan))
      ..add(DiagnosticsProperty('UltSemestre', UltSemestre))
      ..add(DiagnosticsProperty('PPA', PPA))
      ..add(DiagnosticsProperty('PPAAprob', PPAAprob))
      ..add(DiagnosticsProperty('UPPS', UPPS))
      ..add(DiagnosticsProperty('TotalCredAprob', TotalCredAprob))
      ..add(DiagnosticsProperty('CredObligPlan', CredObligPlan))
      ..add(DiagnosticsProperty('CredElectPlan', CredElectPlan))
      ..add(DiagnosticsProperty('CredObligAprob', CredObligAprob))
      ..add(DiagnosticsProperty('CredElectAprob', CredElectAprob));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetAcademicReportModelImpl &&
            (identical(other.Facultad, Facultad) ||
                other.Facultad == Facultad) &&
            (identical(other.NomAlumno, NomAlumno) ||
                other.NomAlumno == NomAlumno) &&
            (identical(other.Promocion, Promocion) ||
                other.Promocion == Promocion) &&
            (identical(other.SemestreIngreso, SemestreIngreso) ||
                other.SemestreIngreso == SemestreIngreso) &&
            (identical(other.SemestrePlan, SemestrePlan) ||
                other.SemestrePlan == SemestrePlan) &&
            (identical(other.UltSemestre, UltSemestre) ||
                other.UltSemestre == UltSemestre) &&
            (identical(other.PPA, PPA) || other.PPA == PPA) &&
            (identical(other.PPAAprob, PPAAprob) ||
                other.PPAAprob == PPAAprob) &&
            (identical(other.UPPS, UPPS) || other.UPPS == UPPS) &&
            (identical(other.TotalCredAprob, TotalCredAprob) ||
                other.TotalCredAprob == TotalCredAprob) &&
            (identical(other.CredObligPlan, CredObligPlan) ||
                other.CredObligPlan == CredObligPlan) &&
            (identical(other.CredElectPlan, CredElectPlan) ||
                other.CredElectPlan == CredElectPlan) &&
            (identical(other.CredObligAprob, CredObligAprob) ||
                other.CredObligAprob == CredObligAprob) &&
            (identical(other.CredElectAprob, CredElectAprob) ||
                other.CredElectAprob == CredElectAprob));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      Facultad,
      NomAlumno,
      Promocion,
      SemestreIngreso,
      SemestrePlan,
      UltSemestre,
      PPA,
      PPAAprob,
      UPPS,
      TotalCredAprob,
      CredObligPlan,
      CredElectPlan,
      CredObligAprob,
      CredElectAprob);

  /// Create a copy of GetAcademicReportModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetAcademicReportModelImplCopyWith<_$GetAcademicReportModelImpl>
      get copyWith => __$$GetAcademicReportModelImplCopyWithImpl<
          _$GetAcademicReportModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetAcademicReportModelImplToJson(
      this,
    );
  }
}

abstract class _GetAcademicReportModel implements GetAcademicReportModel {
  const factory _GetAcademicReportModel(
      {required final String Facultad,
      required final String NomAlumno,
      required final String Promocion,
      required final String SemestreIngreso,
      required final String SemestrePlan,
      required final String? UltSemestre,
      required final double PPA,
      required final double PPAAprob,
      required final double UPPS,
      required final int TotalCredAprob,
      required final int CredObligPlan,
      required final int CredElectPlan,
      required final int CredObligAprob,
      required final int CredElectAprob}) = _$GetAcademicReportModelImpl;

  factory _GetAcademicReportModel.fromJson(Map<String, dynamic> json) =
      _$GetAcademicReportModelImpl.fromJson;

  @override
  String get Facultad;
  @override
  String get NomAlumno;
  @override
  String get Promocion;
  @override
  String get SemestreIngreso;
  @override
  String get SemestrePlan;
  @override
  String? get UltSemestre;
  @override
  double get PPA;
  @override
  double get PPAAprob;
  @override
  double get UPPS;
  @override
  int get TotalCredAprob;
  @override
  int get CredObligPlan;
  @override
  int get CredElectPlan;
  @override
  int get CredObligAprob;
  @override
  int get CredElectAprob;

  /// Create a copy of GetAcademicReportModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetAcademicReportModelImplCopyWith<_$GetAcademicReportModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
