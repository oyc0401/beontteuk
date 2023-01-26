import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("받은 쪽지한"),
        toolbarHeight: 45,
      ),
      body: Column(

        children: [
          // CupertinoButton(
          //   child: Text("쪽지 페이지 이동"),
          //   onPressed: () {
          //     Navigator.push(context,
          //         CupertinoPageRoute(builder: (context) => MessagePage()));
          //   },
          // ),
        ],
      ),
    );
  }
}
