import 'dart:convert';
import 'package:beontteuk/src/ideas/screens/buy_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class IdeaView extends StatefulWidget {
  IdeaView({Key? key}) : super(key: key);

  @override
  _IdeaViewState createState() => _IdeaViewState();
}

class _IdeaViewState extends State<IdeaView> {
  late WebViewController _controller;

  @override
  initState() {
    super.initState();
    // _controller

    init();
  }

  bool success = false;

  init() async {
    String data = await rootBundle.loadString('assets/about_us.html');

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel('MessageInvoker', onMessageReceived: (s) {
        print(s.message);
        Navigator.push(context,
            CupertinoPageRoute(builder: (context) => BuyPage()));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(s.message),
        ));
      })
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      // ..loadRequest(Uri.dataFromString(data, mimeType: 'text/html'));
    ..loadRequest(Uri.parse('http://localhost:3000/'));

    success = true;
    setState(() {});
  }

  Future<void> loadHtmlFromAssets(String filename, controller) async {
    String fileText = await rootBundle.loadString(filename);
    controller.loadUrl(Uri.dataFromString(fileText,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }

  Future<String> loadLocal() async {
    return await rootBundle.loadString('assets/about_us.html');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: success
          ? WebViewWidget(
              controller: _controller,
            )
          : CircularProgressIndicator(),
    );
  }
}
