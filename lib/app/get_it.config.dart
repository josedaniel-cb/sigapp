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
import 'package:sigapp/app/register_module.dart' as _i363;
import 'package:sigapp/app/siga_client.dart' as _i748;
import 'package:sigapp/app/siga_webview_client.dart' as _i115;
import 'package:sigapp/auth/auth_repository.dart' as _i389;
import 'package:sigapp/auth/auth_service.dart' as _i587;
import 'package:sigapp/auth/ui/login_cubit.dart' as _i1044;
import 'package:sigapp/home/home_cubit.dart' as _i486;
import 'package:sigapp/schedule/partials/export_to_calendar_cubit.dart'
    as _i633;
import 'package:sigapp/schedule/schedule_cubit.dart' as _i953;
import 'package:sigapp/student/student_repository.dart' as _i12;
import 'package:sigapp/student/student_service.dart' as _i638;

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
    gh.singleton<_i115.SigaWebViewClient>(() => _i115.SigaWebViewClient());
    gh.singleton<_i748.SigaClient>(
        () => _i748.SigaClient(gh<_i460.SharedPreferences>()));
    gh.lazySingleton<_i12.StudentRepository>(
        () => _i12.StudentRepository(gh<_i748.SigaClient>()));
    gh.lazySingleton<_i638.StudentService>(
        () => _i638.StudentService(gh<_i12.StudentRepository>()));
    gh.singleton<_i389.AuthRepository>(
        () => _i389.AuthRepository(gh<_i748.SigaClient>()));
    gh.factory<_i633.ExportToCalendarCubit>(
        () => _i633.ExportToCalendarCubit(gh<_i638.StudentService>()));
    gh.factory<_i953.ScheduleCubit>(
        () => _i953.ScheduleCubit(gh<_i638.StudentService>()));
    gh.singleton<_i587.AuthService>(() => _i587.AuthService(
          gh<_i389.AuthRepository>(),
          gh<_i748.SigaClient>(),
        ));
    gh.factory<_i1044.LoginCubit>(
        () => _i1044.LoginCubit(gh<_i587.AuthService>()));
    gh.factory<_i486.HomeCubit>(() => _i486.HomeCubit(
          gh<_i638.StudentService>(),
          gh<_i587.AuthService>(),
        ));
    gh.singleton<_i583.GoRouter>(() => registerModule.router(
          gh<_i748.SigaClient>(),
          gh<_i587.AuthService>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i363.RegisterModule {}
