import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:sigapp/app/siga_client.dart';
import 'package:sigapp/auth/auth_repository.dart';

@singleton
class AuthService {
  final SigaClient _sigaClient;
  final AuthRepository _authRepository;

  AuthService(this._authRepository, this._sigaClient);

  Future<void> init() async {
    if (hasAuthCredentials) {
      // Get auth cookie silently
      await _authRepository.login(getUsername()!, getPassword()!);
    }
  }

  get hasAuthCredentials {
    return _sigaClient.hasAuthCredentials;
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
    _sigaClient.logout();
  }

  String? getUsername() {
    return _sigaClient.username;
  }

  String? getPassword() {
    return _sigaClient.password;
  }

  void _saveCredentials(String username, String password) {
    _sigaClient.saveCredentials(username, password);
  }
}
