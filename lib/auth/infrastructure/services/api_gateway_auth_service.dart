import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:sigapp/auth/application/services/api_gateway_auth_service.dart';
import 'package:sigapp/core/infrastructure/http/api_gateway_client.dart';

// TODO: move exceptions to a separate file
class UserAlreadyExistsException implements Exception {
  final String message;
  UserAlreadyExistsException(this.message);
  @override
  String toString() => message;
}

// TODO: move exceptions to a separate file
class InvalidCredentialsException implements Exception {
  final String message;
  InvalidCredentialsException(this.message);
  @override
  String toString() => message;
}

@LazySingleton(as: ApiGatewayAuthService)
class ApiGatewayAuthServiceImpl implements ApiGatewayAuthService {
  final ApiGatewayClient _client;
  final Logger _logger;

  ApiGatewayAuthServiceImpl(this._client, this._logger);

  @override
  Future<void> registerUser({
    required String password,
    required String studentCode,
  }) async {
    try {
      final response = await _client.http.post(
        '/auth/v1/signup',
        data: {
          'email': _buildAuthEmail(studentCode),
          'password': password,
          'data': {'student_code': studentCode},
        },
      );

      if (response.statusCode == 200 && response.data['user'] != null) {
        _logger.i('[INFRASTRUCTURE] Usuario registrado: $studentCode');
        return;
      }

      throw Exception('Error al registrar usuario');
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode ?? 0;
      final data = e.response?.data;

      _logger.e('[INFRASTRUCTURE] Error registro: $studentCode - $statusCode');

      // Solo manejar los casos críticos
      if (statusCode == 400 && data is Map) {
        final msg = data['msg']?.toString() ?? '';
        if (msg.toLowerCase().contains('already')) {
          throw UserAlreadyExistsException('Usuario ya existe en Supabase');
        }
      }

      throw Exception('Error al registrar: ${e.message}');
    }
  }

  @override
  Future<void> loginUser({
    required String password,
    required String studentCode,
  }) async {
    try {
      final response = await _client.http.post(
        '/auth/v1/token?grant_type=password',
        data: {'email': _buildAuthEmail(studentCode), 'password': password},
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final accessToken = data['access_token'];
        final refreshToken = data['refresh_token'];
        final userId = data['user']?['id'];

        if (accessToken != null && userId != null) {
          await _client.setAccessToken(accessToken);
          if (refreshToken != null) {
            await _client.setRefreshToken(refreshToken);
          }
          _logger.i('[INFRASTRUCTURE] Login exitoso: $studentCode');
          return;
        }
      }

      throw Exception('Respuesta de login inválida');
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode ?? 0;
      final data = e.response?.data;

      _logger.e('[INFRASTRUCTURE] Error login: $studentCode - $statusCode');

      // Solo manejar credenciales inválidas
      if (statusCode == 400 &&
          data is Map &&
          data['error'] == 'invalid_grant') {
        throw InvalidCredentialsException('Credenciales incorrectas');
      }

      throw Exception('Error en login: ${e.message}');
    }
  }

  @override
  Future<bool> userExists({required String studentCode}) async {
    try {
      final response = await _client.http.post(
        '/tools/verify-user-exists',
        data: {'academicUsername': studentCode},
      );

      return response.data['exists'] ?? false;
    } catch (e) {
      _logger.e('[INFRASTRUCTURE] Error verificando usuario: $studentCode');
      return false; // Asumir que no existe si hay error
    }
  }

  @override
  Future<void> updateUserPassword({
    required String newPassword,
    required String studentCode,
  }) async {
    try {
      final response = await _client.http.post(
        '/tools/password-reset',
        data: {
          'academicUsername': studentCode,
          'academicPassword': newPassword,
        },
      );

      if (response.statusCode == 200) {
        _logger.i('[INFRASTRUCTURE] Contraseña actualizada: $studentCode');
        return;
      }

      throw Exception('Error al actualizar contraseña');
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode ?? 0;

      _logger.e(
        '[INFRASTRUCTURE] Error actualizando contraseña: $studentCode - $statusCode',
      );

      if (statusCode == 401) {
        throw InvalidCredentialsException(
          'Credenciales académicas incorrectas',
        );
      }

      throw Exception('Error actualizando contraseña: ${e.message}');
    }
  }

  @override
  Future<void> logoutUser() async {
    try {
      await _client.clearTokens();
    } catch (e) {
      _logger.e('[INFRASTRUCTURE] Error en logout');
      throw Exception('Error en logout: $e');
    }
  }

  String _buildAuthEmail(String studentCode) => '$studentCode@sigapp.dev';
}
