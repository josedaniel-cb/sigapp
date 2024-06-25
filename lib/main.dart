import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sigapp/app/get_it.dart';
import 'package:sigapp/auth/auth_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  await getIt<AuthRepository>().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: getIt<GoRouter>(),
    );
  }
}
