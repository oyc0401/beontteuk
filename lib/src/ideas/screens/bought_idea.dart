import 'dart:convert';
import 'package:beontteuk/src/ideas/screens/buy_page.dart';
import 'package:beontteuk/src/ideas/screens/write_review_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../fails.dart';

class BoughtIdea extends StatefulWidget {
  BoughtIdea({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  _BoughtIdeaState createState() => _BoughtIdeaState();
}

class _BoughtIdeaState extends State<BoughtIdea> {
  late WebViewController _controller;

  @override
  initState() {
    super.initState();
    init();
  }

  bool success = false;

  init() async {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel('MessageInvoker', onMessageReceived: (s) {
        print(s.message);

        if (s.message == 'push reviewPage') {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => NoWeb(
                        url: "https://beontteuk.github.io/report_page/",
                      )));
        }

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
      );
    _controller.loadRequest(
      Uri.parse('http://54.83.101.17:8080/yeojun'),
    );

    success = true;
    setState(() {});
  }

  Future<void> loadHtmlFromAssets(String filename, controller) async {
    String fileText = await rootBundle.loadString(filename);
    controller.loadUrl(Uri.dataFromString(fileText,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }

  // Future<String> loadLocal() async {
  //   return await rootBundle.loadString('assets/about_us.html');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.text),
      ),
      body: success
          ? WebViewWidget(
              controller: _controller,
            )
          : CircularProgressIndicator(),
    );
  }
}
