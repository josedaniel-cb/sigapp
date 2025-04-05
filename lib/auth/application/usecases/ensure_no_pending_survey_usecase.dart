import 'package:injectable/injectable.dart';
import 'package:sigapp/auth/domain/exceptions/pending_survey_exception.dart';
import 'package:sigapp/auth/domain/repositories/auth_repository.dart';
import 'package:sigapp/auth/domain/services/session_lifecycle_service.dart';
import 'package:sigapp/auth/domain/value-objects/api_response.dart';

@injectable
class EnsureNoPendingSurveyUseCase {
  final AuthRepository _authRepository;
  final SessionLifecycleService _sessionLifecycleService;

  EnsureNoPendingSurveyUseCase(
      this._authRepository, this._sessionLifecycleService);

  Future<void> execute(ApiResponse response) async {
    if (_sessionLifecycleService.evaluateIsSurveyAvailable(response)) {
      final survey1 = await _authRepository.checkSurvey1();
      if (survey1.statusCode == 200) {
        throw PendingSurveyException();
      }
      final survey2 = await _authRepository.checkSurvey2();
      if (survey2.statusCode == 200) {
        throw PendingSurveyException();
      }
    }
  }
}
