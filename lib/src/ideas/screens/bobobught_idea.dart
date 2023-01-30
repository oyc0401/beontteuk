import 'dart:convert';
import 'package:beontteuk/inmat/auth/inmat_auth.dart';
import 'package:beontteuk/inmat/inmat_api/inmat_api.dart';
import 'package:beontteuk/src/ideas/screens/buy_page.dart';
import 'package:beontteuk/src/report_page.dart';
import 'package:beontteuk/src/write_review.dart';
import 'package:beontteuk/utils/date_parse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../utils/colorss.dart';
import '../../../utils/letter_space_text_style.dart';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../../../utils/price_comma.dart';
import '../../message/writeMail.dart';

class BoboughtIdea extends StatefulWidget {
  BoboughtIdea({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  _BoboughtIdeaState createState() => _BoboughtIdeaState();
}

class _BoboughtIdeaState extends State<BoboughtIdea> {
  @override
  initState() {
    super.initState();
    // _controller

    // print(widget.index);

    init();
  }

  bool success = false;
  Map map = {};

  init() async {
    map = await InMatApi.community.getIdea(widget.index);
    success = true;
    setState(() {});
  }

  int get user_id => map['user_id'];

  String get title => map['title'];

  String get overview => map['overview'];

  String get thumbnail => map['thumbnail'];

  String get created => DateParse.toDate(map['created']);

  int get category => map['category'];

  int get price => map['price'];

  int get rating_cnt => map['rating_cnt'];

  double get rating => map['rating'].toDouble();

  String get tag {
    List list = contents['hashTags'];
    if (list.isEmpty) {
      return "";
    } else if (list.length == 1) {
      return list[0];
    } else {
      return "${list[0]}, ${list[1]}";
    }
  }

  bool active = false;

  String get nickname => map['nickname'];

  int soldIdea = 79;

  bool bookmarked = false;

  bool get isWriter => user_id == InMatAuth.instance.currentUser?.token;

  Map get contents {
    Map m = json.decode(map['description']);
    return m;
  }

  Widget contentWidget(Map contents) {
    print(contents);

    List<Widget> result = [];

    for (Map m in contents['content']) {
      if (m['type'] == 'text') {
        result.add(
          Padding(
            padding: const EdgeInsets.only(
              top: 9.0,
              left: 16,
              right: 16,
            ),
            child: Container(
              width: double.infinity,
              child: Text(
                m['content'],
                style: LetterStyle(
                  color: Colorss.text1,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        );
      } else {
        result.add(Padding(
            padding: const EdgeInsets.only(
              top: 9.0,
              left: 16,
              right: 16,
            ),
            child: Image.network(
              m['content'],
              fit: BoxFit.fitWidth,
            )));
      }
    }

    return Column(
      children: result,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!success) {
      return const Scaffold();
    }
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            actions: [
              InkWell(
                onTap: () {
                  print("신고 페이지 이동 index: ${widget.index}");

                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => ReportPage(
                                text: '신고하기',
                              )));
                },
                child: Row(
                  children: const [
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      '신고',
                      style: LetterStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Icon(
                      Icons.report_outlined,
                    ),
                    SizedBox(
                      width: 16,
                    )
                  ],
                ),
              ),
            ],
            toolbarHeight: 45,
            // backgroundColor: Colors.white,
            pinned: false,
            expandedHeight: 224 - 45,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 224,
                    color: Colors.white,
                    child: Image.network(thumbnail, fit: BoxFit.cover),

                    // const Image(
                    //   image: AssetImage(
                    //       'assets/home/strawberries-1396330_1920.jpg'),
                    //   fit: BoxFit.cover,
                    //   colorBlendMode: BlendMode.darken,
                    // ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 224,
                    decoration: const BoxDecoration(
                      color: Color(0x3D000000),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 19,
                  ),
                  Text(
                    title,
                    style: const LetterStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colorss.text1,
                    ),
                  ),
                  Container(
                    height: 2,
                  ),
                  Row(
                    children: [
                      Text(
                        tag,
                        style: const LetterStyle(
                          fontSize: 14,
                          color: Colorss.text1,
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        created,
                        style: const LetterStyle(
                          fontSize: 14,
                          color: Colorss.text2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              height: 1,
              color: const Color(0xffDCDCDC),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 19,
                  ),
                  const Text(
                    "아이디어 요약",
                    style: LetterStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colorss.text1,
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    overview,
                    style: const LetterStyle(
                      fontSize: 16,
                      // fontWeight: FontWeight.bold,
                      color: Colorss.text1,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      hashTag("꼬막"),
                      hashTag("와사비"),
                      hashTag("신박한"),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      hashTag("쫄깃쫄깃"),
                      hashTag("존맛"),
                    ],
                  ),
                  const SizedBox(
                    height: 27,
                  ),
                  InkWell(
                    onTap: () {
                      if (active) {
                        active = false;
                        setState(() {});
                      } else {
                        active = true;
                        setState(() {});
                      }
                    },
                    child: Ink(
                      height: 49,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colorss.brand,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '아이디어 열람',
                          style: const LetterStyle(
                            fontSize: 18,
                            // fontWeight: FontWeight.bold,
                            color: Colorss.brand,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              height: 5,
              color: const Color(0xffF3F3F3),
            ),
          ),

          !active
              ? SliverToBoxAdapter(child: Container())
              : SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 23,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          '아이디어',
                          style: const LetterStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colorss.text1,
                          ),
                        ),
                      ),
                      contentWidget(contents),
                      SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => WriteReview(
                                  text: "리뷰 작성",
                                ),
                              ),
                            );
                          },
                          child: Ink(
                            height: 49,
                            decoration: BoxDecoration(
                              color: Colorss.brand,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                              child: Text(
                                '리뷰 작성',
                                style: const LetterStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Container(
                        width: double.infinity,
                        height: 5,
                        color: const Color(0xffF3F3F3),
                      ),
                    ],
                  ),
                ),

          SliverToBoxAdapter(
            child: SizedBox(
              height: 15,
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        print("다른 사람 프로필 페이지 이동 user_id: $user_id");
                      },
                      child: Row(
                        children: [
                          Container(
                            width: 47,
                            height: 47,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset(
                                'assets/dog.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 14,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                nickname,
                                style: const LetterStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colorss.text1,
                                ),
                              ),
                              Text(
                                "판매 아이디어 $soldIdea개",
                                style: const LetterStyle(
                                  fontSize: 16,
                                  // fontWeight: FontWeight.bold,
                                  color: Colorss.text2,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),

                  // const Spacer(),
                  InkWell(
                    onTap: () {
                      print("쪽지 보내기 페이지 이동 user_id: $user_id");
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => WriteMail(
                            text: '쪽지보내기',
                          ),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(4),
                    child: Ink(
                      width: 109,
                      height: 44,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Center(
                        child: Text(
                          "쪽지 보내기",
                          style: LetterStyle(
                            fontSize: 16,
                            // fontWeight: FontWeight.bold,
                            color: Colorss.text1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: SizedBox(
              height: 19,
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              height: 5,
              color: const Color(0xffF3F3F3),
            ),
          ),

          SliverToBoxAdapter(
            child: SizedBox(
              height: 13,
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '이용 가능 범위',
                    style: const LetterStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colorss.text1,
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Row(
                    children: [
                      Text(
                        '상업적 용도',
                        style: const LetterStyle(
                          fontSize: 16,
                          // fontWeight: FontWeight.bold,
                          color: Colorss.text1,
                        ),
                      ),
                      Spacer(),
                      Text(
                        '이용가능',
                        style: const LetterStyle(
                          fontSize: 16,
                          // fontWeight: FontWeight.bold,
                          color: Colorss.text1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Text(
                        '특허 출원',
                        style: const LetterStyle(
                          fontSize: 16,
                          // fontWeight: FontWeight.bold,
                          color: Colorss.text1,
                        ),
                      ),
                      Spacer(),
                      Text(
                        '불가능',
                        style: const LetterStyle(
                          fontSize: 16,
                          // fontWeight: FontWeight.bold,
                          color: Colorss.text1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 32,
                  ),
                ],
              ),
            ),
          ),

          // SliverList(
          //   delegate: SliverChildBuilderDelegate(
          //         (BuildContext context, int index) {
          //       return HomeCard(
          //         title: ideas[index]['title'],
          //         created: ideas[index]['created'],
          //         index: ideas[index]['index'],
          //         price: ideas[index]['price'],
          //         thumbnaill: ideas[index]['thumbnail'],
          //         bookmarkCount: ideas[index]['rating_cnt'],
          //       );
          //     },
          //     childCount: ideas.length,
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget hashTag(String tag) {
    return Padding(
      padding: const EdgeInsets.only(right: 5.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: () {},
        child: Ink(
          height: 37,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: const Color(0xffECECEC),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Center(
            child: Text(
              "#$tag",
              style: const LetterStyle(fontSize: 16, color: Colorss.text1),
            ),
          ),
        ),
      ),
    );
  }
}

class ReviewStar extends StatelessWidget {
  const ReviewStar({Key? key, required this.score, this.size = 20})
      : super(key: key);

  final double score;
  final double size;

  @override
  Widget build(BuildContext context) {
    int full = score.toInt();
    int half = (score - full >= 0.5) ? 1 : 0;
    int blank = 5 - score.toInt() - half;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < full; i++)
          SvgPicture.asset(
            'assets/icons/icon_Star_Full.svg',
            width: 20,
            height: 20,
          ),
        for (int i = 0; i < half; i++)
          SvgPicture.asset(
            'assets/icons/icon_Star_Half.svg',
            width: 20,
            height: 20,
          ),
        for (int i = 0; i < blank; i++)
          SvgPicture.asset(
            'assets/icons/icon_Star_Blank.svg',
            width: 20,
            height: 20,
          ),
      ],
    );
  }
}

class ReviewCard extends StatelessWidget {
  const ReviewCard(
      {Key? key,
      required this.image,
      required this.nickname,
      required this.score,
      required this.date,
      required this.contents})
      : super(key: key);
  final String image;
  final String nickname;
  final double score;
  final String date;
  final String contents;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 35),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 47,
                height: 47,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    'assets/dog.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 13,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nickname,
                    style: const LetterStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colorss.text1,
                    ),
                  ),
                  Row(
                    children: [
                      ReviewStar(score: score, size: 14),
                      const SizedBox(
                        width: 9,
                      ),
                      Text(
                        '${score.toInt()}점·$date',
                        style: const LetterStyle(
                          fontSize: 16,
                          // fontWeight: FontWeight.bold,
                          color: Colorss.text2,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
            color: const Color(0xffF3F3F3),
            child: Text(
              '$contents',
              style: const LetterStyle(
                fontSize: 16,
                // fontWeight: FontWeight.bold,
                color: Colorss.text1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
