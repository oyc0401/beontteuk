import 'package:beontteuk/inmat/auth/inmat_auth.dart';
import 'package:beontteuk/src/account/screens/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../navigation/navigation.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 200,
                height: 200,
                child: Image.network(
                    'https://t1.daumcdn.net/cfile/tistory/24283C3858F778CA2E',
                    fit: BoxFit.cover),
              ),
              Positioned(
                bottom: 20,
                right: 20,
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(100),
                  child: IconButton(
                      onPressed: () {
                        print('dsa');
                      },
                      icon: Icon(Icons.add)),
                ),
              ),
            ],
          ),


          CupertinoButton(
            color: Colors.redAccent,
            child: const Text("로그아웃"),
            onPressed: () {
              InMatAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(context,
                  CupertinoPageRoute(builder: (context) => LoginPage()),(route) => false,);

            },
          ),
        ],
      ),
    );
  }
}
