import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewClient {
  final HeadlessInAppWebView _headlessWebView;

  WebViewClient._(this._headlessWebView);

  factory WebViewClient({
    required URLRequest initialUrlRequest,
    InAppWebViewSettings? initialSettings,
    void Function(InAppWebViewController)? onWebViewCreated,
    void Function(InAppWebViewController, ConsoleMessage)? onConsoleMessage,
    void Function(InAppWebViewController, Uri?)? onLoadStart,
    void Function(InAppWebViewController, Uri?)? onLoadStop,
    void Function(InAppWebViewController, WebResourceRequest, WebResourceError)?
        onReceivedError,
  }) {
    final headlessWebView = HeadlessInAppWebView(
      initialUrlRequest: initialUrlRequest,
      initialSettings: initialSettings,
      onWebViewCreated: onWebViewCreated,
      onConsoleMessage: onConsoleMessage,
      onLoadStart: onLoadStart,
      onLoadStop: onLoadStop,
      onReceivedError: onReceivedError,
    );
    headlessWebView.run();

    return WebViewClient._(headlessWebView);
  }

  Future<void> dispose() async {
    await _headlessWebView.dispose();
  }

  get headlessWebView => _headlessWebView;

  void post() async {
    if (_headlessWebView.webViewController == null) {
      throw Exception('WebView not created yet');
    }
    await _headlessWebView.webViewController!.loadUrl(
      urlRequest: URLRequest(),
    );
  }
}

// Usage example
// void main() async {
//   final client = HeadlessWebViewClient(
//     initialUrlRequest: URLRequest(
//       url: WebUri("https://academico.unp.edu.pe/"),
//       method: 'POST',
//       headers: {
//         'accept':
//             'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8',
//         'accept-language': 'en-PE,en;q=0.9',
//         'content-type': 'application/x-www-form-urlencoded',
//         'cookie': 'ASP.NET_SessionId=mvu2tjedteu3gk3sezdr3o22',
//         'referer': 'https://academico.unp.edu.pe/',
//         'user-agent':
//             'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36',
//       },
//       body: Uint8List.fromList(utf8.encode(
//           'Instancia=01&CodAlumno=0512017039&ClaveWeb=fanatico&g-recaptcha-response=')),
//     ),
//     onWebViewCreated: (controller) {
//       print('😃 HeadlessInAppWebView created!');
//     },
//     onConsoleMessage: (controller, consoleMessage) {
//       print('😃 Console Message: ${consoleMessage.message}');
//     },
//     onLoadStart: (controller, url) async {
//       print('😃 onLoadStart $url');
//     },
//     onLoadStop: (controller, url) async {
//       print('😃 onLoadStop $url');
//     },
//     onReceivedError: (controller, request, error) {
//       print('😃 onReceivedError: $error');
//     },
//   );

//   await client.run();
// }
