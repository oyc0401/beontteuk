



import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:beontteuk/src/ideas/screens/buy_page.dart';
import 'package:beontteuk/src/ideas/screens/write_review_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';



class WriteReview extends StatefulWidget {
  WriteReview({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  _WriteReviewState createState() => _WriteReviewState();
}

class _WriteReviewState extends State<WriteReview> {
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



        if (s.message == 'writeReview') {
          Navigator.pop(context);
          // Navigator.push(
          //     context,
          //     CupertinoPageRoute(
          //         builder: (context) => WriteReviewPage(
          //           index: 1,
          //         )));
        }

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
      Uri.parse('https://beontteuk.github.io/review_test_repo/'),

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
