abstract class SharedPreferencesAuthRepository {
  Future<void> saveCredentials(String user, String password);
  String? getUsername();
  String? getPassword();
  Future<void> removePassword();
}
