import 'package:beontteuk/inmat/auth/inmat_auth.dart';
import 'package:beontteuk/inmat/inmat_api/inmat_api.dart';
import 'package:beontteuk/src/account/screens/login_page.dart';
import 'package:beontteuk/utils/colorss.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../ideas/screens/bought_idea.dart';
import '../../navigation/navigation.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  init() async {
    List list = await InMatApi.account
        .getOtherProfile(int.parse(InMatAuth.instance.currentUser!.token));

    profile = list.first;
    print(profile);
    success = true;

    setState(() {});
  }

  bool success = false;

  Map profile = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("마이페이지"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 26,
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: 87,
              height: 87,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(1000),
                child: Image.network(
                  'https://inmat.s3.ap-northeast-1.amazonaws.com/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA+2023-01-29+%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE+9.40.27.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              profile['nickname'],
              style: TextStyle(
                color: Colorss.text1,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.symmetric(vertical: 12),

              // padding: EdgeInsets,
              width: double.infinity,
              height: 70,
              decoration: BoxDecoration(
                color: Color(0xffF3F3F3),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '내 포인트',
                        style: TextStyle(
                          color: Colorss.text1,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '23,402 P',
                        style: TextStyle(
                          color: Colorss.text1,
                          fontSize: 16,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 1,
                    color: Color(0xffDCDCDC),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '내 판매글',
                        style: TextStyle(
                          color: Colorss.text1,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '3개',
                        style: TextStyle(
                          color: Colorss.text1,
                          fontSize: 16,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 1,
                    color: Color(0xffDCDCDC),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '내 컬렉션',
                        style: TextStyle(
                          color: Colorss.text1,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '32개',
                        style: TextStyle(
                          color: Colorss.text1,
                          fontSize: 16,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 22,
            ),
            Container(
              // margin: EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              height: 5,
              color: Color(0xffF3F3F3),
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "판매글",
                      style: TextStyle(
                        color: Colorss.text1,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "판매글",
                      style: TextStyle(
                        color: Colorss.text1,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "판매글",
                      style: TextStyle(
                        color: Colorss.text1,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "판매글",
                      style: TextStyle(
                        color: Colorss.text1,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            content,
          ],
        ),
      ),
    );
  }

  Widget content = Container();
}

// Stack(
//               children: [
//                 Container(
//                   width: 200,
//                   height: 200,
//                   child: Image.network(
//                       'https://t1.daumcdn.net/cfile/tistory/24283C3858F778CA2E',
//                       fit: BoxFit.cover),
//                 ),
//                 Positioned(
//                   bottom: 20,
//                   right: 20,
//                   child: Material(
//                     color: Colors.transparent,
//                     borderRadius: BorderRadius.circular(100),
//                     child: IconButton(
//                         onPressed: () {
//                           print('dsa');
//                         },
//                         icon: Icon(Icons.add)),
//                   ),
//                 ),
//               ],
//             ),
//             CupertinoButton(
//               color: Colors.yellow,
//               child: const Text("내가 산 아이디어 하나 보기"),
//               onPressed: () {
//                 InMatAuth.instance.signOut();
//                 Navigator.push(
//                     context,
//                     CupertinoPageRoute(
//                         builder: (context) => IdeaWebView(
//                               index: 2,
//                             )));
//               },
//             ),
//             CupertinoButton(
//               color: Colors.redAccent,
//               child: const Text("로그아웃"),
//               onPressed: () {
//                 InMatAuth.instance.signOut();
//                 Navigator.pushAndRemoveUntil(
//                   context,
//                   CupertinoPageRoute(builder: (context) => LoginPage()),
//                   (route) => false,
//                 );
//               },
//             ),
