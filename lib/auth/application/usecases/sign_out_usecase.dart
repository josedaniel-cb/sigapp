import 'package:injectable/injectable.dart';
import 'package:sigapp/auth/domain/repositories/shared_preferences_auth_repository.dart';
import 'package:sigapp/auth/domain/services/navigation_service.dart';

@injectable
class SignOutUseCase {
  final SharedPreferencesAuthRepository _sharedPreferencesAuthRepository;
  final NavigationService _navigationService;

  SignOutUseCase(
      this._sharedPreferencesAuthRepository, this._navigationService);

  Future<void> execute() async {
    await _sharedPreferencesAuthRepository.removePassword();
    _navigationService.refreshNavigation();
  }
}
