import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sigapp/core/injection/get_it.dart';
import 'package:sigapp/core/ui/theme/brand_theme.dart';
import 'package:toastification/toastification.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp.router(
        routerConfig: getIt<GoRouter>(),
        theme: ThemeData(
          primaryColor: Color(BrandTheme.primaryColor),
        ),
      ),
    );
  }
}
