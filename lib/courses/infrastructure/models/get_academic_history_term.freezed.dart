// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_academic_history_term.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetAcademicHistoryTermModel _$GetAcademicHistoryTermModelFromJson(
    Map<String, dynamic> json) {
  return _GetAcademicHistoryTermModel.fromJson(json);
}

/// @nodoc
mixin _$GetAcademicHistoryTermModel {
  String get termLabel => throw _privateConstructorUsedError;
  GetAcademicHistoryTermStatisticsModel? get statistics =>
      throw _privateConstructorUsedError;
  List<GetAcademicHistoryCourseModel> get courses =>
      throw _privateConstructorUsedError;

  /// Serializes this GetAcademicHistoryTermModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetAcademicHistoryTermModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetAcademicHistoryTermModelCopyWith<GetAcademicHistoryTermModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetAcademicHistoryTermModelCopyWith<$Res> {
  factory $GetAcademicHistoryTermModelCopyWith(
          GetAcademicHistoryTermModel value,
          $Res Function(GetAcademicHistoryTermModel) then) =
      _$GetAcademicHistoryTermModelCopyWithImpl<$Res,
          GetAcademicHistoryTermModel>;
  @useResult
  $Res call(
      {String termLabel,
      GetAcademicHistoryTermStatisticsModel? statistics,
      List<GetAcademicHistoryCourseModel> courses});

  $GetAcademicHistoryTermStatisticsModelCopyWith<$Res>? get statistics;
}

/// @nodoc
class _$GetAcademicHistoryTermModelCopyWithImpl<$Res,
        $Val extends GetAcademicHistoryTermModel>
    implements $GetAcademicHistoryTermModelCopyWith<$Res> {
  _$GetAcademicHistoryTermModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetAcademicHistoryTermModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? termLabel = null,
    Object? statistics = freezed,
    Object? courses = null,
  }) {
    return _then(_value.copyWith(
      termLabel: null == termLabel
          ? _value.termLabel
          : termLabel // ignore: cast_nullable_to_non_nullable
              as String,
      statistics: freezed == statistics
          ? _value.statistics
          : statistics // ignore: cast_nullable_to_non_nullable
              as GetAcademicHistoryTermStatisticsModel?,
      courses: null == courses
          ? _value.courses
          : courses // ignore: cast_nullable_to_non_nullable
              as List<GetAcademicHistoryCourseModel>,
    ) as $Val);
  }

  /// Create a copy of GetAcademicHistoryTermModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GetAcademicHistoryTermStatisticsModelCopyWith<$Res>? get statistics {
    if (_value.statistics == null) {
      return null;
    }

    return $GetAcademicHistoryTermStatisticsModelCopyWith<$Res>(
        _value.statistics!, (value) {
      return _then(_value.copyWith(statistics: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GetAcademicHistoryTermModelImplCopyWith<$Res>
    implements $GetAcademicHistoryTermModelCopyWith<$Res> {
  factory _$$GetAcademicHistoryTermModelImplCopyWith(
          _$GetAcademicHistoryTermModelImpl value,
          $Res Function(_$GetAcademicHistoryTermModelImpl) then) =
      __$$GetAcademicHistoryTermModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String termLabel,
      GetAcademicHistoryTermStatisticsModel? statistics,
      List<GetAcademicHistoryCourseModel> courses});

  @override
  $GetAcademicHistoryTermStatisticsModelCopyWith<$Res>? get statistics;
}

/// @nodoc
class __$$GetAcademicHistoryTermModelImplCopyWithImpl<$Res>
    extends _$GetAcademicHistoryTermModelCopyWithImpl<$Res,
        _$GetAcademicHistoryTermModelImpl>
    implements _$$GetAcademicHistoryTermModelImplCopyWith<$Res> {
  __$$GetAcademicHistoryTermModelImplCopyWithImpl(
      _$GetAcademicHistoryTermModelImpl _value,
      $Res Function(_$GetAcademicHistoryTermModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetAcademicHistoryTermModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? termLabel = null,
    Object? statistics = freezed,
    Object? courses = null,
  }) {
    return _then(_$GetAcademicHistoryTermModelImpl(
      termLabel: null == termLabel
          ? _value.termLabel
          : termLabel // ignore: cast_nullable_to_non_nullable
              as String,
      statistics: freezed == statistics
          ? _value.statistics
          : statistics // ignore: cast_nullable_to_non_nullable
              as GetAcademicHistoryTermStatisticsModel?,
      courses: null == courses
          ? _value._courses
          : courses // ignore: cast_nullable_to_non_nullable
              as List<GetAcademicHistoryCourseModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetAcademicHistoryTermModelImpl
    with DiagnosticableTreeMixin
    implements _GetAcademicHistoryTermModel {
  const _$GetAcademicHistoryTermModelImpl(
      {required this.termLabel,
      required this.statistics,
      required final List<GetAcademicHistoryCourseModel> courses})
      : _courses = courses;

  factory _$GetAcademicHistoryTermModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GetAcademicHistoryTermModelImplFromJson(json);

  @override
  final String termLabel;
  @override
  final GetAcademicHistoryTermStatisticsModel? statistics;
  final List<GetAcademicHistoryCourseModel> _courses;
  @override
  List<GetAcademicHistoryCourseModel> get courses {
    if (_courses is EqualUnmodifiableListView) return _courses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_courses);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'GetAcademicHistoryTermModel(termLabel: $termLabel, statistics: $statistics, courses: $courses)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'GetAcademicHistoryTermModel'))
      ..add(DiagnosticsProperty('termLabel', termLabel))
      ..add(DiagnosticsProperty('statistics', statistics))
      ..add(DiagnosticsProperty('courses', courses));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetAcademicHistoryTermModelImpl &&
            (identical(other.termLabel, termLabel) ||
                other.termLabel == termLabel) &&
            (identical(other.statistics, statistics) ||
                other.statistics == statistics) &&
            const DeepCollectionEquality().equals(other._courses, _courses));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, termLabel, statistics,
      const DeepCollectionEquality().hash(_courses));

  /// Create a copy of GetAcademicHistoryTermModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetAcademicHistoryTermModelImplCopyWith<_$GetAcademicHistoryTermModelImpl>
      get copyWith => __$$GetAcademicHistoryTermModelImplCopyWithImpl<
          _$GetAcademicHistoryTermModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetAcademicHistoryTermModelImplToJson(
      this,
    );
  }
}

abstract class _GetAcademicHistoryTermModel
    implements GetAcademicHistoryTermModel {
  const factory _GetAcademicHistoryTermModel(
          {required final String termLabel,
          required final GetAcademicHistoryTermStatisticsModel? statistics,
          required final List<GetAcademicHistoryCourseModel> courses}) =
      _$GetAcademicHistoryTermModelImpl;

  factory _GetAcademicHistoryTermModel.fromJson(Map<String, dynamic> json) =
      _$GetAcademicHistoryTermModelImpl.fromJson;

  @override
  String get termLabel;
  @override
  GetAcademicHistoryTermStatisticsModel? get statistics;
  @override
  List<GetAcademicHistoryCourseModel> get courses;

  /// Create a copy of GetAcademicHistoryTermModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetAcademicHistoryTermModelImplCopyWith<_$GetAcademicHistoryTermModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

GetAcademicHistoryTermStatisticsModel
    _$GetAcademicHistoryTermStatisticsModelFromJson(Map<String, dynamic> json) {
  return _GetAcademicHistoryTermStatisticsModel.fromJson(json);
}

/// @nodoc
mixin _$GetAcademicHistoryTermStatisticsModel {
  double get PPS => throw _privateConstructorUsedError;
  double get PPSAprob => throw _privateConstructorUsedError;
  double get PPA => throw _privateConstructorUsedError;
  double get PPAApr => throw _privateConstructorUsedError;
  double get CreOblLlev => throw _privateConstructorUsedError;
  double get CreElLlev => throw _privateConstructorUsedError;
  double get CreOblApr => throw _privateConstructorUsedError;
  double get CreEleApr => throw _privateConstructorUsedError;
  double get CreOblConv => throw _privateConstructorUsedError;
  double get CredEleConv => throw _privateConstructorUsedError;
  double get TotalCredOblLlev => throw _privateConstructorUsedError;
  double get TotalCredElLlev => throw _privateConstructorUsedError;
  double get TotalCredOblAprob => throw _privateConstructorUsedError;
  double get TotalCredElAprob => throw _privateConstructorUsedError;
  double get TotalCredOblConv => throw _privateConstructorUsedError;

  /// Serializes this GetAcademicHistoryTermStatisticsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetAcademicHistoryTermStatisticsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetAcademicHistoryTermStatisticsModelCopyWith<
          GetAcademicHistoryTermStatisticsModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetAcademicHistoryTermStatisticsModelCopyWith<$Res> {
  factory $GetAcademicHistoryTermStatisticsModelCopyWith(
          GetAcademicHistoryTermStatisticsModel value,
          $Res Function(GetAcademicHistoryTermStatisticsModel) then) =
      _$GetAcademicHistoryTermStatisticsModelCopyWithImpl<$Res,
          GetAcademicHistoryTermStatisticsModel>;
  @useResult
  $Res call(
      {double PPS,
      double PPSAprob,
      double PPA,
      double PPAApr,
      double CreOblLlev,
      double CreElLlev,
      double CreOblApr,
      double CreEleApr,
      double CreOblConv,
      double CredEleConv,
      double TotalCredOblLlev,
      double TotalCredElLlev,
      double TotalCredOblAprob,
      double TotalCredElAprob,
      double TotalCredOblConv});
}

/// @nodoc
class _$GetAcademicHistoryTermStatisticsModelCopyWithImpl<$Res,
        $Val extends GetAcademicHistoryTermStatisticsModel>
    implements $GetAcademicHistoryTermStatisticsModelCopyWith<$Res> {
  _$GetAcademicHistoryTermStatisticsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetAcademicHistoryTermStatisticsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? PPS = null,
    Object? PPSAprob = null,
    Object? PPA = null,
    Object? PPAApr = null,
    Object? CreOblLlev = null,
    Object? CreElLlev = null,
    Object? CreOblApr = null,
    Object? CreEleApr = null,
    Object? CreOblConv = null,
    Object? CredEleConv = null,
    Object? TotalCredOblLlev = null,
    Object? TotalCredElLlev = null,
    Object? TotalCredOblAprob = null,
    Object? TotalCredElAprob = null,
    Object? TotalCredOblConv = null,
  }) {
    return _then(_value.copyWith(
      PPS: null == PPS
          ? _value.PPS
          : PPS // ignore: cast_nullable_to_non_nullable
              as double,
      PPSAprob: null == PPSAprob
          ? _value.PPSAprob
          : PPSAprob // ignore: cast_nullable_to_non_nullable
              as double,
      PPA: null == PPA
          ? _value.PPA
          : PPA // ignore: cast_nullable_to_non_nullable
              as double,
      PPAApr: null == PPAApr
          ? _value.PPAApr
          : PPAApr // ignore: cast_nullable_to_non_nullable
              as double,
      CreOblLlev: null == CreOblLlev
          ? _value.CreOblLlev
          : CreOblLlev // ignore: cast_nullable_to_non_nullable
              as double,
      CreElLlev: null == CreElLlev
          ? _value.CreElLlev
          : CreElLlev // ignore: cast_nullable_to_non_nullable
              as double,
      CreOblApr: null == CreOblApr
          ? _value.CreOblApr
          : CreOblApr // ignore: cast_nullable_to_non_nullable
              as double,
      CreEleApr: null == CreEleApr
          ? _value.CreEleApr
          : CreEleApr // ignore: cast_nullable_to_non_nullable
              as double,
      CreOblConv: null == CreOblConv
          ? _value.CreOblConv
          : CreOblConv // ignore: cast_nullable_to_non_nullable
              as double,
      CredEleConv: null == CredEleConv
          ? _value.CredEleConv
          : CredEleConv // ignore: cast_nullable_to_non_nullable
              as double,
      TotalCredOblLlev: null == TotalCredOblLlev
          ? _value.TotalCredOblLlev
          : TotalCredOblLlev // ignore: cast_nullable_to_non_nullable
              as double,
      TotalCredElLlev: null == TotalCredElLlev
          ? _value.TotalCredElLlev
          : TotalCredElLlev // ignore: cast_nullable_to_non_nullable
              as double,
      TotalCredOblAprob: null == TotalCredOblAprob
          ? _value.TotalCredOblAprob
          : TotalCredOblAprob // ignore: cast_nullable_to_non_nullable
              as double,
      TotalCredElAprob: null == TotalCredElAprob
          ? _value.TotalCredElAprob
          : TotalCredElAprob // ignore: cast_nullable_to_non_nullable
              as double,
      TotalCredOblConv: null == TotalCredOblConv
          ? _value.TotalCredOblConv
          : TotalCredOblConv // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetAcademicHistoryTermStatisticsModelImplCopyWith<$Res>
    implements $GetAcademicHistoryTermStatisticsModelCopyWith<$Res> {
  factory _$$GetAcademicHistoryTermStatisticsModelImplCopyWith(
          _$GetAcademicHistoryTermStatisticsModelImpl value,
          $Res Function(_$GetAcademicHistoryTermStatisticsModelImpl) then) =
      __$$GetAcademicHistoryTermStatisticsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double PPS,
      double PPSAprob,
      double PPA,
      double PPAApr,
      double CreOblLlev,
      double CreElLlev,
      double CreOblApr,
      double CreEleApr,
      double CreOblConv,
      double CredEleConv,
      double TotalCredOblLlev,
      double TotalCredElLlev,
      double TotalCredOblAprob,
      double TotalCredElAprob,
      double TotalCredOblConv});
}

/// @nodoc
class __$$GetAcademicHistoryTermStatisticsModelImplCopyWithImpl<$Res>
    extends _$GetAcademicHistoryTermStatisticsModelCopyWithImpl<$Res,
        _$GetAcademicHistoryTermStatisticsModelImpl>
    implements _$$GetAcademicHistoryTermStatisticsModelImplCopyWith<$Res> {
  __$$GetAcademicHistoryTermStatisticsModelImplCopyWithImpl(
      _$GetAcademicHistoryTermStatisticsModelImpl _value,
      $Res Function(_$GetAcademicHistoryTermStatisticsModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetAcademicHistoryTermStatisticsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? PPS = null,
    Object? PPSAprob = null,
    Object? PPA = null,
    Object? PPAApr = null,
    Object? CreOblLlev = null,
    Object? CreElLlev = null,
    Object? CreOblApr = null,
    Object? CreEleApr = null,
    Object? CreOblConv = null,
    Object? CredEleConv = null,
    Object? TotalCredOblLlev = null,
    Object? TotalCredElLlev = null,
    Object? TotalCredOblAprob = null,
    Object? TotalCredElAprob = null,
    Object? TotalCredOblConv = null,
  }) {
    return _then(_$GetAcademicHistoryTermStatisticsModelImpl(
      PPS: null == PPS
          ? _value.PPS
          : PPS // ignore: cast_nullable_to_non_nullable
              as double,
      PPSAprob: null == PPSAprob
          ? _value.PPSAprob
          : PPSAprob // ignore: cast_nullable_to_non_nullable
              as double,
      PPA: null == PPA
          ? _value.PPA
          : PPA // ignore: cast_nullable_to_non_nullable
              as double,
      PPAApr: null == PPAApr
          ? _value.PPAApr
          : PPAApr // ignore: cast_nullable_to_non_nullable
              as double,
      CreOblLlev: null == CreOblLlev
          ? _value.CreOblLlev
          : CreOblLlev // ignore: cast_nullable_to_non_nullable
              as double,
      CreElLlev: null == CreElLlev
          ? _value.CreElLlev
          : CreElLlev // ignore: cast_nullable_to_non_nullable
              as double,
      CreOblApr: null == CreOblApr
          ? _value.CreOblApr
          : CreOblApr // ignore: cast_nullable_to_non_nullable
              as double,
      CreEleApr: null == CreEleApr
          ? _value.CreEleApr
          : CreEleApr // ignore: cast_nullable_to_non_nullable
              as double,
      CreOblConv: null == CreOblConv
          ? _value.CreOblConv
          : CreOblConv // ignore: cast_nullable_to_non_nullable
              as double,
      CredEleConv: null == CredEleConv
          ? _value.CredEleConv
          : CredEleConv // ignore: cast_nullable_to_non_nullable
              as double,
      TotalCredOblLlev: null == TotalCredOblLlev
          ? _value.TotalCredOblLlev
          : TotalCredOblLlev // ignore: cast_nullable_to_non_nullable
              as double,
      TotalCredElLlev: null == TotalCredElLlev
          ? _value.TotalCredElLlev
          : TotalCredElLlev // ignore: cast_nullable_to_non_nullable
              as double,
      TotalCredOblAprob: null == TotalCredOblAprob
          ? _value.TotalCredOblAprob
          : TotalCredOblAprob // ignore: cast_nullable_to_non_nullable
              as double,
      TotalCredElAprob: null == TotalCredElAprob
          ? _value.TotalCredElAprob
          : TotalCredElAprob // ignore: cast_nullable_to_non_nullable
              as double,
      TotalCredOblConv: null == TotalCredOblConv
          ? _value.TotalCredOblConv
          : TotalCredOblConv // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetAcademicHistoryTermStatisticsModelImpl
    with DiagnosticableTreeMixin
    implements _GetAcademicHistoryTermStatisticsModel {
  const _$GetAcademicHistoryTermStatisticsModelImpl(
      {required this.PPS,
      required this.PPSAprob,
      required this.PPA,
      required this.PPAApr,
      required this.CreOblLlev,
      required this.CreElLlev,
      required this.CreOblApr,
      required this.CreEleApr,
      required this.CreOblConv,
      required this.CredEleConv,
      required this.TotalCredOblLlev,
      required this.TotalCredElLlev,
      required this.TotalCredOblAprob,
      required this.TotalCredElAprob,
      required this.TotalCredOblConv});

  factory _$GetAcademicHistoryTermStatisticsModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GetAcademicHistoryTermStatisticsModelImplFromJson(json);

  @override
  final double PPS;
  @override
  final double PPSAprob;
  @override
  final double PPA;
  @override
  final double PPAApr;
  @override
  final double CreOblLlev;
  @override
  final double CreElLlev;
  @override
  final double CreOblApr;
  @override
  final double CreEleApr;
  @override
  final double CreOblConv;
  @override
  final double CredEleConv;
  @override
  final double TotalCredOblLlev;
  @override
  final double TotalCredElLlev;
  @override
  final double TotalCredOblAprob;
  @override
  final double TotalCredElAprob;
  @override
  final double TotalCredOblConv;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'GetAcademicHistoryTermStatisticsModel(PPS: $PPS, PPSAprob: $PPSAprob, PPA: $PPA, PPAApr: $PPAApr, CreOblLlev: $CreOblLlev, CreElLlev: $CreElLlev, CreOblApr: $CreOblApr, CreEleApr: $CreEleApr, CreOblConv: $CreOblConv, CredEleConv: $CredEleConv, TotalCredOblLlev: $TotalCredOblLlev, TotalCredElLlev: $TotalCredElLlev, TotalCredOblAprob: $TotalCredOblAprob, TotalCredElAprob: $TotalCredElAprob, TotalCredOblConv: $TotalCredOblConv)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
          DiagnosticsProperty('type', 'GetAcademicHistoryTermStatisticsModel'))
      ..add(DiagnosticsProperty('PPS', PPS))
      ..add(DiagnosticsProperty('PPSAprob', PPSAprob))
      ..add(DiagnosticsProperty('PPA', PPA))
      ..add(DiagnosticsProperty('PPAApr', PPAApr))
      ..add(DiagnosticsProperty('CreOblLlev', CreOblLlev))
      ..add(DiagnosticsProperty('CreElLlev', CreElLlev))
      ..add(DiagnosticsProperty('CreOblApr', CreOblApr))
      ..add(DiagnosticsProperty('CreEleApr', CreEleApr))
      ..add(DiagnosticsProperty('CreOblConv', CreOblConv))
      ..add(DiagnosticsProperty('CredEleConv', CredEleConv))
      ..add(DiagnosticsProperty('TotalCredOblLlev', TotalCredOblLlev))
      ..add(DiagnosticsProperty('TotalCredElLlev', TotalCredElLlev))
      ..add(DiagnosticsProperty('TotalCredOblAprob', TotalCredOblAprob))
      ..add(DiagnosticsProperty('TotalCredElAprob', TotalCredElAprob))
      ..add(DiagnosticsProperty('TotalCredOblConv', TotalCredOblConv));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetAcademicHistoryTermStatisticsModelImpl &&
            (identical(other.PPS, PPS) || other.PPS == PPS) &&
            (identical(other.PPSAprob, PPSAprob) ||
                other.PPSAprob == PPSAprob) &&
            (identical(other.PPA, PPA) || other.PPA == PPA) &&
            (identical(other.PPAApr, PPAApr) || other.PPAApr == PPAApr) &&
            (identical(other.CreOblLlev, CreOblLlev) ||
                other.CreOblLlev == CreOblLlev) &&
            (identical(other.CreElLlev, CreElLlev) ||
                other.CreElLlev == CreElLlev) &&
            (identical(other.CreOblApr, CreOblApr) ||
                other.CreOblApr == CreOblApr) &&
            (identical(other.CreEleApr, CreEleApr) ||
                other.CreEleApr == CreEleApr) &&
            (identical(other.CreOblConv, CreOblConv) ||
                other.CreOblConv == CreOblConv) &&
            (identical(other.CredEleConv, CredEleConv) ||
                other.CredEleConv == CredEleConv) &&
            (identical(other.TotalCredOblLlev, TotalCredOblLlev) ||
                other.TotalCredOblLlev == TotalCredOblLlev) &&
            (identical(other.TotalCredElLlev, TotalCredElLlev) ||
                other.TotalCredElLlev == TotalCredElLlev) &&
            (identical(other.TotalCredOblAprob, TotalCredOblAprob) ||
                other.TotalCredOblAprob == TotalCredOblAprob) &&
            (identical(other.TotalCredElAprob, TotalCredElAprob) ||
                other.TotalCredElAprob == TotalCredElAprob) &&
            (identical(other.TotalCredOblConv, TotalCredOblConv) ||
                other.TotalCredOblConv == TotalCredOblConv));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      PPS,
      PPSAprob,
      PPA,
      PPAApr,
      CreOblLlev,
      CreElLlev,
      CreOblApr,
      CreEleApr,
      CreOblConv,
      CredEleConv,
      TotalCredOblLlev,
      TotalCredElLlev,
      TotalCredOblAprob,
      TotalCredElAprob,
      TotalCredOblConv);

  /// Create a copy of GetAcademicHistoryTermStatisticsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetAcademicHistoryTermStatisticsModelImplCopyWith<
          _$GetAcademicHistoryTermStatisticsModelImpl>
      get copyWith => __$$GetAcademicHistoryTermStatisticsModelImplCopyWithImpl<
          _$GetAcademicHistoryTermStatisticsModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetAcademicHistoryTermStatisticsModelImplToJson(
      this,
    );
  }
}

abstract class _GetAcademicHistoryTermStatisticsModel
    implements GetAcademicHistoryTermStatisticsModel {
  const factory _GetAcademicHistoryTermStatisticsModel(
          {required final double PPS,
          required final double PPSAprob,
          required final double PPA,
          required final double PPAApr,
          required final double CreOblLlev,
          required final double CreElLlev,
          required final double CreOblApr,
          required final double CreEleApr,
          required final double CreOblConv,
          required final double CredEleConv,
          required final double TotalCredOblLlev,
          required final double TotalCredElLlev,
          required final double TotalCredOblAprob,
          required final double TotalCredElAprob,
          required final double TotalCredOblConv}) =
      _$GetAcademicHistoryTermStatisticsModelImpl;

  factory _GetAcademicHistoryTermStatisticsModel.fromJson(
          Map<String, dynamic> json) =
      _$GetAcademicHistoryTermStatisticsModelImpl.fromJson;

  @override
  double get PPS;
  @override
  double get PPSAprob;
  @override
  double get PPA;
  @override
  double get PPAApr;
  @override
  double get CreOblLlev;
  @override
  double get CreElLlev;
  @override
  double get CreOblApr;
  @override
  double get CreEleApr;
  @override
  double get CreOblConv;
  @override
  double get CredEleConv;
  @override
  double get TotalCredOblLlev;
  @override
  double get TotalCredElLlev;
  @override
  double get TotalCredOblAprob;
  @override
  double get TotalCredElAprob;
  @override
  double get TotalCredOblConv;

  /// Create a copy of GetAcademicHistoryTermStatisticsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetAcademicHistoryTermStatisticsModelImplCopyWith<
          _$GetAcademicHistoryTermStatisticsModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

GetAcademicHistoryCourseModel _$GetAcademicHistoryCourseModelFromJson(
    Map<String, dynamic> json) {
  return _GetAcademicHistoryCourseModel.fromJson(json);
}

/// @nodoc
mixin _$GetAcademicHistoryCourseModel {
  String get courseCode => throw _privateConstructorUsedError;
  String get courseName => throw _privateConstructorUsedError;
  String get courseType => throw _privateConstructorUsedError;
  int get credits => throw _privateConstructorUsedError;
  double get grade => throw _privateConstructorUsedError;

  /// Serializes this GetAcademicHistoryCourseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetAcademicHistoryCourseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetAcademicHistoryCourseModelCopyWith<GetAcademicHistoryCourseModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetAcademicHistoryCourseModelCopyWith<$Res> {
  factory $GetAcademicHistoryCourseModelCopyWith(
          GetAcademicHistoryCourseModel value,
          $Res Function(GetAcademicHistoryCourseModel) then) =
      _$GetAcademicHistoryCourseModelCopyWithImpl<$Res,
          GetAcademicHistoryCourseModel>;
  @useResult
  $Res call(
      {String courseCode,
      String courseName,
      String courseType,
      int credits,
      double grade});
}

/// @nodoc
class _$GetAcademicHistoryCourseModelCopyWithImpl<$Res,
        $Val extends GetAcademicHistoryCourseModel>
    implements $GetAcademicHistoryCourseModelCopyWith<$Res> {
  _$GetAcademicHistoryCourseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetAcademicHistoryCourseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? courseCode = null,
    Object? courseName = null,
    Object? courseType = null,
    Object? credits = null,
    Object? grade = null,
  }) {
    return _then(_value.copyWith(
      courseCode: null == courseCode
          ? _value.courseCode
          : courseCode // ignore: cast_nullable_to_non_nullable
              as String,
      courseName: null == courseName
          ? _value.courseName
          : courseName // ignore: cast_nullable_to_non_nullable
              as String,
      courseType: null == courseType
          ? _value.courseType
          : courseType // ignore: cast_nullable_to_non_nullable
              as String,
      credits: null == credits
          ? _value.credits
          : credits // ignore: cast_nullable_to_non_nullable
              as int,
      grade: null == grade
          ? _value.grade
          : grade // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetAcademicHistoryCourseModelImplCopyWith<$Res>
    implements $GetAcademicHistoryCourseModelCopyWith<$Res> {
  factory _$$GetAcademicHistoryCourseModelImplCopyWith(
          _$GetAcademicHistoryCourseModelImpl value,
          $Res Function(_$GetAcademicHistoryCourseModelImpl) then) =
      __$$GetAcademicHistoryCourseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String courseCode,
      String courseName,
      String courseType,
      int credits,
      double grade});
}

/// @nodoc
class __$$GetAcademicHistoryCourseModelImplCopyWithImpl<$Res>
    extends _$GetAcademicHistoryCourseModelCopyWithImpl<$Res,
        _$GetAcademicHistoryCourseModelImpl>
    implements _$$GetAcademicHistoryCourseModelImplCopyWith<$Res> {
  __$$GetAcademicHistoryCourseModelImplCopyWithImpl(
      _$GetAcademicHistoryCourseModelImpl _value,
      $Res Function(_$GetAcademicHistoryCourseModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetAcademicHistoryCourseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? courseCode = null,
    Object? courseName = null,
    Object? courseType = null,
    Object? credits = null,
    Object? grade = null,
  }) {
    return _then(_$GetAcademicHistoryCourseModelImpl(
      courseCode: null == courseCode
          ? _value.courseCode
          : courseCode // ignore: cast_nullable_to_non_nullable
              as String,
      courseName: null == courseName
          ? _value.courseName
          : courseName // ignore: cast_nullable_to_non_nullable
              as String,
      courseType: null == courseType
          ? _value.courseType
          : courseType // ignore: cast_nullable_to_non_nullable
              as String,
      credits: null == credits
          ? _value.credits
          : credits // ignore: cast_nullable_to_non_nullable
              as int,
      grade: null == grade
          ? _value.grade
          : grade // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetAcademicHistoryCourseModelImpl
    with DiagnosticableTreeMixin
    implements _GetAcademicHistoryCourseModel {
  const _$GetAcademicHistoryCourseModelImpl(
      {required this.courseCode,
      required this.courseName,
      required this.courseType,
      required this.credits,
      required this.grade});

  factory _$GetAcademicHistoryCourseModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GetAcademicHistoryCourseModelImplFromJson(json);

  @override
  final String courseCode;
  @override
  final String courseName;
  @override
  final String courseType;
  @override
  final int credits;
  @override
  final double grade;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'GetAcademicHistoryCourseModel(courseCode: $courseCode, courseName: $courseName, courseType: $courseType, credits: $credits, grade: $grade)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'GetAcademicHistoryCourseModel'))
      ..add(DiagnosticsProperty('courseCode', courseCode))
      ..add(DiagnosticsProperty('courseName', courseName))
      ..add(DiagnosticsProperty('courseType', courseType))
      ..add(DiagnosticsProperty('credits', credits))
      ..add(DiagnosticsProperty('grade', grade));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetAcademicHistoryCourseModelImpl &&
            (identical(other.courseCode, courseCode) ||
                other.courseCode == courseCode) &&
            (identical(other.courseName, courseName) ||
                other.courseName == courseName) &&
            (identical(other.courseType, courseType) ||
                other.courseType == courseType) &&
            (identical(other.credits, credits) || other.credits == credits) &&
            (identical(other.grade, grade) || other.grade == grade));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, courseCode, courseName, courseType, credits, grade);

  /// Create a copy of GetAcademicHistoryCourseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetAcademicHistoryCourseModelImplCopyWith<
          _$GetAcademicHistoryCourseModelImpl>
      get copyWith => __$$GetAcademicHistoryCourseModelImplCopyWithImpl<
          _$GetAcademicHistoryCourseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetAcademicHistoryCourseModelImplToJson(
      this,
    );
  }
}

abstract class _GetAcademicHistoryCourseModel
    implements GetAcademicHistoryCourseModel {
  const factory _GetAcademicHistoryCourseModel(
      {required final String courseCode,
      required final String courseName,
      required final String courseType,
      required final int credits,
      required final double grade}) = _$GetAcademicHistoryCourseModelImpl;

  factory _GetAcademicHistoryCourseModel.fromJson(Map<String, dynamic> json) =
      _$GetAcademicHistoryCourseModelImpl.fromJson;

  @override
  String get courseCode;
  @override
  String get courseName;
  @override
  String get courseType;
  @override
  int get credits;
  @override
  double get grade;

  /// Create a copy of GetAcademicHistoryCourseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetAcademicHistoryCourseModelImplCopyWith<
          _$GetAcademicHistoryCourseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
