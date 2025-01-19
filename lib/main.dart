import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';
import 'package:sigapp/app/get_it.dart';
import 'package:sigapp/app/siga_webview_client.dart';
import 'package:sigapp/auth/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
    await InAppWebViewController.setWebContentsDebuggingEnabled(kDebugMode);
  }

  await getIt<AuthService>().init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  HeadlessInAppWebView? headlessWebView;
  // InAppWebViewController? webViewController;
  bool isWebViewVisible = false;

  @override
  void initState() {
    super.initState();
    getIt<SigaWebViewClient>().retrieve().then(
      (value) {
        setState(() {
          headlessWebView = value;
        });
      },
    );
  }

  @override
  void dispose() {
    headlessWebView?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: getIt<GoRouter>(),
      builder: (context, child) {
        if (!kDebugMode) {
          return child!;
        }
        return Stack(
          children: [
            child!,
            if (isWebViewVisible)
              Positioned.fill(
                child: Stack(
                  children: [
                    InAppWebView(
                      headlessWebView: headlessWebView,
                    ),
                  ],
                ),
              ),
            if (!isWebViewVisible && headlessWebView != null)
              Positioned(
                bottom: 16,
                right: 16,
                child: FloatingActionButton(
                  onPressed: () => setState(() => isWebViewVisible = true),
                  child: Icon(Icons.web),
                ),
              ),
          ],
        );
      },
    );
  }
}
