import 'package:flutter/material.dart';
import 'package:sigapp/core/ui/app.dart';
import 'package:sigapp/core/injection/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  // if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
  //   await InAppWebViewController.setWebContentsDebuggingEnabled(kDebugMode);
  // }

  runApp(const MyApp());
}
