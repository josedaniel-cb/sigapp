import 'package:injectable/injectable.dart';
import 'package:sigapp/courses/application/services/regeva_auth_service.dart';
import 'package:sigapp/courses/domain/repositories/regeva_repository.dart';
import 'package:sigapp/courses/domain/value-objects/course_grade.dart';

@lazySingleton
class GetCourseGradeUsecase {
  final RegevaAuthService _regevaAuthService;
  final RegevaRepository _regevaRepository;

  GetCourseGradeUsecase(this._regevaAuthService, this._regevaRepository);

  Future<CourseGradeInfo> execute(String scheduledCourseId,
      [bool? refresh]) async {
    final credentials = await _regevaAuthService.getCredentials(refresh);
    return CourseGradeInfo(
      grade: await _regevaRepository
          .getCourseGrade(
        scheduledCourseId: scheduledCourseId,
        studentCode: credentials.studentCode,
        sigaToken1: credentials.token1,
        sigaToken2: credentials.token2,
      )
          .then((value) {
        if (value == null) {
          return CourseGradePreview.empty();
        }
        return CourseGradePreview.loaded(
          value: value.value,
          isPartial: value.isPartial,
        );
      }).catchError(
        (error) {
          return CourseGradePreview.error(error);
        },
      ),
      url: _regevaRepository.buildGradesUrl(
        scheduledCourseId: scheduledCourseId,
        studentCode: credentials.studentCode,
        token1: credentials.token1,
        token2: credentials.token2,
      ),
    );
  }
}
