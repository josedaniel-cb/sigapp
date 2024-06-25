import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sigapp/app/router.dart';
import 'package:sigapp/app/siga_client.dart';
import 'package:sigapp/auth/auth_service.dart';

@module
abstract class RegisterModule {
  @preResolve
  @singleton
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @singleton
  GoRouter router(
    SigaClient sigaClient,
    AuthService authRepository,
    RouterRefreshListenable refreshListenable,
  ) =>
      RouterBuilder.build(sigaClient, authRepository, refreshListenable);
}
