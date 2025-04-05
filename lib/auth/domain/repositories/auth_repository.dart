import 'package:sigapp/auth/domain/value-objects/api_response.dart';

abstract class AuthRepository {
  Future<ApiResponse> login(String username, String password);
  Future<ApiResponse> keepSession();
  Future<void> disposeCookies();
  Future<ApiResponse> checkSurvey1();
  Future<ApiResponse> checkSurvey2();
}
