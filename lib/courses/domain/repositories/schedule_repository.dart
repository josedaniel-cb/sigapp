import 'package:sigapp/student/domain/value_objects/raw_class_schedule.dart';

abstract class ScheduleRepository {
  Future<List<RawClassSchedule>> getClassSchedule(String semesterId);
}
