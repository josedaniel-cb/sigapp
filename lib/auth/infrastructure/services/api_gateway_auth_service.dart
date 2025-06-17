import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:sigapp/auth/application/services/api_gateway_auth_service.dart';
import 'package:sigapp/core/infrastructure/http/api_gateway_client.dart';

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

      final responseData = response.data;
      if (responseData['user'] == null) {
        throw Exception('Error al registrar: No se pudo crear el usuario');
      }

      // Después de registrar, iniciamos sesión automáticamente
      await loginUser(password: password, studentCode: studentCode);
    } catch (e, s) {
      _logger.e(
        '[INFRASTRUCTURE] Error registering with Supabase',
        error: e,
        stackTrace: s,
      );
      throw Exception('Error on sign up: $e');
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

      final responseData = response.data;
      final accessToken = responseData['access_token'];
      final refreshToken = responseData['refresh_token'];
      final userId = responseData['user']?['id'];

      if (accessToken == null || userId == null) {
        throw Exception(
          'Error al iniciar sesión: Token o ID de usuario no encontrados',
        );
      }

      // Guardar tokens en almacenamiento seguro
      await _client.setAccessToken(accessToken);
      if (refreshToken != null) {
        await _client.setRefreshToken(refreshToken);
      }
    } catch (e, s) {
      _logger.e(
        '[INFRASTRUCTURE] Error logging in with Supabase',
        error: e,
        stackTrace: s,
      );
      throw Exception('Error on login: $e');
    }
  }

  @override
  Future<void> logoutUser() async {
    try {
      // Limpiar datos del almacenamiento seguro
      await _client.clearTokens();
    } catch (e, s) {
      _logger.e(
        '[INFRASTRUCTURE] Error logging out with Supabase',
        error: e,
        stackTrace: s,
      );
      throw Exception('Error on logout: $e');
    }
  }

  String _buildAuthEmail(String studentCode) => '$studentCode@sigapp.com';
}
