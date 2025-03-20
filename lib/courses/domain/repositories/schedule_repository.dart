import 'package:sigapp/courses/domain/value-objects/raw_class_schedule.dart';

abstract class ScheduleRepository {
  Future<List<RawClassSchedule>> getClassSchedule(String semesterId);
}
