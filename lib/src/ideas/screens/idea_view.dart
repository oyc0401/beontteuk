import 'dart:convert';
import 'package:beontteuk/inmat/auth/inmat_auth.dart';
import 'package:beontteuk/inmat/inmat_api/inmat_api.dart';
import 'package:beontteuk/src/ideas/screens/buy_page.dart';
import 'package:beontteuk/utils/date_parse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../utils/colorss.dart';
import '../../../utils/letter_space_text_style.dart';

class IdeaView extends StatefulWidget {
  IdeaView({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  _IdeaViewState createState() => _IdeaViewState();
}

class _IdeaViewState extends State<IdeaView> {
  @override
  initState() {
    super.initState();
    // _controller

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

  String tag = '친환경, 에코 프렌들리';

  String nickname = "와사비 성애자";

  int soldIdea = 79;

  int reviewCount = 6;

  bool bookmarked = false;

  bool get isWriter => user_id == InMatAuth.instance.currentUser?.token;

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
                },
                child: Row(
                  children: const [
                    SizedBox(width: 16,),
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
                    child: const Image(
                      image: AssetImage(
                          'assets/home/strawberries-1396330_1920.jpg'),
                      fit: BoxFit.cover,
                      colorBlendMode: BlendMode.darken,
                    ),
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
                    height: 17,
                  ),
                  Row(
                    children: [
                      Text(
                        tag,
                        style: const LetterStyle(
                          fontSize: 14,
                          color: Color(0xff0066FF),
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
                    height: 3,
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
                    height: 9,
                  ),
                  Row(
                    children: [
                      ReviewStar(
                        score: rating,
                      ),
                      Text(
                        '평점 $rating ($rating_cnt)',
                        style: const LetterStyle(
                          fontSize: 16,
                          color: Colorss.text1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  Row(
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
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  shape: BoxShape.circle,
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
              height: 5,
              color: const Color(0xffF3F3F3),
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
                    height: 23,
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

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 19,
                  ),
                  Text(
                    "후기($reviewCount)",
                    style: const LetterStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colorss.text1,
                    ),
                  ),
                  const SizedBox(
                    height: 19,
                  ),
                  for (int i = 0; i < 5; i++)
                    const ReviewCard(
                      score: 4,
                      contents:
                          "세상을 바꿀 아이디어 그 자체 일론 머스크도 꼬막 무침 한 입 먹고선 따봉을 날렸다죠! 최고의 꼬막무침은 와사비 꼬막무침이라는 사실을 이제야 깨닫습니다. 저는 앞으로 삼시세끼 와사비 꼬막무침 먹기 챌린지를 열어 볼 생각입니다.",
                      date: "어제",
                      image: "개",
                      nickname: "침착한 비버",
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
      bottomNavigationBar: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              height: 1,
              color: const Color(0xffDCDCDC),
            ),
            const SizedBox(
              height: 9,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 20,
                ),
                IconButton(
                  onPressed: () {
                    if (bookmarked) {
                      bookmarked = false;
                      print('북마크 취소 index: ${widget.index}');
                    } else {
                      bookmarked = true;
                      print('북마크 설정 index: ${widget.index}');
                    }
                    setState(() {});
                  },
                  icon: Icon(
                    bookmarked ? Icons.bookmark : Icons.bookmark_outline,
                    color: bookmarked ? const Color(0xffD70D0D) : const Color(0xffDCDCDC),
                  ),
                  iconSize: 32,
                ),
                const SizedBox(
                  width: 14,
                ),
                Container(
                  width: 1,
                  height: 19,
                  color: const Color(0xffDCDCDC),
                ),
                const SizedBox(
                  width: 18,
                ),
                Text(
                  "${price}P",
                  style: const LetterStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colorss.text1,
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    if (isWriter) {
                      print("수정하기 페이지 이동 index: ${widget.index}");
                    } else {
                      print("구매하기 페이지 이동 index: ${widget.index}");
                    }
                  },
                  borderRadius: BorderRadius.circular(4),
                  child: Ink(
                    width: 142,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colorss.brand,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        isWriter ? "수정하기" : "구매하기",
                        style: const LetterStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
              ],
            ),
            const SizedBox(
              height: 14,
            ),
          ],
        ),
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
          const Icon(
            Icons.star,
            size: 14,
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
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
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
