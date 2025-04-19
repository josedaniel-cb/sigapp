abstract class ApiGatewayAuthService {
  Future<void> registerUser({
    required String password,
    required String studentCode,
  });
  Future<void> loginUser({
    required String password,
    required String studentCode,
  });
  Future<void> logoutUser();
}
