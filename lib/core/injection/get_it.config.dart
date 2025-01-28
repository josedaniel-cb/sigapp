// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:go_router/go_router.dart' as _i583;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:sigapp/auth/application/managers/authentication_manager.dart'
    as _i767;
import 'package:sigapp/auth/application/usecases.dart' as _i447;
import 'package:sigapp/auth/application/usecases/get_stored_credentials_usecase.dart'
    as _i193;
import 'package:sigapp/auth/application/usecases/keep_session_alive_usecase.dart'
    as _i908;
import 'package:sigapp/auth/application/usecases/sign_in_usecase.dart' as _i365;
import 'package:sigapp/auth/application/usecases/sign_out_usecase.dart' as _i48;
import 'package:sigapp/auth/domain/repositories/auth_repository.dart' as _i10;
import 'package:sigapp/auth/domain/repositories/shared_preferences_auth_repository.dart'
    as _i1010;
import 'package:sigapp/auth/domain/services/navigation_service.dart' as _i528;
import 'package:sigapp/auth/domain/services/session_lifecycle_service.dart'
    as _i679;
import 'package:sigapp/auth/infrastructure/pages/login_cubit.dart' as _i41;
import 'package:sigapp/auth/infrastructure/repositories/auth_repository.dart'
    as _i127;
import 'package:sigapp/auth/infrastructure/repositories/shared_preferences_auth_repository.dart'
    as _i247;
import 'package:sigapp/auth/infrastructure/services/navigation_service.dart'
    as _i561;
import 'package:sigapp/auth/infrastructure/services/session_lifecycle_service.dart'
    as _i649;
import 'package:sigapp/core/http/siga_client.dart' as _i476;
import 'package:sigapp/core/injection/register_module.dart' as _i799;
import 'package:sigapp/home/home_cubit.dart' as _i486;
import 'package:sigapp/schedule/partials/export_to_calendar_cubit.dart'
    as _i633;
import 'package:sigapp/schedule/schedule_cubit.dart' as _i953;
import 'package:sigapp/student/application/student_usecases_aux.dart' as _i546;
import 'package:sigapp/student/infrastructure/repositories/student_repository.dart'
    as _i528;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    await gh.singletonAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.singleton<_i476.SigaClient>(
        () => _i476.SigaClient(gh<_i460.SharedPreferences>()));
    gh.singleton<_i679.SessionLifecycleService>(
        () => _i649.SessionLifecycleServiceImpl(gh<_i476.SigaClient>()));
    gh.singleton<_i1010.SharedPreferencesAuthRepository>(() =>
        _i247.SharedPreferencesAuthRepositoryImpl(
            gh<_i460.SharedPreferences>()));
    gh.lazySingleton<_i528.StudentRepository>(
        () => _i528.StudentRepository(gh<_i476.SigaClient>()));
    gh.factory<_i193.GetStoredCredentialsUseCase>(() =>
        _i193.GetStoredCredentialsUseCase(
            gh<_i1010.SharedPreferencesAuthRepository>()));
    gh.singleton<_i10.AuthRepository>(
        () => _i127.AuthRepositoryImpl(gh<_i476.SigaClient>()));
    gh.lazySingleton<_i546.StudentUsecasesAux>(
        () => _i546.StudentUsecasesAux(gh<_i528.StudentRepository>()));
    gh.factory<_i633.ExportToCalendarCubit>(
        () => _i633.ExportToCalendarCubit(gh<_i546.StudentUsecasesAux>()));
    gh.factory<_i953.ScheduleCubit>(
        () => _i953.ScheduleCubit(gh<_i546.StudentUsecasesAux>()));
    gh.singleton<_i583.GoRouter>(
        () => registerModule.router(gh<_i193.GetStoredCredentialsUseCase>()));
    gh.factory<_i908.KeepSessionAliveUsecase>(
        () => _i908.KeepSessionAliveUsecase(gh<_i10.AuthRepository>()));
    gh.singleton<_i528.NavigationService>(
        () => _i561.NavigationServiceImpl(gh<_i583.GoRouter>()));
    gh.factory<_i48.SignOutUseCase>(() => _i48.SignOutUseCase(
          gh<_i1010.SharedPreferencesAuthRepository>(),
          gh<_i528.NavigationService>(),
        ));
    gh.factory<_i365.SignInUseCase>(() => _i365.SignInUseCase(
          gh<_i10.AuthRepository>(),
          gh<_i1010.SharedPreferencesAuthRepository>(),
          gh<_i528.NavigationService>(),
        ));
    gh.singleton<_i447.AuthUsecases>(() => _i447.AuthUsecases(
          gh<_i365.SignInUseCase>(),
          gh<_i193.GetStoredCredentialsUseCase>(),
          gh<_i48.SignOutUseCase>(),
          gh<_i908.KeepSessionAliveUsecase>(),
        ));
    gh.factory<_i41.LoginCubit>(
        () => _i41.LoginCubit(gh<_i447.AuthUsecases>()));
    gh.factory<_i486.HomeCubit>(() => _i486.HomeCubit(
          gh<_i546.StudentUsecasesAux>(),
          gh<_i447.AuthUsecases>(),
        ));
    gh.singleton<_i767.AuthenticationManager>(() => _i767.AuthenticationManager(
          gh<_i679.SessionLifecycleService>(),
          gh<_i447.AuthUsecases>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i799.RegisterModule {}
