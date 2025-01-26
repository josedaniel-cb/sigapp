// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';
import 'package:sigapp/app/get_it.dart';
// import 'package:sigapp/app/siga_webview_client.dart';
import 'package:sigapp/auth/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  // if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
  //   await InAppWebViewController.setWebContentsDebuggingEnabled(kDebugMode);
  // }

  await getIt<AuthService>().init();

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
