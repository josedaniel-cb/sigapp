import 'dart:developer' as developer;

import 'package:injectable/injectable.dart';
import 'package:sigapp/auth/application/services/api_gateway_auth_service.dart';
import 'package:sigapp/auth/domain/repositories/auth_repository.dart';
import 'package:sigapp/auth/domain/repositories/shared_preferences_auth_repository.dart';
import 'package:sigapp/auth/domain/services/navigation_service.dart';

@injectable
class SignInUseCase {
  final AuthRepository _authRepository;
  final SharedPreferencesAuthRepository _sharedPreferencesAuthRepository;
  final ApiGatewayAuthService _supabaseAuthService;
  final NavigationService _navigationService;

  SignInUseCase(
    this._authRepository,
    this._sharedPreferencesAuthRepository,
    this._supabaseAuthService,
    this._navigationService,
  );

  Future<bool> execute(String username, String password) async {
    final response = await _authRepository.login(username, password);

    if (response.statusCode == 200) {
      return false;
    }

    if (response.statusCode != 302) {
      throw Exception('Unsupported status code: ${response.statusCode}');
    }

    await _sharedPreferencesAuthRepository.saveCredentials(username, password);
    await _supabaseSignInAndSignUp(username, password);
    _navigationService.refreshNavigation();

    return true;
  }

  Future<void> _supabaseSignInAndSignUp(
      String username, String password) async {
    try {
      await _supabaseAuthService.loginUser(
        password: password,
        studentCode: username,
      );
      developer.log(
        'Inicio de sesión exitoso en Supabase.',
        name: 'SignInUseCase',
      );
    } catch (e, s) {
      developer.log(
        'No se pudo iniciar sesión en Supabase, intentando registro.',
        name: 'SignInUseCase',
        error: e,
        stackTrace: s,
      );

      try {
        await _supabaseAuthService.registerUser(
          password: password,
          studentCode: username,
        );
        developer.log(
          'Registro exitoso en Supabase.',
          name: 'SignInUseCase',
        );
      } catch (registerError, registerStack) {
        developer.log(
          'No se pudo registrar en Supabase.',
          name: 'SignInUseCase',
          error: registerError,
          stackTrace: registerStack,
        );
        rethrow;
      }
      // ignore: dead_code_catch_following_catch
    } catch (e, s) {
      developer.log(
        'Error general durante la autenticación con Supabase.',
        name: 'SignInUseCase',
        error: e,
        stackTrace: s,
      );
      rethrow;
    }
  }
}
