import 'package:injectable/injectable.dart';
import 'package:sigapp/courses/application/exceptions/regeva_authentication_exception.dart';
import 'package:sigapp/courses/domain/repositories/courses_repository.dart';
import 'package:sigapp/courses/domain/repositories/regeva_repository.dart';

@lazySingleton
class GetSyllabusFileUsecase {
  final RegevaRepository _regevaRepository;
  final CoursesRepository _coursesRepository;

  GetSyllabusFileUsecase(this._regevaRepository, this._coursesRepository);

  Future<dynamic> execute(String scheduledCourseId) async {
    // Try to get the syllabus file
    try {
      return await _regevaRepository.getSyllabusFile(scheduledCourseId);
    } catch (e) {
      if (e is! RegevaAuthenticationException) rethrow;
    }

    // If the user is not authenticated, authenticate and try again
    final [studentCode, token1, token2] =
        await _coursesRepository.getStudentCodeAndRegevaTokens();
    await _regevaRepository.authenticate(
      sigaToken1: token1,
      sigaToken2: token2,
      studentCode: studentCode,
    );
    return await _regevaRepository.getSyllabusFile(scheduledCourseId);
  }
}
