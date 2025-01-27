import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sigapp/auth/domain/repositories/shared_preferences_auth_repository.dart';

@Singleton(as: SharedPreferencesAuthRepository)
class SharedPreferencesAuthRepositoryImpl
    implements SharedPreferencesAuthRepository {
  final SharedPreferences _sharedPreferences;

  SharedPreferencesAuthRepositoryImpl(this._sharedPreferences);

  @override
  Future<void> saveCredentials(String user, String password) async {
    await _sharedPreferences.setString('username', user);
    await _sharedPreferences.setString('password', password);
  }

  @override
  String? getUsername() {
    return _sharedPreferences.getString('username');
  }

  @override
  String? getPassword() {
    return _sharedPreferences.getString('password');
  }

  @override
  Future<void> removePassword() {
    return _sharedPreferences.remove('password');
  }
}
