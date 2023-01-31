import 'package:beontteuk/src/navigation/navigation.dart';
import 'package:beontteuk/utils/toast.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:beontteuk/src/ideas/screens/buy_page.dart';
import 'package:beontteuk/src/ideas/screens/write_review_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class KakaoPay extends StatefulWidget {
  KakaoPay({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  _KakaoPayState createState() => _KakaoPayState();
}

class _KakaoPayState extends State<KakaoPay> {
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

        if (s.message == 'writeReport') {
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
      Uri.parse('https://chaeyeongmoon.github.io/idea-chargepoint/'),
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
        // leading: IconButton(onPressed: () {}, icon: Icon(Icons.ac_unit)),
      ),
      body: success
          ? Stack(
            children: [
              WebViewWidget(
                  controller: _controller,
                ),

              Positioned(
                  top: 620,
                  child: InkWell(
                    onTap: () {
                      Message.showMessage("구매 했습니다.");


                      Navigator.pushAndRemoveUntil(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => NavigatePage(),
                        ),
                            (route) => false,
                      );
                    },
                    child: Container(
                      width: 360,
                      height: 170,
                      color: Colors.transparent,
                    ),
                  ))
            ],
          )
          : CircularProgressIndicator(),
    );
  }
}
