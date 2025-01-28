import 'package:sigapp/student/domain/value_objects/partial_class_schedule.dart';

abstract class ScheduleRepository {
  Future<List<PartialClassSchedule>> getClassSchedule(String semesterId);
}
