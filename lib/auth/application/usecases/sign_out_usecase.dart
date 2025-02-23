import 'package:injectable/injectable.dart';
import 'package:sigapp/auth/domain/repositories/auth_repository.dart';
import 'package:sigapp/auth/domain/repositories/shared_preferences_auth_repository.dart';
import 'package:sigapp/auth/domain/services/navigation_service.dart';
import 'package:sigapp/core/domain/service/app_loading_service.dart';
import 'package:sigapp/courses/domain/repositories/regeva_repository.dart';

@injectable
class SignOutUseCase {
  final SharedPreferencesAuthRepository _sharedPreferencesAuthRepository;
  final NavigationService _navigationService;
  final AuthRepository _authRepository;
  final RegevaRepository _regevaRepository;
  final ProgressIndicatorService _progressIndicatorService;

  SignOutUseCase(
      this._sharedPreferencesAuthRepository,
      this._navigationService,
      this._authRepository,
      this._regevaRepository,
      this._progressIndicatorService);

  Future<void> execute([String? message]) async {
    await _progressIndicatorService.show();

    try {
      // required for refreshing navigation
      await _sharedPreferencesAuthRepository.removePassword();

      // clear cookies :p
      await _authRepository.disposeCookies();
      await _regevaRepository.disposeCookies();
    } catch (_) {
      await _progressIndicatorService.hide();
      rethrow;
    }

    await _progressIndicatorService.hide();

    // ui navigation
    _navigationService.refreshNavigation(message);
  }
}
