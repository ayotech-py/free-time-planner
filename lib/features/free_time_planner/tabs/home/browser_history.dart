import 'dart:async';
import 'dart:convert';
import 'package:webview_flutter/webview_flutter.dart';

class SearchHistoryFetcher {
  Future<List<String>> fetch() async {
    final completer = Completer<List<String>>();

    final webView = WebView(
      initialUrl: 'assets/search_history.html',
      javascriptMode: JavascriptMode.unrestricted,
      javascriptChannels: <JavascriptChannel>[
        JavascriptChannel(
          name: 'SearchHistoryChannel',
          onMessageReceived: (message) {
            final keywords = List<String>.from(jsonDecode(message.message));
            completer.complete(keywords);
          },
        ),
      ].toSet(),
    );

    final controller = Completer<WebViewController>();
    final subscription = webView.onWebViewCreated.listen((webViewController) {
      controller.complete(webViewController);
    });

    final url =
        'data:text/html;base64,${base64Encode(Utf8Encoder().convert(_html))}';
    await webView.loadUrlRequest(
      NavigationRequest(
        url: url,
        headers: {
          'Content-Type': 'text/html',
        },
      ),
    );

    final webViewController = await controller.future;
    final response = await webViewController.evaluateJavascript(
        '''
      chrome.history.search({text: '', maxResults: 1000}, function(results) {
        var keywords = [];
        for (var i = 0; i < results.length; i++) {
          if (results[i].title != null) {
            keywords.push(results[i].title);
          }
        }
        window.SearchHistoryChannel.postMessage(JSON.stringify(keywords));
      });
    ''');

    subscription.cancel();
    return completer.future;
  }

  final _html =
      '''
    <!DOCTYPE html>
    <html>
    <head>
      <meta charset="utf-8">
      <script>
        window.onload = function() {
          window.SearchHistoryChannel.postMessage('ready');
        };
      </script>
    </head>
    <body>
    </body>
    </html>
  ''';
}
