import 'dart:developer' as developer;
import 'package:injectable/injectable.dart';
import 'package:sigapp/auth/application/services/api_gateway_auth_service.dart';
import 'package:sigapp/auth/domain/exceptions/session_exception.dart';
import 'package:sigapp/auth/domain/repositories/auth_repository.dart';
import 'package:sigapp/auth/domain/repositories/shared_preferences_auth_repository.dart';
import 'package:sigapp/auth/domain/services/navigation_service.dart';
import 'package:sigapp/shared/domain/service/progress_indicator_service.dart';
import 'package:sigapp/courses/domain/repositories/regeva_repository.dart';
import 'package:sigapp/student/domain/services/academic_info_service.dart';

@injectable
class SignOutUseCase {
  final SharedPreferencesAuthRepository _sharedPreferencesAuthRepository;
  final NavigationService _navigationService;
  final AuthRepository _authRepository;
  final RegevaRepository _regevaRepository;
  final ProgressIndicatorService _progressIndicatorService;
  final AcademicInfoService _sessionInfoService;
  final ApiGatewayAuthService _supabaseAuthService;

  SignOutUseCase(
      this._sharedPreferencesAuthRepository,
      this._navigationService,
      this._authRepository,
      this._regevaRepository,
      this._progressIndicatorService,
      this._sessionInfoService,
      this._supabaseAuthService);

  Future<void> execute([dynamic technicalReason]) async {
    // Registramos el motivo técnico del cierre de sesión para diagnóstico
    developer.log(
      'Ejecutando SignOutUseCase. Motivo técnico: ${technicalReason ?? "No especificado"}',
      name: 'SignOutUseCase',
    );

    await _progressIndicatorService.show();

    // Obtener el mensaje amigable y si debería tratarse como alerta de error
    final _LogoutMessageInfo messageInfo =
        _get_LogoutMessageInfo(technicalReason);

    try {
      // required for refreshing navigation
      await _sharedPreferencesAuthRepository.removePassword();

      // clear cookies :p
      await _authRepository.disposeCookies();
      await _regevaRepository.disposeCookies();
    } catch (e, s) {
      developer.log(
        'Error durante el cierre de sesión: $e',
        name: 'SignOutUseCase',
        error: e,
        stackTrace: s,
      );

      await _progressIndicatorService.hide();
      rethrow;
    }

    try {
      await _supabaseAuthService.logoutUser();
    } catch (e, s) {
      developer.log(
        'Error al cerrar sesión en Supabase: $e (continuando de todas formas)',
        name: 'SignOutUseCase',
        error: e,
        stackTrace: s,
      );
      // No relanzamos esta excepción para no interrumpir el flujo
    }

    await _progressIndicatorService.hide();

    // ui navigation con el nuevo parámetro isError
    _navigationService.refreshNavigation(
      messageInfo.userMessage,
      messageInfo.shouldDisplayAsError,
    );

    // clear
    _sessionInfoService.clearSessionInfo();
  }

  /// Convierte excepciones tipadas en mensajes amigables para el usuario
  /// y determina si deben mostrarse como errores
  _LogoutMessageInfo _get_LogoutMessageInfo(dynamic technicalReason) {
    // Si no hay razón técnica, es un cierre de sesión voluntario
    if (technicalReason == null) {
      return _LogoutMessageInfo("Has cerrado sesión", false);
    }

    // Si ya es un SessionException, usamos el patrón de coincidencia para manejar cada tipo
    if (technicalReason is SessionException) {
      return technicalReason.when(
        // Errores de red - Mostrar como error ya que no es esperado
        networkError: (message, originalError) {
          return _LogoutMessageInfo(
            "Se cerró tu sesión debido a problemas de conexión. Por favor, verifica tu conexión a internet y vuelve a intentarlo.",
            true,
          );
        },

        // Errores de refresco de sesión - No es crítico, informativo
        refreshError: (message, originalError) {
          return _LogoutMessageInfo(
            "Tu sesión ha expirado. Esto puede ocurrir por inactividad o problemas en el servidor. Por favor, inicia sesión nuevamente.",
            false,
          );
        },

        // Errores de autenticación - Puede ser crítico (seguridad)
        authenticationError: (message, originalError) {
          return _LogoutMessageInfo(
            "Se ha cerrado tu sesión por motivos de seguridad. Por favor, inicia sesión nuevamente.",
            true,
          );
        },

        // Errores de información académica - Mostrar como error
        studentInfoError: (message, originalError) {
          return _LogoutMessageInfo(
            "No se pudo verificar tu información académica. Por favor, intenta nuevamente más tarde.",
            true,
          );
        },

        // Errores de encuestas pendientes - Es un proceso normal, no un error técnico
        pendingSurveyError: (message, originalError) {
          return _LogoutMessageInfo(
            "Tienes encuestas pendientes que deben ser completadas en la versión web de SIGA. Por favor, inicia sesión en la plataforma web para completarlas.",
            false,
          );
        },

        // Errores desconocidos - Siempre mostrar como error
        unknownError: (message, originalError) {
          return _LogoutMessageInfo(
            "Se cerró tu sesión por un error desconocido. Por favor, inicia sesión nuevamente.",
            true,
          );
        },
      );
    }

    // Para mantener compatibilidad con código antiguo, manejamos también strings
    if (technicalReason is String) {
      // Errores de red
      if (technicalReason.contains('SocketException') ||
          technicalReason.contains('connection') ||
          technicalReason.contains('timeout')) {
        return _LogoutMessageInfo(
          "Se cerró tu sesión debido a problemas de conexión. Por favor, verifica tu conexión a internet y vuelve a intentarlo.",
          true,
        );
      }

      // Error de refresco de sesión
      if (technicalReason.contains('Error en múltiples intentos de refresco')) {
        return _LogoutMessageInfo(
          "Tu sesión ha expirado. Esto puede ocurrir por inactividad o problemas en el servidor. Por favor, inicia sesión nuevamente.",
          false,
        );
      }

      // Error en la verificación del estudiante
      if (technicalReason.contains('información de la sesión del estudiante')) {
        return _LogoutMessageInfo(
          "No se pudo verificar tu información académica. Por favor, intenta nuevamente más tarde.",
          true,
        );
      }

      // Error en Supabase
      if (technicalReason.contains('Supabase')) {
        return _LogoutMessageInfo(
          "Ocurrió un problema con la autenticación. Por favor, intenta nuevamente.",
          true,
        );
      }

      // Error en encuestas pendientes
      if (technicalReason.contains('Pending survey')) {
        return _LogoutMessageInfo(
          "Tienes encuestas pendientes que deben ser completadas en la versión web de SIGA. Por favor, inicia sesión en la plataforma web para completarlas.",
          false,
        );
      }
    }

    // Si el error no está tipado ni reconocido, usamos un mensaje genérico
    return _LogoutMessageInfo(
      "Se cerró tu sesión. Por favor, inicia sesión nuevamente.",
      true,
    );
  }
}

class _LogoutMessageInfo {
  final String userMessage;
  final bool shouldDisplayAsError;

  _LogoutMessageInfo(this.userMessage, this.shouldDisplayAsError);
}
