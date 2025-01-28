import 'package:freezed_annotation/freezed_annotation.dart';

part 'partial_class_schedule.freezed.dart';

@freezed
class PartialClassSchedule with _$PartialClassSchedule {
  factory PartialClassSchedule({
    required String startHour,
    required String endHour,
    required String monday,
    required String tuesday,
    required String wednesday,
    required String thursday,
    required String friday,
    required String saturday,
  }) = _PartialClassSchedule;
}
