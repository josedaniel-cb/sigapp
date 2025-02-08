import 'package:injectable/injectable.dart';
import 'package:sigapp/auth/domain/repositories/auth_repository.dart';
import 'package:sigapp/auth/domain/repositories/shared_preferences_auth_repository.dart';
import 'package:sigapp/auth/domain/services/navigation_service.dart';
import 'package:sigapp/courses/domain/repositories/regeva_repository.dart';

@injectable
class SignOutUseCase {
  final SharedPreferencesAuthRepository _sharedPreferencesAuthRepository;
  final NavigationService _navigationService;
  final AuthRepository _authRepository;
  final RegevaRepository _regevaRepository;

  SignOutUseCase(this._sharedPreferencesAuthRepository, this._navigationService,
      this._authRepository, this._regevaRepository);

  Future<void> execute() async {
    // required for refreshing navigation
    await _sharedPreferencesAuthRepository.removePassword();
    await _authRepository.disposeCookies();
    await _regevaRepository.disposeCookies();
    _navigationService.refreshNavigation();
  }
}
