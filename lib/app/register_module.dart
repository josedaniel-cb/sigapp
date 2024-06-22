import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sigapp/app/router.dart';
import 'package:sigapp/app/siga_http.dart';

@module
abstract class RegisterModule {
  @preResolve
  @singleton
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @singleton
  GoRouter router(
    SigaHttpController sigaHttpController,
    RouterRefreshListenable refreshListenable,
  ) =>
      RouterBuilder.build(sigaHttpController, refreshListenable);
}
