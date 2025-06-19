import 'package:injectable/injectable.dart';
import 'package:sigapp/auth/application/services/api_gateway_auth_service.dart';
import 'package:sigapp/auth/domain/repositories/auth_repository.dart';
import 'package:sigapp/auth/domain/repositories/shared_preferences_auth_repository.dart';
import 'package:sigapp/auth/domain/services/navigation_service.dart';
import 'package:sigapp/auth/domain/services/session_lifecycle_service.dart';
import 'package:sigapp/student/domain/services/academic_info_service.dart';
import 'package:logger/logger.dart';

@injectable
class SignInUseCase {
  final AuthRepository _authRepository;
  final SharedPreferencesAuthRepository _sharedPreferencesAuthRepository;
  final ApiGatewayAuthService _supabaseAuthService;
  final NavigationService _navigationService;
  // TODO: Required refactor in order to impement cashing at the infrastructure layer
  // TODO: Required refactor in order to not call services from usecases
  final AcademicInfoService _academicInfoService;
  final SessionLifecycleService _sessionLifecycleService;
  final Logger _logger;

  SignInUseCase(
    this._authRepository,
    this._sharedPreferencesAuthRepository,
    this._supabaseAuthService,
    this._navigationService,
    this._academicInfoService,
    this._sessionLifecycleService,
    this._logger,
  );

  Future<bool> execute(String username, String password) async {
    final response = await _authRepository.login(username, password);
    final success = _sessionLifecycleService.checkLoginResult(
      headers: response.headers,
      statusCode: response.statusCode,
    );
    if (!success) return false;

    await _sharedPreferencesAuthRepository.saveCredentials(username, password);

    // Validate if student user is ready to use the app
    // This could throw an exception if the student is newly registered
    try {
      await _academicInfoService.getSessionInfo();
    } catch (e, s) {
      _logger.e(
        '[APPLICATION] Error al obtener la información de la sesión del estudiante.',
        error: e,
        stackTrace: s,
      );
      throw Exception('Ocurrió un error al obtener tu información: $e');
    }

    await _supabaseSignInAndSignUp(username, password);
    _navigationService.refreshNavigation();

    return true;
  }

  Future<void> _supabaseSignInAndSignUp(
    String username,
    String password,
  ) async {
    try {
      final userExists = await _supabaseAuthService.userExists(
        studentCode: username,
      );

      if (userExists) {
        // Usuario existe - intentar login directo
        try {
          await _supabaseAuthService.loginUser(
            password: password,
            studentCode: username,
          );
          _logger.i('[APPLICATION] Login exitoso en Supabase.');
        } catch (e) {
          // Login falló - actualizar contraseña e intentar de nuevo
          _logger.w(
            '[APPLICATION] Actualizando contraseña y reintentando login.',
          );
          await _supabaseAuthService.updateUserPassword(
            newPassword: password,
            studentCode: username,
          );
          await _supabaseAuthService.loginUser(
            password: password,
            studentCode: username,
          );
          _logger.i('[APPLICATION] Contraseña actualizada y login exitoso.');
        }
      } else {
        // Usuario no existe - registrar y hacer login
        _logger.i('[APPLICATION] Registrando nuevo usuario.');
        await _supabaseAuthService.registerUser(
          password: password,
          studentCode: username,
        );
        await _supabaseAuthService.loginUser(
          password: password,
          studentCode: username,
        );
        _logger.i('[APPLICATION] Usuario registrado y login exitoso.');
      }
    } catch (e, s) {
      _logger.e(
        '[APPLICATION] Error en autenticación Supabase: $username',
        error: e,
        stackTrace: s,
      );
      rethrow;
    }
  }
}
