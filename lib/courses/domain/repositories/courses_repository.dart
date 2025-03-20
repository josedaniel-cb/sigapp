import 'package:sigapp/student/domain/entities/raw_course_requirement.dart';
import 'package:sigapp/courses/domain/entities/enrolled_course_data.dart';

abstract class CoursesRepository {
  Future<List<EnrolledCourseData>> getEnrolledCourses(String semesterId);
  Future<List<RawCourseRequirement>> getCourseRequirements(String courseCode);
  Future<List<String>> getStudentCodeAndRegevaTokens();
}
