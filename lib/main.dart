import 'package:beontteuk/auth_check.dart';
import 'package:beontteuk/inmat/auth/Inmat_token.dart';
import 'package:beontteuk/inmat/auth/inmat_auth.dart';
import 'package:flutter/material.dart';

import 'src/account/screens/login_page.dart';
import 'src/navigation/navigation.dart';
import 'utils/colorss.dart';
import 'utils/letter_space_text_style.dart';

void main() async{
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await InMatAuth.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colorss.brand,
        fontFamily: 'NotoSansKR',
        canvasColor: Colors.white,
        appBarTheme: const AppBarTheme(
          elevation: 0.0,
          // centerTitle: false,
          // centerTitle: true,
          backgroundColor: Colors.white,
          titleTextStyle: LetterStyle(fontSize: 18, color: Colorss.text1),
          iconTheme: IconThemeData(
            color: Colorss.text1,
          ),
        ),
        // backgroundColor: Colors.white,
      ),
      // home: const AuthCheck(),
      home:  productMode(),
    );
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

