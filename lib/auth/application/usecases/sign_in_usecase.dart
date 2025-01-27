import 'package:injectable/injectable.dart';
import 'package:sigapp/auth/domain/repositories/auth_repository.dart';
import 'package:sigapp/auth/domain/repositories/shared_preferences_auth_repository.dart';

@injectable
class SignInUseCase {
  final AuthRepository _authRepository;
  final SharedPreferencesAuthRepository _sharedPreferencesAuthRepository;

  SignInUseCase(this._authRepository, this._sharedPreferencesAuthRepository);

  Future<bool> execute(String username, String password) async {
    final response = await _authRepository.login(username, password);

    // Success
    if (response.statusCode == 302) {
      _sharedPreferencesAuthRepository.saveCredentials(username, password);
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
