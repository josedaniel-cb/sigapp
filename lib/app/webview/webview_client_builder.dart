import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class HeadlessInAppWebViewBuilder {
  URLRequest? _initialUrlRequest;
  InAppWebViewSettings? _initialSettings;
  void Function(InAppWebViewController)? _onWebViewCreated;
  void Function(InAppWebViewController, ConsoleMessage)? _onConsoleMessage;
  void Function(InAppWebViewController, Uri?)? _onLoadStart;
  void Function(InAppWebViewController, Uri?)? _onLoadStop;
  void Function(InAppWebViewController, WebResourceRequest, WebResourceError)?
      _onReceivedError;

  HeadlessInAppWebViewBuilder setInitialUrlRequest(
      URLRequest initialUrlRequest) {
    _initialUrlRequest = initialUrlRequest;
    return this;
  }

  HeadlessInAppWebViewBuilder setInitialSettings(
      InAppWebViewSettings initialSettings) {
    _initialSettings = initialSettings;
    return this;
  }

  HeadlessInAppWebViewBuilder setOnWebViewCreated(
      void Function(InAppWebViewController) onWebViewCreated) {
    _onWebViewCreated = onWebViewCreated;
    return this;
  }

  HeadlessInAppWebViewBuilder setOnConsoleMessage(
      void Function(InAppWebViewController, ConsoleMessage) onConsoleMessage) {
    _onConsoleMessage = onConsoleMessage;
    return this;
  }

  HeadlessInAppWebViewBuilder setOnLoadStart(
      void Function(InAppWebViewController, Uri?) onLoadStart) {
    _onLoadStart = onLoadStart;
    return this;
  }

  HeadlessInAppWebViewBuilder setOnLoadStop(
      void Function(InAppWebViewController, Uri?) onLoadStop) {
    _onLoadStop = onLoadStop;
    return this;
  }

  HeadlessInAppWebViewBuilder setOnReceivedError(
      void Function(
              InAppWebViewController, WebResourceRequest, WebResourceError)
          onReceivedError) {
    _onReceivedError = onReceivedError;
    return this;
  }

  HeadlessInAppWebView build() {
    return HeadlessInAppWebView(
      initialUrlRequest: _initialUrlRequest,
      initialSettings: _initialSettings,
      onWebViewCreated: _onWebViewCreated,
      onConsoleMessage: _onConsoleMessage,
      onLoadStart: _onLoadStart,
      onLoadStop: _onLoadStop,
      onReceivedError: _onReceivedError,
    );
  }
}
