abstract class AuthService {
  Future<void> init();
  bool get hasAuthCredentials;
  Future<bool> login(String username, String password);
  void logout();
  String? getUsername();
  String? getPassword();
}
