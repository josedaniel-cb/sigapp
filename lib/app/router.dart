import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:sigapp/app/get_it.dart';
import 'package:sigapp/app/siga_http.dart';
import 'package:sigapp/auth/ui/login_cubit.dart';
import 'package:sigapp/auth/ui/login_page.dart';
import 'package:sigapp/home/home_cubit.dart';
import 'package:sigapp/home/home_page.dart';

@injectable
class RouterRefreshListenable extends ChangeNotifier {
  void refresh() {
    notifyListeners();
  }
}

class RouterBuilder {
  static GoRouter build(
    // SharedPreferences prefs,
    SigaClient sigaClient,
    RouterRefreshListenable refreshListenable,
  ) {
    final router = GoRouter(
      refreshListenable: refreshListenable,
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => BlocProvider(
            create: (context) => getIt<HomeCubit>(),
            child: const HomePage(),
          ),
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
        if (!sigaClient.isAuthenticated) {
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
