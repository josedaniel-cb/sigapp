import 'dart:async';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:sigapp/app/siga_client.dart';
import 'package:sigapp/auth/domain/repositories/auth_repository.dart';
import 'package:sigapp/auth/domain/value-objects/api_response.dart';

@Singleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final SigaClient sigaClient;

  AuthRepositoryImpl(this.sigaClient);

  @override
  Future<ApiResponse> login(String username, String password) async {
    final response = await sigaClient.http.post(
      SigaClient.signInPath,
      data: {
        'Instancia': '01',
        'CodAlumno': username,
        'ClaveWeb': password,
        'g-recaptcha-response': '',
      },
      options: Options(
        headers: {
          'content-type': 'application/x-www-form-urlencoded',
        },
        followRedirects: false,
        validateStatus: (status) {
          return true;
        },
      ),
    );
    final statusCode = response.statusCode;
    if (statusCode == null) throw Exception('Status code is null');
    return ApiResponse(statusCode: statusCode, headers: response.headers.map);
  }

  @override
  Future<ApiResponse> keepSession() async {
    final response = await sigaClient.http.post(
      SigaClient.keepSessionPath,
      options: Options(
        validateStatus: (status) => true,
      ),
    );
    final statusCode = response.statusCode;
    if (statusCode == null) throw Exception('Status code is null');
    return ApiResponse(statusCode: statusCode, headers: response.headers.map);
  }
}
