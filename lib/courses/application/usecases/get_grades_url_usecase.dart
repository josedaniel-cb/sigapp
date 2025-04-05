import 'package:injectable/injectable.dart';
import 'package:sigapp/courses/application/services/regeva_auth_service.dart';
import 'package:sigapp/courses/domain/repositories/regeva_repository.dart';

@lazySingleton
class GetGradesUrlUsecase {
  final RegevaAuthService _regevaAuthService;
  final RegevaRepository _regevaRepository;

  GetGradesUrlUsecase(this._regevaAuthService, this._regevaRepository);

  Future<String> execute(String scheduledCourseId, [bool? refresh]) async {
    final credentials = await _regevaAuthService.getCredentials(refresh);
    return _regevaRepository.buildGradesUrl(
      scheduledCourseId: scheduledCourseId,
      studentCode: credentials.studentCode,
      token1: credentials.token1,
      token2: credentials.token2,
    );
  }
}
