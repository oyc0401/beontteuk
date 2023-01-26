import 'dart:convert';

import 'package:beontteuk/inmat/auth/inmat_auth.dart';
import 'package:beontteuk/inmat/inmat_api/http_module.dart';
import 'package:beontteuk/inmat/inmat_api/inmat_exception.dart';
import 'package:beontteuk/src/navigation/navigation.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showMessage(String text) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      fontSize: 16.0);
}

class EmailSignInModel with ChangeNotifier {
  String _username = "";
  String _password = "";

  bool isAutoLogin = true;
  bool isSaveID = true;

  bool warning = false;
  bool onceWrong = false;

  String get id => _username;

  String get password => _password;

  setID(String username) {
    _username = username;
    warning = false;
    notifyListeners();
  }

  setPassword(String password) {
    _password = password;
    warning = false;
    notifyListeners();
  }

  touchAutoLogin() {
    isAutoLogin = isAutoLogin ? false : true;
    notifyListeners();
  }

  touchSaveID() {
    isSaveID = isSaveID ? false : true;
    notifyListeners();
  }

  login(BuildContext context) async {
    ///TODO 테스트 계정
    _password = 'qwe123';
    _username = 'test123';

    print('id      : $id');
    print('password: $password');

    try {
      var bytes = utf8.encode(password);
      Digest digest = sha1.convert(bytes);
      print(digest.toString());

      await InMatAuth.instance.signInEmail(id, digest.toString());
      showMessage('로그인 성공: $id, ${digest.toString()}');

      Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute(builder: (context) => NavigatePage()),
        (route) => false,
      );
    } on SignInFailed {
      // 로그인 실패 메세지 띄우기
      showMessage('없는 아이디이거나 비밀번호가 틀렸습니다.\n$id, $password');
      warning = true;
      onceWrong = true;
    } catch (e) {
      showMessage('$e');
    }

    notifyListeners();
  }
}
