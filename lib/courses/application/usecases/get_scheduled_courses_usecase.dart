import 'package:injectable/injectable.dart';
import 'package:sigapp/courses/domain/entities/scheduled_course.dart';
import 'package:sigapp/courses/domain/repositories/courses_repository.dart';

@lazySingleton
class GetScheduledCoursesUsecase {
  final CoursesRepository _coursesRepository;

  GetScheduledCoursesUsecase(this._coursesRepository);

  Future<List<ScheduledCourse>> execute() async {
    return _coursesRepository.getScheduledCourses();
  }
}
