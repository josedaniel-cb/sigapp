import 'package:sigapp/student/domain/entities/enrolled_course.dart';

abstract class CoursesRepository {
  Future<List<EnrolledCourse>> getEnrolledCourses(String semesterId);
}
