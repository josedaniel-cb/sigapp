import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sigapp/app/router.dart';
import 'package:sigapp/auth/auth_repository.dart';

@singleton
class AuthService {
  final AuthRepository _authRepository;
  final SharedPreferences _prefs;
  final RouterRefreshListenable _routerRefreshListenable;

  AuthService(this._authRepository, this._prefs, this._routerRefreshListenable);

  Future<void> init() async {
    if (isAuthenticated) {
      // Get auth cookie silently
      await _authRepository.login(getUsername()!, getPassword()!);
    }

    Timer.periodic(const Duration(seconds: 45), (timer) async {
      final response = await _authRepository.keepSession();
      if (response.statusCode != 200 && isAuthenticated) {
        _authRepository.login(getUsername()!, getPassword()!);
      }
    });
  }

  get isAuthenticated {
    return _prefs.containsKey('username') && _prefs.containsKey('password');
  }

  Future<bool> login(String username, String password) async {
    final response = await _authRepository.login(username, password);

    // Success
    if (response.statusCode == 302) {
      _saveCredentials(username, password);
      return true;
    }

    // Failure
    if (response.statusCode == 200) {
      return false;
    }

    // Error
    throw Exception('Status code ${response.statusCode}');
  }

  void logout() {
    // _prefs.remove('username');
    _prefs.remove('password');
    // _sigaClient.logout();
    _routerRefreshListenable.refresh();
  }

  String? getUsername() {
    return _prefs.getString('username');
  }

  String? getPassword() {
    return _prefs.getString('password');
  }

  void _saveCredentials(String username, String password) {
    _prefs.setString('username', username);
    _prefs.setString('password', password);

    // Set a timer to POST /keep-session every minute until the user logs out
  }
}
