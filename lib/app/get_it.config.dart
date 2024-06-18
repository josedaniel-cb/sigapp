// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:go_router/go_router.dart' as _i4;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i3;
import 'package:sigapp/app/http.dart' as _i5;
import 'package:sigapp/app/register_module.dart' as _i10;
import 'package:sigapp/auth/auth_service.dart' as _i8;
import 'package:sigapp/auth/ui/login_cubit.dart' as _i9;
import 'package:sigapp/student/student_service.dart' as _i7;

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
    await gh.singletonAsync<_i3.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.singleton<_i4.GoRouter>(
        () => registerModule.router(gh<_i3.SharedPreferences>()));
    gh.singleton<_i5.DioClientBuilder>(
        () => _i5.DioClientBuilder(gh<_i3.SharedPreferences>()));
    gh.singleton<_i6.Dio>(
        () => registerModule.http(gh<_i5.DioClientBuilder>()));
    gh.lazySingleton<_i7.StudentService>(
        () => _i7.StudentService(gh<_i6.Dio>()));
    gh.lazySingleton<_i8.AuthService>(() => _i8.AuthService(
          gh<_i6.Dio>(),
          gh<_i7.StudentService>(),
          gh<_i3.SharedPreferences>(),
        ));
    gh.factory<_i9.LoginCubit>(() => _i9.LoginCubit(gh<_i8.AuthService>()));
    return this;
  }
}

class _$RegisterModule extends _i10.RegisterModule {}
