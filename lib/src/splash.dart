import 'dart:convert';

import 'package:beontteuk/inmat/auth/inmat_auth.dart';
import 'package:beontteuk/inmat/inmat_api/inmat_exception.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';

import '../inmat/auth/Inmat_token.dart';
import '../utils/colorss.dart';
import 'account/screens/login_page.dart';
import 'navigation/navigation.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigate();
  }

  @override
  Widget build(BuildContext context) {
    return const Image(image: AssetImage('assets/UI_Page_Splash.png'),fit: BoxFit.cover,);

  }

  navigate() async {
    await Future.delayed(const Duration(milliseconds: 500));

    // await login();

    Navigator.pushAndRemoveUntil(context,
      CupertinoPageRoute(builder: (context) => productMode()), (
          route) => false,);


    // Navigator.pushAndRemoveUntil(context,
    //   CupertinoPageRoute(builder: (context) => NavigatePage()), (
    //       route) => false,);


  }


  Future<void> login()async{

    ///TODO 테스트 계정
    String password = 'qwe123';
    String  id = 'test123';

    print('id      : $id');
    print('password: $password');

    try {
      var bytes = utf8.encode(password);
      Digest digest = sha1.convert(bytes);
      print(digest.toString());

      await InMatAuth.instance.signInEmail(id, digest.toString());
      // showMessage('로그인 성공: $id, ${digest.toString()}');

      // Navigator.pushAndRemoveUntil(
      //   context,
      //   CupertinoPageRoute(builder: (context) => const NavigatePage()),
      //       (route) => false,
      // );
    } on SignInFailed {
      // 로그인 실패 메세지 띄우기
      // showMessage('없는 아이디이거나 비밀번호가 틀렸습니다.\n$id, $password');
      // warning = true;
      // onceWrong = true;
      print("로그인 SignInFailed");
    } catch (e) {
      print("로그인 e: $e");
    }
  }

  Widget productMode() {
    switch (InMatAuth.instance.status) {
      case AuthStatus.user:
        return const NavigatePage();
      case AuthStatus.guest:
      case AuthStatus.reSignIn:
        return const LoginPage();
    }
  }
}
