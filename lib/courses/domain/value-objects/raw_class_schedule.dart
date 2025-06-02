import 'package:freezed_annotation/freezed_annotation.dart';

part 'raw_class_schedule.freezed.dart';

@freezed
abstract class RawClassSchedule with _$RawClassSchedule {
  factory RawClassSchedule({
    required String startHour,
    required String endHour,
    required String monday,
    required String tuesday,
    required String wednesday,
    required String thursday,
    required String friday,
    required String saturday,
  }) = _RawClassSchedule;
}
