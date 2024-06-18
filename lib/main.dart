import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sigapp/app/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  runApp(MaterialApp.router(
    routerConfig: getIt<GoRouter>(),
  ));
}
