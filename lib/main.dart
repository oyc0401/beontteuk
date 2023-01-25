import 'package:beontteuk/auth_check.dart';
import 'package:beontteuk/inmat/auth/inmat_auth.dart';
import 'package:flutter/material.dart';

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
          centerTitle: false,
          backgroundColor: Colors.white,
          titleTextStyle: TextStylee(fontSize: 18, color: Colorss.text1),
          iconTheme: IconThemeData(
            color: Colorss.text1,
          ),
        ),
        // backgroundColor: Colors.white,
      ),
      home: const AuthCheck(),
    );
  }
}

