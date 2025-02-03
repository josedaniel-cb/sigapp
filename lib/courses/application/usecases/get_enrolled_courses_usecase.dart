import 'package:injectable/injectable.dart';
import 'package:sigapp/courses/domain/repositories/courses_repository.dart';
import 'package:sigapp/student/domain/entities/enrolled_course.dart';

@lazySingleton
class GetEnrolledCoursesUsecase {
  final CoursesRepository _coursesRepository;

  GetEnrolledCoursesUsecase(this._coursesRepository);

  Future<List<EnrolledCourse>> execute(String semesterId) async {
    return await _coursesRepository.getEnrolledCourses(semesterId);
  }
}
