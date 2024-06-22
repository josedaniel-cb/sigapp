import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sigapp/app/http.dart';
import 'package:sigapp/app/router.dart';

@module
abstract class RegisterModule {
  @preResolve
  @singleton
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @singleton
  Dio http(DioClientBuilder builder) {
    final dioClient = builder
        .setBaseUrl('https://academico.unp.edu.pe')
        // .setConnectTimeout(5000)
        // .setReceiveTimeout(3000)
        .addHeader('Content-Type', 'application/json')
        .build();
    return dioClient;
  }

  @singleton
  GoRouter router(
          SharedPreferences prefs, RouterRefreshListenable refreshListenable) =>
      RouterBuilder.build(prefs, refreshListenable);
}
