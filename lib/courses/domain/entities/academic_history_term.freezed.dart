// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'academic_history_term.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AcademicHistoryTerm {
// required String termLabel,
  ScheduledTermIdentifier get term => throw _privateConstructorUsedError;
  AcademicHistoryTermStatistics? get statistics =>
      throw _privateConstructorUsedError;
  List<AcademicHistoryCourse> get courses => throw _privateConstructorUsedError;

  /// Create a copy of AcademicHistoryTerm
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AcademicHistoryTermCopyWith<AcademicHistoryTerm> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AcademicHistoryTermCopyWith<$Res> {
  factory $AcademicHistoryTermCopyWith(
          AcademicHistoryTerm value, $Res Function(AcademicHistoryTerm) then) =
      _$AcademicHistoryTermCopyWithImpl<$Res, AcademicHistoryTerm>;
  @useResult
  $Res call(
      {ScheduledTermIdentifier term,
      AcademicHistoryTermStatistics? statistics,
      List<AcademicHistoryCourse> courses});

  $AcademicHistoryTermStatisticsCopyWith<$Res>? get statistics;
}

/// @nodoc
class _$AcademicHistoryTermCopyWithImpl<$Res, $Val extends AcademicHistoryTerm>
    implements $AcademicHistoryTermCopyWith<$Res> {
  _$AcademicHistoryTermCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AcademicHistoryTerm
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? term = null,
    Object? statistics = freezed,
    Object? courses = null,
  }) {
    return _then(_value.copyWith(
      term: null == term
          ? _value.term
          : term // ignore: cast_nullable_to_non_nullable
              as ScheduledTermIdentifier,
      statistics: freezed == statistics
          ? _value.statistics
          : statistics // ignore: cast_nullable_to_non_nullable
              as AcademicHistoryTermStatistics?,
      courses: null == courses
          ? _value.courses
          : courses // ignore: cast_nullable_to_non_nullable
              as List<AcademicHistoryCourse>,
    ) as $Val);
  }

  /// Create a copy of AcademicHistoryTerm
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AcademicHistoryTermStatisticsCopyWith<$Res>? get statistics {
    if (_value.statistics == null) {
      return null;
    }

    return $AcademicHistoryTermStatisticsCopyWith<$Res>(_value.statistics!,
        (value) {
      return _then(_value.copyWith(statistics: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AcademicHistoryTermImplCopyWith<$Res>
    implements $AcademicHistoryTermCopyWith<$Res> {
  factory _$$AcademicHistoryTermImplCopyWith(_$AcademicHistoryTermImpl value,
          $Res Function(_$AcademicHistoryTermImpl) then) =
      __$$AcademicHistoryTermImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ScheduledTermIdentifier term,
      AcademicHistoryTermStatistics? statistics,
      List<AcademicHistoryCourse> courses});

  @override
  $AcademicHistoryTermStatisticsCopyWith<$Res>? get statistics;
}

/// @nodoc
class __$$AcademicHistoryTermImplCopyWithImpl<$Res>
    extends _$AcademicHistoryTermCopyWithImpl<$Res, _$AcademicHistoryTermImpl>
    implements _$$AcademicHistoryTermImplCopyWith<$Res> {
  __$$AcademicHistoryTermImplCopyWithImpl(_$AcademicHistoryTermImpl _value,
      $Res Function(_$AcademicHistoryTermImpl) _then)
      : super(_value, _then);

  /// Create a copy of AcademicHistoryTerm
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? term = null,
    Object? statistics = freezed,
    Object? courses = null,
  }) {
    return _then(_$AcademicHistoryTermImpl(
      term: null == term
          ? _value.term
          : term // ignore: cast_nullable_to_non_nullable
              as ScheduledTermIdentifier,
      statistics: freezed == statistics
          ? _value.statistics
          : statistics // ignore: cast_nullable_to_non_nullable
              as AcademicHistoryTermStatistics?,
      courses: null == courses
          ? _value._courses
          : courses // ignore: cast_nullable_to_non_nullable
              as List<AcademicHistoryCourse>,
    ));
  }
}

/// @nodoc

class _$AcademicHistoryTermImpl
    with DiagnosticableTreeMixin
    implements _AcademicHistoryTerm {
  const _$AcademicHistoryTermImpl(
      {required this.term,
      required this.statistics,
      required final List<AcademicHistoryCourse> courses})
      : _courses = courses;

// required String termLabel,
  @override
  final ScheduledTermIdentifier term;
  @override
  final AcademicHistoryTermStatistics? statistics;
  final List<AcademicHistoryCourse> _courses;
  @override
  List<AcademicHistoryCourse> get courses {
    if (_courses is EqualUnmodifiableListView) return _courses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_courses);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AcademicHistoryTerm(term: $term, statistics: $statistics, courses: $courses)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AcademicHistoryTerm'))
      ..add(DiagnosticsProperty('term', term))
      ..add(DiagnosticsProperty('statistics', statistics))
      ..add(DiagnosticsProperty('courses', courses));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AcademicHistoryTermImpl &&
            (identical(other.term, term) || other.term == term) &&
            (identical(other.statistics, statistics) ||
                other.statistics == statistics) &&
            const DeepCollectionEquality().equals(other._courses, _courses));
  }

  @override
  int get hashCode => Object.hash(runtimeType, term, statistics,
      const DeepCollectionEquality().hash(_courses));

  /// Create a copy of AcademicHistoryTerm
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AcademicHistoryTermImplCopyWith<_$AcademicHistoryTermImpl> get copyWith =>
      __$$AcademicHistoryTermImplCopyWithImpl<_$AcademicHistoryTermImpl>(
          this, _$identity);
}

abstract class _AcademicHistoryTerm implements AcademicHistoryTerm {
  const factory _AcademicHistoryTerm(
          {required final ScheduledTermIdentifier term,
          required final AcademicHistoryTermStatistics? statistics,
          required final List<AcademicHistoryCourse> courses}) =
      _$AcademicHistoryTermImpl;

// required String termLabel,
  @override
  ScheduledTermIdentifier get term;
  @override
  AcademicHistoryTermStatistics? get statistics;
  @override
  List<AcademicHistoryCourse> get courses;

  /// Create a copy of AcademicHistoryTerm
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AcademicHistoryTermImplCopyWith<_$AcademicHistoryTermImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AcademicHistoryTermStatistics {
// required String PPS,
  double get termWeightedAverage =>
      throw _privateConstructorUsedError; // required String PPSAprob,
  double get termWeightedAveragePassed =>
      throw _privateConstructorUsedError; // required String PPA,
  double get cumulativeWeightedAverage =>
      throw _privateConstructorUsedError; // required String PPAApr,
  double get cumulativeWeightedAveragePassed =>
      throw _privateConstructorUsedError; // required String CreOblLlev,
  int get mandatoryCreditsTaken =>
      throw _privateConstructorUsedError; // required String CreElLlev,
  int get electiveCreditsTaken =>
      throw _privateConstructorUsedError; // required String CreOblApr,
  int get mandatoryCreditsPassed =>
      throw _privateConstructorUsedError; // required String CreEleApr,
  int get electiveCreditsPassed =>
      throw _privateConstructorUsedError; // required String CreOblConv,
  int get mandatoryCreditsValidated =>
      throw _privateConstructorUsedError; // required String CredEleConv,
  int get electiveCreditsValidated =>
      throw _privateConstructorUsedError; // required String TotalCredOblLlev,
  int get totalMandatoryCreditsTaken =>
      throw _privateConstructorUsedError; // required String TotalCredElLlev,
  int get totalElectiveCreditsTaken =>
      throw _privateConstructorUsedError; // required String TotalCredOblAprob,
  int get totalMandatoryCreditsPassed =>
      throw _privateConstructorUsedError; // required String TotalCredElAprob,
  int get totalElectiveCreditsPassed =>
      throw _privateConstructorUsedError; // required String TotalCredOblConv,
  int get totalMandatoryCreditsValidated => throw _privateConstructorUsedError;

  /// Create a copy of AcademicHistoryTermStatistics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AcademicHistoryTermStatisticsCopyWith<AcademicHistoryTermStatistics>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AcademicHistoryTermStatisticsCopyWith<$Res> {
  factory $AcademicHistoryTermStatisticsCopyWith(
          AcademicHistoryTermStatistics value,
          $Res Function(AcademicHistoryTermStatistics) then) =
      _$AcademicHistoryTermStatisticsCopyWithImpl<$Res,
          AcademicHistoryTermStatistics>;
  @useResult
  $Res call(
      {double termWeightedAverage,
      double termWeightedAveragePassed,
      double cumulativeWeightedAverage,
      double cumulativeWeightedAveragePassed,
      int mandatoryCreditsTaken,
      int electiveCreditsTaken,
      int mandatoryCreditsPassed,
      int electiveCreditsPassed,
      int mandatoryCreditsValidated,
      int electiveCreditsValidated,
      int totalMandatoryCreditsTaken,
      int totalElectiveCreditsTaken,
      int totalMandatoryCreditsPassed,
      int totalElectiveCreditsPassed,
      int totalMandatoryCreditsValidated});
}

/// @nodoc
class _$AcademicHistoryTermStatisticsCopyWithImpl<$Res,
        $Val extends AcademicHistoryTermStatistics>
    implements $AcademicHistoryTermStatisticsCopyWith<$Res> {
  _$AcademicHistoryTermStatisticsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AcademicHistoryTermStatistics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? termWeightedAverage = null,
    Object? termWeightedAveragePassed = null,
    Object? cumulativeWeightedAverage = null,
    Object? cumulativeWeightedAveragePassed = null,
    Object? mandatoryCreditsTaken = null,
    Object? electiveCreditsTaken = null,
    Object? mandatoryCreditsPassed = null,
    Object? electiveCreditsPassed = null,
    Object? mandatoryCreditsValidated = null,
    Object? electiveCreditsValidated = null,
    Object? totalMandatoryCreditsTaken = null,
    Object? totalElectiveCreditsTaken = null,
    Object? totalMandatoryCreditsPassed = null,
    Object? totalElectiveCreditsPassed = null,
    Object? totalMandatoryCreditsValidated = null,
  }) {
    return _then(_value.copyWith(
      termWeightedAverage: null == termWeightedAverage
          ? _value.termWeightedAverage
          : termWeightedAverage // ignore: cast_nullable_to_non_nullable
              as double,
      termWeightedAveragePassed: null == termWeightedAveragePassed
          ? _value.termWeightedAveragePassed
          : termWeightedAveragePassed // ignore: cast_nullable_to_non_nullable
              as double,
      cumulativeWeightedAverage: null == cumulativeWeightedAverage
          ? _value.cumulativeWeightedAverage
          : cumulativeWeightedAverage // ignore: cast_nullable_to_non_nullable
              as double,
      cumulativeWeightedAveragePassed: null == cumulativeWeightedAveragePassed
          ? _value.cumulativeWeightedAveragePassed
          : cumulativeWeightedAveragePassed // ignore: cast_nullable_to_non_nullable
              as double,
      mandatoryCreditsTaken: null == mandatoryCreditsTaken
          ? _value.mandatoryCreditsTaken
          : mandatoryCreditsTaken // ignore: cast_nullable_to_non_nullable
              as int,
      electiveCreditsTaken: null == electiveCreditsTaken
          ? _value.electiveCreditsTaken
          : electiveCreditsTaken // ignore: cast_nullable_to_non_nullable
              as int,
      mandatoryCreditsPassed: null == mandatoryCreditsPassed
          ? _value.mandatoryCreditsPassed
          : mandatoryCreditsPassed // ignore: cast_nullable_to_non_nullable
              as int,
      electiveCreditsPassed: null == electiveCreditsPassed
          ? _value.electiveCreditsPassed
          : electiveCreditsPassed // ignore: cast_nullable_to_non_nullable
              as int,
      mandatoryCreditsValidated: null == mandatoryCreditsValidated
          ? _value.mandatoryCreditsValidated
          : mandatoryCreditsValidated // ignore: cast_nullable_to_non_nullable
              as int,
      electiveCreditsValidated: null == electiveCreditsValidated
          ? _value.electiveCreditsValidated
          : electiveCreditsValidated // ignore: cast_nullable_to_non_nullable
              as int,
      totalMandatoryCreditsTaken: null == totalMandatoryCreditsTaken
          ? _value.totalMandatoryCreditsTaken
          : totalMandatoryCreditsTaken // ignore: cast_nullable_to_non_nullable
              as int,
      totalElectiveCreditsTaken: null == totalElectiveCreditsTaken
          ? _value.totalElectiveCreditsTaken
          : totalElectiveCreditsTaken // ignore: cast_nullable_to_non_nullable
              as int,
      totalMandatoryCreditsPassed: null == totalMandatoryCreditsPassed
          ? _value.totalMandatoryCreditsPassed
          : totalMandatoryCreditsPassed // ignore: cast_nullable_to_non_nullable
              as int,
      totalElectiveCreditsPassed: null == totalElectiveCreditsPassed
          ? _value.totalElectiveCreditsPassed
          : totalElectiveCreditsPassed // ignore: cast_nullable_to_non_nullable
              as int,
      totalMandatoryCreditsValidated: null == totalMandatoryCreditsValidated
          ? _value.totalMandatoryCreditsValidated
          : totalMandatoryCreditsValidated // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AcademicHistoryTermStatisticsImplCopyWith<$Res>
    implements $AcademicHistoryTermStatisticsCopyWith<$Res> {
  factory _$$AcademicHistoryTermStatisticsImplCopyWith(
          _$AcademicHistoryTermStatisticsImpl value,
          $Res Function(_$AcademicHistoryTermStatisticsImpl) then) =
      __$$AcademicHistoryTermStatisticsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double termWeightedAverage,
      double termWeightedAveragePassed,
      double cumulativeWeightedAverage,
      double cumulativeWeightedAveragePassed,
      int mandatoryCreditsTaken,
      int electiveCreditsTaken,
      int mandatoryCreditsPassed,
      int electiveCreditsPassed,
      int mandatoryCreditsValidated,
      int electiveCreditsValidated,
      int totalMandatoryCreditsTaken,
      int totalElectiveCreditsTaken,
      int totalMandatoryCreditsPassed,
      int totalElectiveCreditsPassed,
      int totalMandatoryCreditsValidated});
}

/// @nodoc
class __$$AcademicHistoryTermStatisticsImplCopyWithImpl<$Res>
    extends _$AcademicHistoryTermStatisticsCopyWithImpl<$Res,
        _$AcademicHistoryTermStatisticsImpl>
    implements _$$AcademicHistoryTermStatisticsImplCopyWith<$Res> {
  __$$AcademicHistoryTermStatisticsImplCopyWithImpl(
      _$AcademicHistoryTermStatisticsImpl _value,
      $Res Function(_$AcademicHistoryTermStatisticsImpl) _then)
      : super(_value, _then);

  /// Create a copy of AcademicHistoryTermStatistics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? termWeightedAverage = null,
    Object? termWeightedAveragePassed = null,
    Object? cumulativeWeightedAverage = null,
    Object? cumulativeWeightedAveragePassed = null,
    Object? mandatoryCreditsTaken = null,
    Object? electiveCreditsTaken = null,
    Object? mandatoryCreditsPassed = null,
    Object? electiveCreditsPassed = null,
    Object? mandatoryCreditsValidated = null,
    Object? electiveCreditsValidated = null,
    Object? totalMandatoryCreditsTaken = null,
    Object? totalElectiveCreditsTaken = null,
    Object? totalMandatoryCreditsPassed = null,
    Object? totalElectiveCreditsPassed = null,
    Object? totalMandatoryCreditsValidated = null,
  }) {
    return _then(_$AcademicHistoryTermStatisticsImpl(
      termWeightedAverage: null == termWeightedAverage
          ? _value.termWeightedAverage
          : termWeightedAverage // ignore: cast_nullable_to_non_nullable
              as double,
      termWeightedAveragePassed: null == termWeightedAveragePassed
          ? _value.termWeightedAveragePassed
          : termWeightedAveragePassed // ignore: cast_nullable_to_non_nullable
              as double,
      cumulativeWeightedAverage: null == cumulativeWeightedAverage
          ? _value.cumulativeWeightedAverage
          : cumulativeWeightedAverage // ignore: cast_nullable_to_non_nullable
              as double,
      cumulativeWeightedAveragePassed: null == cumulativeWeightedAveragePassed
          ? _value.cumulativeWeightedAveragePassed
          : cumulativeWeightedAveragePassed // ignore: cast_nullable_to_non_nullable
              as double,
      mandatoryCreditsTaken: null == mandatoryCreditsTaken
          ? _value.mandatoryCreditsTaken
          : mandatoryCreditsTaken // ignore: cast_nullable_to_non_nullable
              as int,
      electiveCreditsTaken: null == electiveCreditsTaken
          ? _value.electiveCreditsTaken
          : electiveCreditsTaken // ignore: cast_nullable_to_non_nullable
              as int,
      mandatoryCreditsPassed: null == mandatoryCreditsPassed
          ? _value.mandatoryCreditsPassed
          : mandatoryCreditsPassed // ignore: cast_nullable_to_non_nullable
              as int,
      electiveCreditsPassed: null == electiveCreditsPassed
          ? _value.electiveCreditsPassed
          : electiveCreditsPassed // ignore: cast_nullable_to_non_nullable
              as int,
      mandatoryCreditsValidated: null == mandatoryCreditsValidated
          ? _value.mandatoryCreditsValidated
          : mandatoryCreditsValidated // ignore: cast_nullable_to_non_nullable
              as int,
      electiveCreditsValidated: null == electiveCreditsValidated
          ? _value.electiveCreditsValidated
          : electiveCreditsValidated // ignore: cast_nullable_to_non_nullable
              as int,
      totalMandatoryCreditsTaken: null == totalMandatoryCreditsTaken
          ? _value.totalMandatoryCreditsTaken
          : totalMandatoryCreditsTaken // ignore: cast_nullable_to_non_nullable
              as int,
      totalElectiveCreditsTaken: null == totalElectiveCreditsTaken
          ? _value.totalElectiveCreditsTaken
          : totalElectiveCreditsTaken // ignore: cast_nullable_to_non_nullable
              as int,
      totalMandatoryCreditsPassed: null == totalMandatoryCreditsPassed
          ? _value.totalMandatoryCreditsPassed
          : totalMandatoryCreditsPassed // ignore: cast_nullable_to_non_nullable
              as int,
      totalElectiveCreditsPassed: null == totalElectiveCreditsPassed
          ? _value.totalElectiveCreditsPassed
          : totalElectiveCreditsPassed // ignore: cast_nullable_to_non_nullable
              as int,
      totalMandatoryCreditsValidated: null == totalMandatoryCreditsValidated
          ? _value.totalMandatoryCreditsValidated
          : totalMandatoryCreditsValidated // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$AcademicHistoryTermStatisticsImpl
    with DiagnosticableTreeMixin
    implements _AcademicHistoryTermStatistics {
  const _$AcademicHistoryTermStatisticsImpl(
      {required this.termWeightedAverage,
      required this.termWeightedAveragePassed,
      required this.cumulativeWeightedAverage,
      required this.cumulativeWeightedAveragePassed,
      required this.mandatoryCreditsTaken,
      required this.electiveCreditsTaken,
      required this.mandatoryCreditsPassed,
      required this.electiveCreditsPassed,
      required this.mandatoryCreditsValidated,
      required this.electiveCreditsValidated,
      required this.totalMandatoryCreditsTaken,
      required this.totalElectiveCreditsTaken,
      required this.totalMandatoryCreditsPassed,
      required this.totalElectiveCreditsPassed,
      required this.totalMandatoryCreditsValidated});

// required String PPS,
  @override
  final double termWeightedAverage;
// required String PPSAprob,
  @override
  final double termWeightedAveragePassed;
// required String PPA,
  @override
  final double cumulativeWeightedAverage;
// required String PPAApr,
  @override
  final double cumulativeWeightedAveragePassed;
// required String CreOblLlev,
  @override
  final int mandatoryCreditsTaken;
// required String CreElLlev,
  @override
  final int electiveCreditsTaken;
// required String CreOblApr,
  @override
  final int mandatoryCreditsPassed;
// required String CreEleApr,
  @override
  final int electiveCreditsPassed;
// required String CreOblConv,
  @override
  final int mandatoryCreditsValidated;
// required String CredEleConv,
  @override
  final int electiveCreditsValidated;
// required String TotalCredOblLlev,
  @override
  final int totalMandatoryCreditsTaken;
// required String TotalCredElLlev,
  @override
  final int totalElectiveCreditsTaken;
// required String TotalCredOblAprob,
  @override
  final int totalMandatoryCreditsPassed;
// required String TotalCredElAprob,
  @override
  final int totalElectiveCreditsPassed;
// required String TotalCredOblConv,
  @override
  final int totalMandatoryCreditsValidated;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AcademicHistoryTermStatistics(termWeightedAverage: $termWeightedAverage, termWeightedAveragePassed: $termWeightedAveragePassed, cumulativeWeightedAverage: $cumulativeWeightedAverage, cumulativeWeightedAveragePassed: $cumulativeWeightedAveragePassed, mandatoryCreditsTaken: $mandatoryCreditsTaken, electiveCreditsTaken: $electiveCreditsTaken, mandatoryCreditsPassed: $mandatoryCreditsPassed, electiveCreditsPassed: $electiveCreditsPassed, mandatoryCreditsValidated: $mandatoryCreditsValidated, electiveCreditsValidated: $electiveCreditsValidated, totalMandatoryCreditsTaken: $totalMandatoryCreditsTaken, totalElectiveCreditsTaken: $totalElectiveCreditsTaken, totalMandatoryCreditsPassed: $totalMandatoryCreditsPassed, totalElectiveCreditsPassed: $totalElectiveCreditsPassed, totalMandatoryCreditsValidated: $totalMandatoryCreditsValidated)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AcademicHistoryTermStatistics'))
      ..add(DiagnosticsProperty('termWeightedAverage', termWeightedAverage))
      ..add(DiagnosticsProperty(
          'termWeightedAveragePassed', termWeightedAveragePassed))
      ..add(DiagnosticsProperty(
          'cumulativeWeightedAverage', cumulativeWeightedAverage))
      ..add(DiagnosticsProperty(
          'cumulativeWeightedAveragePassed', cumulativeWeightedAveragePassed))
      ..add(DiagnosticsProperty('mandatoryCreditsTaken', mandatoryCreditsTaken))
      ..add(DiagnosticsProperty('electiveCreditsTaken', electiveCreditsTaken))
      ..add(
          DiagnosticsProperty('mandatoryCreditsPassed', mandatoryCreditsPassed))
      ..add(DiagnosticsProperty('electiveCreditsPassed', electiveCreditsPassed))
      ..add(DiagnosticsProperty(
          'mandatoryCreditsValidated', mandatoryCreditsValidated))
      ..add(DiagnosticsProperty(
          'electiveCreditsValidated', electiveCreditsValidated))
      ..add(DiagnosticsProperty(
          'totalMandatoryCreditsTaken', totalMandatoryCreditsTaken))
      ..add(DiagnosticsProperty(
          'totalElectiveCreditsTaken', totalElectiveCreditsTaken))
      ..add(DiagnosticsProperty(
          'totalMandatoryCreditsPassed', totalMandatoryCreditsPassed))
      ..add(DiagnosticsProperty(
          'totalElectiveCreditsPassed', totalElectiveCreditsPassed))
      ..add(DiagnosticsProperty(
          'totalMandatoryCreditsValidated', totalMandatoryCreditsValidated));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AcademicHistoryTermStatisticsImpl &&
            (identical(other.termWeightedAverage, termWeightedAverage) ||
                other.termWeightedAverage == termWeightedAverage) &&
            (identical(other.termWeightedAveragePassed, termWeightedAveragePassed) ||
                other.termWeightedAveragePassed == termWeightedAveragePassed) &&
            (identical(other.cumulativeWeightedAverage, cumulativeWeightedAverage) ||
                other.cumulativeWeightedAverage == cumulativeWeightedAverage) &&
            (identical(other.cumulativeWeightedAveragePassed,
                    cumulativeWeightedAveragePassed) ||
                other.cumulativeWeightedAveragePassed ==
                    cumulativeWeightedAveragePassed) &&
            (identical(other.mandatoryCreditsTaken, mandatoryCreditsTaken) ||
                other.mandatoryCreditsTaken == mandatoryCreditsTaken) &&
            (identical(other.electiveCreditsTaken, electiveCreditsTaken) ||
                other.electiveCreditsTaken == electiveCreditsTaken) &&
            (identical(other.mandatoryCreditsPassed, mandatoryCreditsPassed) ||
                other.mandatoryCreditsPassed == mandatoryCreditsPassed) &&
            (identical(other.electiveCreditsPassed, electiveCreditsPassed) ||
                other.electiveCreditsPassed == electiveCreditsPassed) &&
            (identical(other.mandatoryCreditsValidated, mandatoryCreditsValidated) ||
                other.mandatoryCreditsValidated == mandatoryCreditsValidated) &&
            (identical(other.electiveCreditsValidated, electiveCreditsValidated) ||
                other.electiveCreditsValidated == electiveCreditsValidated) &&
            (identical(other.totalMandatoryCreditsTaken, totalMandatoryCreditsTaken) ||
                other.totalMandatoryCreditsTaken ==
                    totalMandatoryCreditsTaken) &&
            (identical(other.totalElectiveCreditsTaken, totalElectiveCreditsTaken) ||
                other.totalElectiveCreditsTaken == totalElectiveCreditsTaken) &&
            (identical(other.totalMandatoryCreditsPassed, totalMandatoryCreditsPassed) ||
                other.totalMandatoryCreditsPassed ==
                    totalMandatoryCreditsPassed) &&
            (identical(other.totalElectiveCreditsPassed, totalElectiveCreditsPassed) ||
                other.totalElectiveCreditsPassed ==
                    totalElectiveCreditsPassed) &&
            (identical(other.totalMandatoryCreditsValidated,
                    totalMandatoryCreditsValidated) ||
                other.totalMandatoryCreditsValidated == totalMandatoryCreditsValidated));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      termWeightedAverage,
      termWeightedAveragePassed,
      cumulativeWeightedAverage,
      cumulativeWeightedAveragePassed,
      mandatoryCreditsTaken,
      electiveCreditsTaken,
      mandatoryCreditsPassed,
      electiveCreditsPassed,
      mandatoryCreditsValidated,
      electiveCreditsValidated,
      totalMandatoryCreditsTaken,
      totalElectiveCreditsTaken,
      totalMandatoryCreditsPassed,
      totalElectiveCreditsPassed,
      totalMandatoryCreditsValidated);

  /// Create a copy of AcademicHistoryTermStatistics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AcademicHistoryTermStatisticsImplCopyWith<
          _$AcademicHistoryTermStatisticsImpl>
      get copyWith => __$$AcademicHistoryTermStatisticsImplCopyWithImpl<
          _$AcademicHistoryTermStatisticsImpl>(this, _$identity);
}

abstract class _AcademicHistoryTermStatistics
    implements AcademicHistoryTermStatistics {
  const factory _AcademicHistoryTermStatistics(
          {required final double termWeightedAverage,
          required final double termWeightedAveragePassed,
          required final double cumulativeWeightedAverage,
          required final double cumulativeWeightedAveragePassed,
          required final int mandatoryCreditsTaken,
          required final int electiveCreditsTaken,
          required final int mandatoryCreditsPassed,
          required final int electiveCreditsPassed,
          required final int mandatoryCreditsValidated,
          required final int electiveCreditsValidated,
          required final int totalMandatoryCreditsTaken,
          required final int totalElectiveCreditsTaken,
          required final int totalMandatoryCreditsPassed,
          required final int totalElectiveCreditsPassed,
          required final int totalMandatoryCreditsValidated}) =
      _$AcademicHistoryTermStatisticsImpl;

// required String PPS,
  @override
  double get termWeightedAverage; // required String PPSAprob,
  @override
  double get termWeightedAveragePassed; // required String PPA,
  @override
  double get cumulativeWeightedAverage; // required String PPAApr,
  @override
  double get cumulativeWeightedAveragePassed; // required String CreOblLlev,
  @override
  int get mandatoryCreditsTaken; // required String CreElLlev,
  @override
  int get electiveCreditsTaken; // required String CreOblApr,
  @override
  int get mandatoryCreditsPassed; // required String CreEleApr,
  @override
  int get electiveCreditsPassed; // required String CreOblConv,
  @override
  int get mandatoryCreditsValidated; // required String CredEleConv,
  @override
  int get electiveCreditsValidated; // required String TotalCredOblLlev,
  @override
  int get totalMandatoryCreditsTaken; // required String TotalCredElLlev,
  @override
  int get totalElectiveCreditsTaken; // required String TotalCredOblAprob,
  @override
  int get totalMandatoryCreditsPassed; // required String TotalCredElAprob,
  @override
  int get totalElectiveCreditsPassed; // required String TotalCredOblConv,
  @override
  int get totalMandatoryCreditsValidated;

  /// Create a copy of AcademicHistoryTermStatistics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AcademicHistoryTermStatisticsImplCopyWith<
          _$AcademicHistoryTermStatisticsImpl>
      get copyWith => throw _privateConstructorUsedError;
}
