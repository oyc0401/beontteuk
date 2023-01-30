import 'package:beontteuk/inmat/auth/inmat_auth.dart';
import 'package:beontteuk/inmat/inmat_api/inmat_api.dart';
import 'package:beontteuk/src/account/screens/login_page.dart';
import 'package:beontteuk/utils/colorss.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/date_parse.dart';
import '../../home/screens/home.dart';
import '../../ideas/screens/bobobught_idea.dart';
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
      body: !success
          ? Container()
          : SingleChildScrollView(
              child: Column(
                // crossAxisAlignment:,
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
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        'assets/dog.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () {
                      InMatAuth.instance.signOut();
                      Navigator.pushAndRemoveUntil(
                        context,
                        CupertinoPageRoute(builder: (context) => LoginPage()),
                        (route) => false,
                      );
                    },
                    child: Text(
                      profile['nickname'],
                      style: TextStyle(
                        color: Colorss.text1,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
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
                    height: 77,
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
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        "내가 구매한 글",
                        style: TextStyle(
                          color: Colorss.text1,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  // Row(
                  //   children: [
                  //     InkWell(
                  //       onTap: () {},
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(16.0),
                  //         child: Text(
                  //           "판매글",
                  //           style: TextStyle(
                  //             color: Colorss.text1,
                  //             fontSize: 16,
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     // InkWell(
                  //     //   onTap: () {},
                  //     //   child: Padding(
                  //     //     padding: const EdgeInsets.all(16.0),
                  //     //     child: Text(
                  //     //       "판매글",
                  //     //       style: TextStyle(
                  //     //         color: Colorss.text1,
                  //     //         fontSize: 16,
                  //     //         fontWeight: FontWeight.bold,
                  //     //       ),
                  //     //     ),
                  //     //   ),
                  //     // ),
                  //     // InkWell(
                  //     //   onTap: () {},
                  //     //   child: Padding(
                  //     //     padding: const EdgeInsets.all(16.0),
                  //     //     child: Text(
                  //     //       "판매글",
                  //     //       style: TextStyle(
                  //     //         color: Colorss.text1,
                  //     //         fontSize: 16,
                  //     //         fontWeight: FontWeight.bold,
                  //     //       ),
                  //     //     ),
                  //     //   ),
                  //     // ),
                  //     // InkWell(
                  //     //   onTap: () {},
                  //     //   child: Padding(
                  //     //     padding: const EdgeInsets.all(16.0),
                  //     //     child: Text(
                  //     //       "판매글",
                  //     //       style: TextStyle(
                  //     //         color: Colorss.text1,
                  //     //         fontSize: 16,
                  //     //         fontWeight: FontWeight.bold,
                  //     //       ),
                  //     //     ),
                  //     //   ),
                  //     // ),
                  //   ],
                  // ),
                  SizedBox(
                    height: 16,
                  ),
                  content
                ],
              ),
            ),
    );
  }

  Widget content = Homes();
}

class Homes extends StatefulWidget {
  const Homes({Key? key}) : super(key: key);

  @override
  State<Homes> createState() => _HomesState();
}

class _HomesState extends State<Homes> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  init() async {
    ideas = await InMatApi.community.getIdeas();
    print(ideas);

    setState(() {});
  }

  List ideas = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int index = 0; index < ideas.length; index++)
          HomeCard(
            onclick: () {
              // print()
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => BoboughtIdea(
                    index:ideas[index]['index'],
                  ),
                ),
              );
            },
            title: ideas[index]['title'],
            created: DateParse.toKorean(ideas[index]['created']),
            index: ideas[index]['index'],
            price: ideas[index]['price'],
            thumbnaill: ideas[index]['thumbnail'],
            bookmarkCount: ideas[index]['collection_cnt'],
          )
      ],
    );
  }
}
