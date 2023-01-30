import 'package:beontteuk/auth_check.dart';
import 'package:beontteuk/inmat/auth/Inmat_token.dart';
import 'package:beontteuk/inmat/auth/inmat_auth.dart';
import 'package:beontteuk/src/ideas/screens/idea_view.dart';
import 'package:beontteuk/src/splash.dart';
import 'package:camera/camera.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '_sample/s3/s3.dart';
import 'src/account/screens/login_page.dart';
import 'src/ideas/screens/bought_idea.dart';
import 'src/navigation/navigation.dart';
import 'utils/colorss.dart';
import 'utils/letter_space_text_style.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await InMatAuth.initialize();

  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));

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
        // backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          elevation: 0.0,
          // centerTitle: false,
          centerTitle: true,
          backgroundColor: Colors.white,
          titleTextStyle: LetterStyle(fontSize: 18, color: Colorss.text1),
          iconTheme: IconThemeData(
            color: Colorss.text1,
          ),
        ),


        // backgroundColor: Colors.white,
      ),
      // home: const AuthCheck(),
      // home:  productMode(),
      // home: S3Example(),
      home: SplashPage(),

      // home:  IdeaWebView(index: 2,),
    );
  }
}
