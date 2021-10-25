import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyScreen extends StatefulHookWidget {
  static const String id = 'privacy';

  @override
  _PrivacyScreenState createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  num indexPosition = 1;

  final key = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        foregroundColor: Colors.black87,
        backgroundColor: Colors.white,
      ),
      body: IndexedStack(index: indexPosition, children: [
        WebView(
          key: key,
          initialUrl: "http://13.52.150.132/privacyPolicy",
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          javascriptMode: JavascriptMode.unrestricted,
          gestureNavigationEnabled: true,
          onPageFinished: (_) {
            setState(() {
              indexPosition = 0;
            });
          },
        ),
        Container(
          child: Center(child: CircularProgressIndicator()),
        )
      ]),
    );
  }
}
