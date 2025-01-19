import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:injectable/injectable.dart';

@singleton
class SigaWebViewClient {
  HeadlessInAppWebView? _headlessWebView;
  final _completer = Completer<HeadlessInAppWebView>();

  Future<HeadlessInAppWebView> retrieve() async {
    if (_headlessWebView != null) {
      if (_completer.isCompleted) {
        return _headlessWebView!;
      }
      return await _waitForWebViewInitialization();
    }
    _headlessWebView = HeadlessInAppWebView(
      initialUrlRequest:
          URLRequest(url: WebUri("https://academico.unp.edu.pe/")),
      initialSettings: InAppWebViewSettings(isInspectable: kDebugMode),
      onWebViewCreated: (_) {
        _completer.complete(_headlessWebView);
      },
    );
    _headlessWebView!.run();
    return await _waitForWebViewInitialization();
  }

  Future<HeadlessInAppWebView> _waitForWebViewInitialization() async {
    await _completer.future;
    return _headlessWebView!;
  }
}
