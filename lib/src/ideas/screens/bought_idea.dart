import 'dart:convert';
import 'package:beontteuk/src/ideas/screens/buy_page.dart';
import 'package:beontteuk/src/ideas/screens/write_review_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BoughtIdea extends StatefulWidget {
  BoughtIdea({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  _BoughtIdeaState createState() => _BoughtIdeaState();
}

class _BoughtIdeaState extends State<BoughtIdea> {
  late WebViewController _controller;

  @override
  initState() {
    super.initState();
    // _controller

    init();
  }

  bool success = false;

  init() async {
    // String data = await rootBundle.loadString('assets/about_us.html');

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel('MessageInvoker', onMessageReceived: (s) {
        print(s.message);

        if(s.message=='push reviewPage'){
          Navigator.push(
              context, CupertinoPageRoute(builder: (context) => WriteReviewPage(index: 1,)));
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
    // ..loadRequest(Uri.dataFromString(data, mimeType: 'text/html'));

    Map body = {
      'name': 'rabbit',
    };
    List<int> list = json.encode(body).codeUnits;

    _controller.loadRequest(
      Uri.parse('http://54.83.101.17:8080/yeojun'),
      // method: LoadRequestMethod.get,
      // body: Uint8List.fromList(list),
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
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        title: Text('${widget.index}'),
      ),
      body: success
          ? WebViewWidget(
        controller: _controller,
      )
          : CircularProgressIndicator(),
    );
  }
}
