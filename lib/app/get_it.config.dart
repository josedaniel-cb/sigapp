// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:go_router/go_router.dart' as _i7;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i4;
import 'package:sigapp/app/http.dart' as _i5;
import 'package:sigapp/app/register_module.dart' as _i12;
import 'package:sigapp/app/router.dart' as _i3;
import 'package:sigapp/app/siga_http.dart' as _i6;
import 'package:sigapp/auth/auth_service.dart' as _i8;
import 'package:sigapp/auth/ui/login_cubit.dart' as _i10;
import 'package:sigapp/home/home_cubit.dart' as _i11;
import 'package:sigapp/student/student_service.dart' as _i9;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.factory<_i3.RouterRefreshListenable>(
        () => _i3.RouterRefreshListenable());
    await gh.singletonAsync<_i4.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.singleton<_i5.HttpClientBuilder>(
        () => _i5.HttpClientBuilder(gh<_i4.SharedPreferences>()));
    gh.singleton<_i6.SigaClient>(() => _i6.SigaClient(
          gh<_i5.HttpClientBuilder>(),
          gh<_i4.SharedPreferences>(),
          gh<_i3.RouterRefreshListenable>(),
        ));
    gh.singleton<_i7.GoRouter>(() => registerModule.router(
          gh<_i6.SigaClient>(),
          gh<_i3.RouterRefreshListenable>(),
        ));
    gh.lazySingleton<_i8.AuthService>(
        () => _i8.AuthService(gh<_i6.SigaClient>()));
    gh.lazySingleton<_i9.StudentService>(
        () => _i9.StudentService(gh<_i6.SigaClient>()));
    gh.factory<_i10.LoginCubit>(() => _i10.LoginCubit(gh<_i8.AuthService>()));
    gh.factory<_i11.HomeCubit>(() => _i11.HomeCubit(
          gh<_i9.StudentService>(),
          gh<_i8.AuthService>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i12.RegisterModule {}
