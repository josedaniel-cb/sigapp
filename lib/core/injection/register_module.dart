import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sigapp/core/infrastructure/http/api_gateway_client.dart';
import 'package:sigapp/core/infrastructure/ui/router.dart';
import 'package:sigapp/auth/application/usecases/get_stored_credentials_usecase.dart';

@module
abstract class RegisterModule {
  @preResolve
  @singleton
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @singleton
  GoRouter router(
    GetStoredCredentialsUseCase getStoredCredentialsUseCase,
  ) =>
      RouterBuilder.build(getStoredCredentialsUseCase);
}
