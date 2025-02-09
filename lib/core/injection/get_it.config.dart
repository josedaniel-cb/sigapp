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
import 'package:sigapp/core/http/regeva_client.dart' as _i929;
import 'package:sigapp/core/http/siga_client.dart' as _i476;
import 'package:sigapp/core/injection/register_module.dart' as _i799;
import 'package:sigapp/core/pages/home_page_cubit.dart' as _i65;
import 'package:sigapp/courses/application/usecases/get_class_schedule_usecase.dart'
    as _i315;
import 'package:sigapp/courses/application/usecases/get_default_class_schedule_usecase.dart'
    as _i562;
import 'package:sigapp/courses/application/usecases/get_enrolled_courses_usecase.dart'
    as _i650;
import 'package:sigapp/courses/application/usecases/get_syllabus_file_usecase.dart'
    as _i445;
import 'package:sigapp/courses/domain/repositories/courses_repository.dart'
    as _i986;
import 'package:sigapp/courses/domain/repositories/local_syllabus_repository.dart'
    as _i504;
import 'package:sigapp/courses/domain/repositories/regeva_repository.dart'
    as _i348;
import 'package:sigapp/courses/domain/repositories/schedule_repository.dart'
    as _i974;
import 'package:sigapp/courses/infrastructure/pages/courses/courses_page_cubit.dart'
    as _i525;
import 'package:sigapp/courses/infrastructure/pages/schedule/partials/export_to_calendar_cubit.dart'
    as _i993;
import 'package:sigapp/courses/infrastructure/pages/schedule/schedule_cubit.dart'
    as _i575;
import 'package:sigapp/courses/infrastructure/repositories/courses_repository.dart'
    as _i892;
import 'package:sigapp/courses/infrastructure/repositories/local_syllabus_repository.dart'
    as _i717;
import 'package:sigapp/courses/infrastructure/repositories/regeva_repository.dart'
    as _i75;
import 'package:sigapp/courses/infrastructure/repositories/schedule_repository.dart'
    as _i637;
import 'package:sigapp/semester/application/get_semester_context_usecase.dart'
    as _i320;
import 'package:sigapp/student/application/usecases/get_academic_report_usecase.dart'
    as _i771;
import 'package:sigapp/student/domain/repositories/student_repository.dart'
    as _i594;
import 'package:sigapp/student/infrastructure/pages/student_cubit.dart'
    as _i151;
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
    gh.singleton<_i929.RegevaClient>(
        () => _i929.RegevaClient(gh<_i460.SharedPreferences>()));
    gh.singleton<_i476.SigaClient>(
        () => _i476.SigaClient(gh<_i460.SharedPreferences>()));
    gh.singleton<_i679.SessionLifecycleService>(
        () => _i649.SessionLifecycleServiceImpl(gh<_i476.SigaClient>()));
    gh.lazySingleton<_i348.RegevaRepository>(
        () => _i75.RegevaRepositoryImpl(gh<_i929.RegevaClient>()));
    gh.singleton<_i504.LocalSyllabusRepository>(
        () => _i717.LocalSyllabusRepositoryImpl());
    gh.lazySingleton<_i986.CoursesRepository>(
        () => _i892.CoursesRepositoryImpl(gh<_i476.SigaClient>()));
    gh.lazySingleton<_i594.StudentRepository>(
        () => _i528.StudentRepositoryImpl(gh<_i476.SigaClient>()));
    gh.lazySingleton<_i974.ScheduleRepository>(
        () => _i637.ScheduleRepositoryImpl(gh<_i476.SigaClient>()));
    gh.singleton<_i1010.SharedPreferencesAuthRepository>(() =>
        _i247.SharedPreferencesAuthRepositoryImpl(
            gh<_i460.SharedPreferences>()));
    gh.singleton<_i10.AuthRepository>(
        () => _i127.AuthRepositoryImpl(gh<_i476.SigaClient>()));
    gh.lazySingleton<_i315.GetClassScheduleUsecase>(
        () => _i315.GetClassScheduleUsecase(gh<_i974.ScheduleRepository>()));
    gh.lazySingleton<_i771.GetAcademicReportUsecase>(
        () => _i771.GetAcademicReportUsecase(gh<_i594.StudentRepository>()));
    gh.factory<_i908.KeepSessionAliveUsecase>(
        () => _i908.KeepSessionAliveUsecase(gh<_i10.AuthRepository>()));
    gh.factory<_i193.GetStoredCredentialsUseCase>(() =>
        _i193.GetStoredCredentialsUseCase(
            gh<_i1010.SharedPreferencesAuthRepository>()));
    gh.lazySingleton<_i650.GetEnrolledCoursesUsecase>(
        () => _i650.GetEnrolledCoursesUsecase(gh<_i986.CoursesRepository>()));
    gh.lazySingleton<_i445.GetSyllabusFileUsecase>(
        () => _i445.GetSyllabusFileUsecase(
              gh<_i348.RegevaRepository>(),
              gh<_i986.CoursesRepository>(),
              gh<_i504.LocalSyllabusRepository>(),
            ));
    gh.lazySingleton<_i320.GetSemesterContextUsecase>(
        () => _i320.GetSemesterContextUsecase(
              gh<_i771.GetAcademicReportUsecase>(),
              gh<_i986.CoursesRepository>(),
            ));
    gh.factory<_i993.ExportToCalendarCubit>(
        () => _i993.ExportToCalendarCubit(gh<_i315.GetClassScheduleUsecase>()));
    gh.lazySingleton<_i562.GetDefaultClassScheduleUsecase>(
        () => _i562.GetDefaultClassScheduleUsecase(
              gh<_i771.GetAcademicReportUsecase>(),
              gh<_i320.GetSemesterContextUsecase>(),
              gh<_i315.GetClassScheduleUsecase>(),
            ));
    gh.factory<_i151.StudentPageViewCubit>(
        () => _i151.StudentPageViewCubit(gh<_i771.GetAcademicReportUsecase>()));
    gh.singleton<_i583.GoRouter>(
        () => registerModule.router(gh<_i193.GetStoredCredentialsUseCase>()));
    gh.factory<_i575.ScheduleCubit>(() => _i575.ScheduleCubit(
          gh<_i562.GetDefaultClassScheduleUsecase>(),
          gh<_i315.GetClassScheduleUsecase>(),
        ));
    gh.singleton<_i525.CoursesPageCubit>(() => _i525.CoursesPageCubit(
          gh<_i650.GetEnrolledCoursesUsecase>(),
          gh<_i320.GetSemesterContextUsecase>(),
          gh<_i445.GetSyllabusFileUsecase>(),
        ));
    gh.singleton<_i528.NavigationService>(
        () => _i561.NavigationServiceImpl(gh<_i583.GoRouter>()));
    gh.factory<_i365.SignInUseCase>(() => _i365.SignInUseCase(
          gh<_i10.AuthRepository>(),
          gh<_i1010.SharedPreferencesAuthRepository>(),
          gh<_i528.NavigationService>(),
        ));
    gh.factory<_i48.SignOutUseCase>(() => _i48.SignOutUseCase(
          gh<_i1010.SharedPreferencesAuthRepository>(),
          gh<_i528.NavigationService>(),
          gh<_i10.AuthRepository>(),
          gh<_i348.RegevaRepository>(),
        ));
    gh.factory<_i41.LoginCubit>(() => _i41.LoginCubit(
          gh<_i193.GetStoredCredentialsUseCase>(),
          gh<_i365.SignInUseCase>(),
        ));
    gh.singleton<_i767.AuthenticationManager>(() => _i767.AuthenticationManager(
          gh<_i679.SessionLifecycleService>(),
          gh<_i193.GetStoredCredentialsUseCase>(),
          gh<_i48.SignOutUseCase>(),
          gh<_i908.KeepSessionAliveUsecase>(),
          gh<_i365.SignInUseCase>(),
        ));
    gh.singleton<_i65.HomePageCubit>(
        () => _i65.HomePageCubit(gh<_i48.SignOutUseCase>()));
    return this;
  }
}

class _$RegisterModule extends _i799.RegisterModule {}
