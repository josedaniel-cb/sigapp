// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:go_router/go_router.dart' as _i13;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i4;
import 'package:sigapp/app/register_module.dart' as _i14;
import 'package:sigapp/app/siga_client.dart' as _i5;
import 'package:sigapp/auth/auth_repository.dart' as _i6;
import 'package:sigapp/auth/auth_service.dart' as _i9;
import 'package:sigapp/auth/ui/login_cubit.dart' as _i10;
import 'package:sigapp/home/home_cubit.dart' as _i12;
import 'package:sigapp/schedule/partials/export_to_calendar_cubit.dart' as _i3;
import 'package:sigapp/schedule/schedule_cubit.dart' as _i11;
import 'package:sigapp/student/student_repository.dart' as _i7;
import 'package:sigapp/student/student_service.dart' as _i8;

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
    gh.factory<_i3.ExportToCalendarCubit>(() => _i3.ExportToCalendarCubit());
    await gh.singletonAsync<_i4.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.singleton<_i5.SigaClient>(
        () => _i5.SigaClient(gh<_i4.SharedPreferences>()));
    gh.singleton<_i6.AuthRepository>(
        () => _i6.AuthRepository(gh<_i5.SigaClient>()));
    gh.lazySingleton<_i7.StudentRepository>(
        () => _i7.StudentRepository(gh<_i5.SigaClient>()));
    gh.lazySingleton<_i8.StudentService>(
        () => _i8.StudentService(gh<_i7.StudentRepository>()));
    gh.singleton<_i9.AuthService>(() => _i9.AuthService(
          gh<_i6.AuthRepository>(),
          gh<_i5.SigaClient>(),
        ));
    gh.factory<_i10.LoginCubit>(() => _i10.LoginCubit(gh<_i9.AuthService>()));
    gh.factory<_i11.ScheduleCubit>(
        () => _i11.ScheduleCubit(gh<_i8.StudentService>()));
    gh.factory<_i12.HomeCubit>(() => _i12.HomeCubit(
          gh<_i8.StudentService>(),
          gh<_i9.AuthService>(),
        ));
    gh.singleton<_i13.GoRouter>(() => registerModule.router(
          gh<_i5.SigaClient>(),
          gh<_i9.AuthService>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i14.RegisterModule {}
