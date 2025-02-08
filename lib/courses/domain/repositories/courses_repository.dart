import 'package:sigapp/student/domain/entities/raw_course_requirement.dart';
import 'package:sigapp/student/domain/entities/raw_enrolled_course.dart';

abstract class CoursesRepository {
  Future<List<RawEnrolledCourse>> getEnrolledCourses(String semesterId);
  Future<List<RawCourseRequirement>> getCourseRequirements(String courseCode);
  Future<List<String>> getStudentCodeAndRegevaTokens();
}
