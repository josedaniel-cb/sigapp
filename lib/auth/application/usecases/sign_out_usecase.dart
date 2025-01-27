import 'package:injectable/injectable.dart';
import 'package:sigapp/auth/domain/repositories/shared_preferences_auth_repository.dart';
import 'package:sigapp/auth/domain/services/session_lifecycle_service.dart';

@injectable
class SignOutUseCase {
  final SharedPreferencesAuthRepository _sharedPreferencesAuthRepository;
  final SessionLifecycleService _sessionLifecycleService;

  SignOutUseCase(
      this._sharedPreferencesAuthRepository, this._sessionLifecycleService);

  Future<void> execute() async {
    await _sharedPreferencesAuthRepository.removePassword();
    _sessionLifecycleService.refreshNavigation();
  }
}
