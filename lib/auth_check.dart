
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'src/account/screens/login_page.dart';
import 'src/navigation/navigation.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("테스트 페이지"),
      ),
      body: Column(
        children: [
          CupertinoButton(
            child: Text("로그인 이동"),
            onPressed: () {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => LoginPage()));
            },
          ),
          CupertinoButton(
            child: Text("메인 이동"),
            onPressed: () {
              // Navigator.pushAndRemoveUntil(context,
              //     CupertinoPageRoute(builder: (context) => NavigatePage()),(route) => false,);


              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => NavigatePage()));
            },
          ),
        ],
      ),
    );
  }
}
