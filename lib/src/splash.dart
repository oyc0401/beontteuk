import 'package:beontteuk/inmat/auth/inmat_auth.dart';
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
    return Image(image: AssetImage('assets/UI_Page_Splash.png'),fit: BoxFit.cover,);

  }

  navigate() async {
    await Future.delayed(Duration(seconds: 1));

    Navigator.pushAndRemoveUntil(context,
      CupertinoPageRoute(builder: (context) => productMode()), (
          route) => false,);
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
