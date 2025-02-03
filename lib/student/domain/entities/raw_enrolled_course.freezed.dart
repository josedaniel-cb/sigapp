// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'raw_enrolled_course.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RawEnrolledCourse {
// required String? Acta,
// required String? Activo,
// required String Aula,
  String get url =>
      throw _privateConstructorUsedError; // required int CeroEnActa,
// required String ClaveCurso,
// required String CodCurso,
  String get courseCode =>
      throw _privateConstructorUsedError; // required int Creditos,
  int get credits => throw _privateConstructorUsedError; // required int Cupos,
// required String Curso,
  String get courseName =>
      throw _privateConstructorUsedError; // required int Desaprobados,
// required String Docente,
  String get professor =>
      throw _privateConstructorUsedError; // required String? EstadoInscripcion,
// required String Fecha,
  DateTime get date =>
      throw _privateConstructorUsedError; // required String FechaInscripcion,
// required String Grupo,
  String get group => throw _privateConstructorUsedError; // required int Item,
// required String ItemProg,
// required String Observacion,
// required String Seccion,
  String get section =>
      throw _privateConstructorUsedError; // required dynamic Sylabus,
// required String TipoCurso,
  CourseType get courseType => throw _privateConstructorUsedError;

  /// Create a copy of RawEnrolledCourse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RawEnrolledCourseCopyWith<RawEnrolledCourse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RawEnrolledCourseCopyWith<$Res> {
  factory $RawEnrolledCourseCopyWith(
          RawEnrolledCourse value, $Res Function(RawEnrolledCourse) then) =
      _$RawEnrolledCourseCopyWithImpl<$Res, RawEnrolledCourse>;
  @useResult
  $Res call(
      {String url,
      String courseCode,
      int credits,
      String courseName,
      String professor,
      DateTime date,
      String group,
      String section,
      CourseType courseType});
}

/// @nodoc
class _$RawEnrolledCourseCopyWithImpl<$Res, $Val extends RawEnrolledCourse>
    implements $RawEnrolledCourseCopyWith<$Res> {
  _$RawEnrolledCourseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RawEnrolledCourse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? courseCode = null,
    Object? credits = null,
    Object? courseName = null,
    Object? professor = null,
    Object? date = null,
    Object? group = null,
    Object? section = null,
    Object? courseType = null,
  }) {
    return _then(_value.copyWith(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      courseCode: null == courseCode
          ? _value.courseCode
          : courseCode // ignore: cast_nullable_to_non_nullable
              as String,
      credits: null == credits
          ? _value.credits
          : credits // ignore: cast_nullable_to_non_nullable
              as int,
      courseName: null == courseName
          ? _value.courseName
          : courseName // ignore: cast_nullable_to_non_nullable
              as String,
      professor: null == professor
          ? _value.professor
          : professor // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      group: null == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as String,
      section: null == section
          ? _value.section
          : section // ignore: cast_nullable_to_non_nullable
              as String,
      courseType: null == courseType
          ? _value.courseType
          : courseType // ignore: cast_nullable_to_non_nullable
              as CourseType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RawEnrolledCourseImplCopyWith<$Res>
    implements $RawEnrolledCourseCopyWith<$Res> {
  factory _$$RawEnrolledCourseImplCopyWith(_$RawEnrolledCourseImpl value,
          $Res Function(_$RawEnrolledCourseImpl) then) =
      __$$RawEnrolledCourseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String url,
      String courseCode,
      int credits,
      String courseName,
      String professor,
      DateTime date,
      String group,
      String section,
      CourseType courseType});
}

/// @nodoc
class __$$RawEnrolledCourseImplCopyWithImpl<$Res>
    extends _$RawEnrolledCourseCopyWithImpl<$Res, _$RawEnrolledCourseImpl>
    implements _$$RawEnrolledCourseImplCopyWith<$Res> {
  __$$RawEnrolledCourseImplCopyWithImpl(_$RawEnrolledCourseImpl _value,
      $Res Function(_$RawEnrolledCourseImpl) _then)
      : super(_value, _then);

  /// Create a copy of RawEnrolledCourse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? courseCode = null,
    Object? credits = null,
    Object? courseName = null,
    Object? professor = null,
    Object? date = null,
    Object? group = null,
    Object? section = null,
    Object? courseType = null,
  }) {
    return _then(_$RawEnrolledCourseImpl(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      courseCode: null == courseCode
          ? _value.courseCode
          : courseCode // ignore: cast_nullable_to_non_nullable
              as String,
      credits: null == credits
          ? _value.credits
          : credits // ignore: cast_nullable_to_non_nullable
              as int,
      courseName: null == courseName
          ? _value.courseName
          : courseName // ignore: cast_nullable_to_non_nullable
              as String,
      professor: null == professor
          ? _value.professor
          : professor // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      group: null == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as String,
      section: null == section
          ? _value.section
          : section // ignore: cast_nullable_to_non_nullable
              as String,
      courseType: null == courseType
          ? _value.courseType
          : courseType // ignore: cast_nullable_to_non_nullable
              as CourseType,
    ));
  }
}

/// @nodoc

class _$RawEnrolledCourseImpl
    with DiagnosticableTreeMixin
    implements _RawEnrolledCourse {
  const _$RawEnrolledCourseImpl(
      {required this.url,
      required this.courseCode,
      required this.credits,
      required this.courseName,
      required this.professor,
      required this.date,
      required this.group,
      required this.section,
      required this.courseType});

// required String? Acta,
// required String? Activo,
// required String Aula,
  @override
  final String url;
// required int CeroEnActa,
// required String ClaveCurso,
// required String CodCurso,
  @override
  final String courseCode;
// required int Creditos,
  @override
  final int credits;
// required int Cupos,
// required String Curso,
  @override
  final String courseName;
// required int Desaprobados,
// required String Docente,
  @override
  final String professor;
// required String? EstadoInscripcion,
// required String Fecha,
  @override
  final DateTime date;
// required String FechaInscripcion,
// required String Grupo,
  @override
  final String group;
// required int Item,
// required String ItemProg,
// required String Observacion,
// required String Seccion,
  @override
  final String section;
// required dynamic Sylabus,
// required String TipoCurso,
  @override
  final CourseType courseType;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RawEnrolledCourse(url: $url, courseCode: $courseCode, credits: $credits, courseName: $courseName, professor: $professor, date: $date, group: $group, section: $section, courseType: $courseType)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RawEnrolledCourse'))
      ..add(DiagnosticsProperty('url', url))
      ..add(DiagnosticsProperty('courseCode', courseCode))
      ..add(DiagnosticsProperty('credits', credits))
      ..add(DiagnosticsProperty('courseName', courseName))
      ..add(DiagnosticsProperty('professor', professor))
      ..add(DiagnosticsProperty('date', date))
      ..add(DiagnosticsProperty('group', group))
      ..add(DiagnosticsProperty('section', section))
      ..add(DiagnosticsProperty('courseType', courseType));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RawEnrolledCourseImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.courseCode, courseCode) ||
                other.courseCode == courseCode) &&
            (identical(other.credits, credits) || other.credits == credits) &&
            (identical(other.courseName, courseName) ||
                other.courseName == courseName) &&
            (identical(other.professor, professor) ||
                other.professor == professor) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.group, group) || other.group == group) &&
            (identical(other.section, section) || other.section == section) &&
            (identical(other.courseType, courseType) ||
                other.courseType == courseType));
  }

  @override
  int get hashCode => Object.hash(runtimeType, url, courseCode, credits,
      courseName, professor, date, group, section, courseType);

  /// Create a copy of RawEnrolledCourse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RawEnrolledCourseImplCopyWith<_$RawEnrolledCourseImpl> get copyWith =>
      __$$RawEnrolledCourseImplCopyWithImpl<_$RawEnrolledCourseImpl>(
          this, _$identity);
}

abstract class _RawEnrolledCourse implements RawEnrolledCourse {
  const factory _RawEnrolledCourse(
      {required final String url,
      required final String courseCode,
      required final int credits,
      required final String courseName,
      required final String professor,
      required final DateTime date,
      required final String group,
      required final String section,
      required final CourseType courseType}) = _$RawEnrolledCourseImpl;

// required String? Acta,
// required String? Activo,
// required String Aula,
  @override
  String get url; // required int CeroEnActa,
// required String ClaveCurso,
// required String CodCurso,
  @override
  String get courseCode; // required int Creditos,
  @override
  int get credits; // required int Cupos,
// required String Curso,
  @override
  String get courseName; // required int Desaprobados,
// required String Docente,
  @override
  String get professor; // required String? EstadoInscripcion,
// required String Fecha,
  @override
  DateTime get date; // required String FechaInscripcion,
// required String Grupo,
  @override
  String get group; // required int Item,
// required String ItemProg,
// required String Observacion,
// required String Seccion,
  @override
  String get section; // required dynamic Sylabus,
// required String TipoCurso,
  @override
  CourseType get courseType;

  /// Create a copy of RawEnrolledCourse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RawEnrolledCourseImplCopyWith<_$RawEnrolledCourseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
