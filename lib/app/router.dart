import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sigapp/app/get_it.dart';
import 'package:sigapp/auth/ui/login_cubit.dart';
import 'package:sigapp/auth/ui/login_page.dart';
import 'package:sigapp/home/home_page.dart';

class RouterBuilder {
  static GoRouter build(
    SharedPreferences prefs,
  ) {
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => HomePage(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: LoginPage(),
          ),
        ),
      ],
      redirect: (context, state) {
        if (prefs.getString('token') == null) {
          return '/login';
        }
        return null;
      },
      errorPageBuilder: (context, state) => const MaterialPage(
        child: Scaffold(
          body: Center(
            child: Text('Page not found'),
          ),
        ),
      ),
    );
    return router;
  }
}
