/* import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

class SearchHistoryFetcher {
  Future<List<String>> fetch(BuildContext context) async {
    final completer = Completer<List<String>>();

    final webView = WebView(
      initialUrl: 'about:blank',
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
    final subscription =
        webView.navigationDelegate.onPageFinished.listen((_) async {
      final webViewController = await controller.future;
      final response = await webViewController.runJavaScript('''
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
    });

    final url =
        'data:text/html;base64,${base64Encode(Utf8Encoder().convert(_html))}';
    await webView.loadUrl(url);
    controller.complete(webView.controller);

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Grant permission'),
          content: Text(
              'Grant permission for the app to access your search history.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        );
      },
    );

    subscription.cancel();
    return completer.future;
  }

  final _html = '''
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
 */