import 'package:beontteuk/inmat/auth/inmat_auth.dart';
import 'package:beontteuk/inmat/inmat_api/inmat_api.dart';
import 'package:beontteuk/src/account/screens/login_page.dart';
import 'package:beontteuk/utils/colorss.dart';
import 'package:beontteuk/utils/letter_space_text_style.dart';
import 'package:beontteuk/utils/price_comma.dart';
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
        toolbarHeight: 45,
        surfaceTintColor: Colors.white,
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
                      style: LetterStyle(
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
                              style: LetterStyle(
                                color: Colorss.text1,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '23,402 P',
                              style: LetterStyle(
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
                              style: LetterStyle(
                                color: Colorss.text1,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '3개',
                              style: LetterStyle(
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
                              style: LetterStyle(
                                color: Colorss.text1,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '32개',
                              style: LetterStyle(
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
                        style: LetterStyle(
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
                  //           style: LetterStyle(
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
                  //     //       style: LetterStyle(
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
                  //     //       style: LetterStyle(
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
                  //     //       style: LetterStyle(
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
          HomeCardd(
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
          )
      ],
    );
  }
}


class HomeCardd extends StatelessWidget {
  const HomeCardd(
      {Key? key,

        required this.thumbnaill,
        required this.title,
        required this.created,
        required this.price,
        required this.index,
        required this.onclick})
      : super(key: key);

  final int index;
  final String thumbnaill;
  final String title;
  final String created;
  final int price;

  final VoidCallback onclick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onclick,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: 84,
                  height: 84,
                  color: Colors.grey,
                  child: Image.network(thumbnaill, fit: BoxFit.cover),
                ),
                // Positioned(
                //   bottom: 8,
                //   right: 7,
                //   child: Container(
                //     width: 32,
                //     height: 32,
                //     decoration: BoxDecoration(
                //       color: Colors.red,
                //       shape: BoxShape.circle,
                //     ),
                //   ),
                // ),
              ],
            ),
            const SizedBox(
              width: 14,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: const LetterStyle(
                      color: Colorss.text1,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "닉네임 · $created",
                            style: const LetterStyle(
                              color: Colorss.text2,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "${PriceComma.getComma(price)}P",
                            style: const LetterStyle(
                              color: Colorss.text1,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),

                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
