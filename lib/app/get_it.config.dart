// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i3;
import 'package:sigapp/app/http.dart' as _i4;
import 'package:sigapp/app/register_module.dart' as _i8;
import 'package:sigapp/auth/auth_service.dart' as _i7;
import 'package:sigapp/student/student_service.dart' as _i6;

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
    gh.singleton<_i4.DioClientBuilder>(
        () => _i4.DioClientBuilder(gh<_i3.SharedPreferences>()));
    gh.singleton<_i5.Dio>(
        () => registerModule.http(gh<_i4.DioClientBuilder>()));
    gh.lazySingleton<_i6.StudentService>(
        () => _i6.StudentService(gh<_i5.Dio>()));
    gh.lazySingleton<_i7.AuthService>(() => _i7.AuthService(
          gh<_i5.Dio>(),
          gh<_i6.StudentService>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i8.RegisterModule {}
