import 'dart:async';

import 'package:flutter/material.dart';
import 'package:newsapp/ui/widgets/app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OriginalArticleScreen extends StatefulWidget {
  final String articleUrl;

  const OriginalArticleScreen({Key key, @required this.articleUrl}) : super(key: key);
  @override
  _OriginalArticleScreenState createState() => _OriginalArticleScreenState();
}

class _OriginalArticleScreenState extends State<OriginalArticleScreen> {
  final Completer<WebViewController> _completer = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: specificAppBar(),
      body: Container(
        child: WebView(
          initialUrl: widget.articleUrl,
          onWebViewCreated: ((WebViewController webViewController) {
            _completer.complete(webViewController);
          }),
        ),
      ),
    );
  }
}
