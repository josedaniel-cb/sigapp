import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';
import 'package:sigapp/app/get_it.dart';
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
  InAppWebViewController? webViewController;
  bool isWebViewVisible = false;

  @override
  void initState() {
    super.initState();

    headlessWebView = HeadlessInAppWebView(
      initialUrlRequest: URLRequest(
        url: WebUri("https://academico.unp.edu.pe/"),
        method: 'POST',
        headers: {
          // 'accept':
          //     'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8',
          // 'accept-language': 'en-PE,en;q=0.9',
          'content-type': 'application/x-www-form-urlencoded',
          // 'cookie': 'ASP.NET_SessionId=mvu2tjedteu3gk3sezdr3o22',
          // 'referer': 'https://academico.unp.edu.pe/',
          // 'user-agent':
          //     'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36',
        },
        body: Uint8List.fromList(utf8.encode(
            'Instancia=01&CodAlumno=0512017039&ClaveWeb=fanatico&g-recaptcha-response=')),
      ),
      initialSettings: InAppWebViewSettings(isInspectable: kDebugMode),
      onWebViewCreated: (controller) {
        print('😃 HeadlessInAppWebView created!');
      },
      onConsoleMessage: (controller, consoleMessage) {
        print('😃 Console Message: ${consoleMessage.message}');
      },
      onLoadStart: (controller, url) async {
        print('😃 onLoadStart $url');
      },
      onLoadStop: (controller, url) async {
        print('😃 onLoadStop $url');
      },
    );
    headlessWebView?.run();
  }

  @override
  void dispose() {
    headlessWebView?.dispose();
    super.dispose();
  }

  void toggleWebView() {
    setState(() {
      isWebViewVisible = !isWebViewVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: getIt<GoRouter>(),
      builder: (context, child) {
        return Stack(
          children: [
            child!,
            if (isWebViewVisible)
              Positioned.fill(
                child: InAppWebView(
                  headlessWebView: headlessWebView,
                  onWebViewCreated: (controller) {
                    webViewController = controller;
                    headlessWebView =
                        null; // Dispose automatically when converted
                  },
                  onLoadStart: (controller, url) {
                    print('😃 WebView Load Start: $url');
                  },
                  onLoadStop: (controller, url) {
                    print('😃 WebView Load Stop: $url');
                  },
                ),
              ),
            if (kDebugMode)
              Positioned(
                bottom: 16,
                right: 16,
                child: FloatingActionButton(
                  onPressed: toggleWebView,
                  child: Icon(isWebViewVisible ? Icons.close : Icons.web),
                ),
              ),
          ],
        );
      },
    );
  }
}
