import 'package:injectable/injectable.dart';
import 'package:sigapp/auth/domain/repositories/auth_repository.dart';
import 'package:sigapp/auth/domain/repositories/shared_preferences_auth_repository.dart';
import 'package:sigapp/auth/domain/services/session_lifecycle_service.dart';

@injectable
class SignInUseCase {
  final AuthRepository _authRepository;
  final SharedPreferencesAuthRepository _sharedPreferencesAuthRepository;
  final SessionLifecycleService _sessionService;

  SignInUseCase(this._authRepository, this._sharedPreferencesAuthRepository,
      this._sessionService);

  Future<bool> execute(String username, String password) async {
    final response = await _authRepository.login(username, password);

    // Success
    if (response.statusCode == 302) {
      await _sharedPreferencesAuthRepository.saveCredentials(
          username, password);
      _sessionService.refreshNavigation();
      return true;
    }

    // Failure
    if (response.statusCode == 200) {
      return false;
    }

    // Error
    throw Exception('Unsupported status code: ${response.statusCode}');
  }
}
