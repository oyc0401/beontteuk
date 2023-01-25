import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlankPage extends StatelessWidget {
  const BlankPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("빈 페이지"),
      ),
      body: Column(
        children: [
          CupertinoButton(
            child: Text("빈 페이지 이동"),
            onPressed: () {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => BlankPage()));
            },
          ),
        ],
      ),
    );
  }
}
