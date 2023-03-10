import 'package:beontteuk/inmat/inmat_api/inmat_api.dart';
import 'package:beontteuk/src/navigation/navigation.dart';
import 'package:beontteuk/utils/price_comma.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../utils/colorss.dart';
import '../../../utils/date_parse.dart';
import '../../../utils/letter_space_text_style.dart';
import '../../ideas/screens/idea_view.dart';
import '../../write/screens/write_title.dart';
import 'search_page.dart';

List<String> category_list = [
  '요리/식품',
  '생활',
  '패션/의류',
  'IT',
  '??',
  '최신 아이디어',
];
List<String> category_image = [
  'assets/home/strawberries-1396330_1920.jpg',
  'assets/home/living-room-2732939_1920.jpg',
  'assets/home/closet-912694_1920.jpg',
  'assets/home/laptop-2620118_1920.jpg',
];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    init();
  }

  init() async {
    setState(() {
      success = false;
    });
    ideas = await InMatApi.community.getIdeas();
    success = true;

    print(ideas);
    setState(() {});
  }

  List ideas = [];

  int clickIndex = 5;

  void happy(int flower) async {
    if (clickIndex == flower) {
      clickIndex = 5;
      success = false;
      setState(() {});
      ideas = await InMatApi.community.getIdeas();
      success = true;
      setState(() {});
    } else {
      clickIndex = flower;
      success = false;
      setState(() {});
      ideas = await InMatApi.community.getCategory(flower);
      success = true;
      setState(() {});
    }
  }

  bool success = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Row(
              children: const [
                SizedBox(
                  width: 29,
                  height: 29,
                  // color: Colors.grey,
                  child:
                      Image(image: AssetImage('assets/home/LOGO_rounded.png')),
                ),
                SizedBox(
                  width: 7,
                ),
                Text(
                  '번뜩',
                  style: LetterStyle(
                      color: Colorss.text1,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            backgroundColor: Colors.white,
            pinned: true,
            expandedHeight: 180.0,
            toolbarHeight: 45,
            surfaceTintColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Row(
                    //   children: const [
                    //     SizedBox(
                    //       width: 29,
                    //       height: 29,
                    //       // color: Colors.grey,
                    //       child: Image(
                    //           image:
                    //               AssetImage('assets/home/LOGO_rounded.png')),
                    //     ),
                    //     SizedBox(
                    //       width: 7,
                    //     ),
                    //     Text(
                    //       '번뜩',
                    //       style: LetterStyle(
                    //           color: Colorss.text1,
                    //           fontSize: 16,
                    //           fontWeight: FontWeight.bold),
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(
                      width: double.infinity,
                      child: Text(
                        '아이디어가\n반짝이는 순간',
                        style: LetterStyle(
                            color: Colorss.text1,
                            height: 1.34,
                            fontSize: 32,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              height: 8,
            ),
          ),
          SliverToBoxAdapter(
            child: InkWell(
              onTap: () {
                Provider.of<NavigationModel>(context, listen: false)
                    .setIndex(1);
                // Navigator.push(context,
                //     CupertinoPageRoute(builder: (context) => SearchPage()));
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                height: 44,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      width: 1,
                      color: Colorss.line3,
                    ),
                    borderRadius: BorderRadius.circular(100)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      '검색어를 입력하세요.',
                      style:
                          LetterStyle(fontSize: 16, color: Color(0xff838383)),
                    ),
                    Spacer(),
                    Icon(
                      Icons.search,
                      color: Color(0xffDCDCDC),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 24,
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '카테고리',
                style: LetterStyle(
                    color: Colorss.text1,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 12,
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 52,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  // for (int i = 0; i <= 10; i++)
                  Category(
                    onclick: () {
                      happy(0);
                    },
                    text: category_list[0],
                    url: category_image[0],
                    active: clickIndex == 0,
                  ),
                  Category(
                    onclick: () {
                      happy(1);
                    },
                    text: category_list[1],
                    url: category_image[1],
                    active: clickIndex == 1,
                  ),
                  Category(
                    onclick: () async {
                      happy(2);
                    },
                    text: category_list[2],
                    url: category_image[2],
                    active: clickIndex == 2,
                  ),
                  Category(
                    onclick: () async {
                      happy(3);
                    },
                    text: category_list[3],
                    url: category_image[3],
                    active: clickIndex == 3,
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 34,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                category_list[clickIndex],
                style: LetterStyle(
                    color: Colorss.text1,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              height: 12,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return HomeCard(
                  onclick: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => IdeaView(
                          index: ideas[index]['index'],
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
                );
              },
              childCount: ideas.length,
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              height: 39 - 8,
            ),
          ),

          SliverToBoxAdapter(
            child: !success
                ? Container()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => WriteTitle()));
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: Color(0xffF3F3F3),
                        ),
                        height: 100,
                        child: Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '더이상 최신 아이디어가 없습니다.\n반짝이는 아이디어를 직접 작성해 보세요!',
                                  style: LetterStyle(
                                    color: Colorss.text2,
                                    fontSize: 16,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 1,
                                ),
                                Text(
                                  '글 작성하기 >',
                                  style: LetterStyle(
                                    color: Color(0xff3FA0FA),
                                    fontSize: 16,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ),
                  ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 24,
            ),
          ),

          // for (Map map in ideas)
          //   HomeCard(
          //     title: map['title'],
          //     created: map['created'],
          //     index: map['index'],
          //     price: map['price'],
          //     thumbnaill: map['thumbnail'],
          //     bookmarkCount: map['rating_cnt'],
          //   ),

          // SliverList(
          //   delegate: SliverChildBuilderDelegate(
          //     (BuildContext context, int index) {
          //       return InkWell(
          //         onTap: () {
          //           Navigator.push(context,
          //               CupertinoPageRoute(builder: (context) => IdeaView()));
          //         },
          //         child: HomeCard(bookmarkCount: index),
          //       );
          //     },
          //     childCount: 20,
          //   ),
          // ),
        ],
      ),
      floatingActionButton: Container(
        width: 62,
        height: 62,
        child: FloatingActionButton(
          elevation: 2,
          backgroundColor: Colorss.brand,
          shape: CircleBorder(side: BorderSide.none),
          child: SvgPicture.asset(
            'assets/icons/pencil.svg',
            width: 40,
            height: 40,
          ),
          onPressed: () {
            Navigator.push(context,
                CupertinoPageRoute(builder: (context) => WriteTitle()));
          },
        ),
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  const HomeCard(
      {Key? key,
      required this.bookmarkCount,
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
  final int bookmarkCount;
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
                            "침착한 비버 · $created",
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
                      Row(
                        children: [
                          const Icon(
                            Icons.bookmark_outline,
                            color: Colorss.text2,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            '$bookmarkCount',
                            style: const LetterStyle(
                              fontSize: 16,
                              color: Colorss.text2,
                            ),
                          ),
                        ],
                      ),
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

class Category extends StatelessWidget {
  const Category(
      {Key? key,
      required this.active,
      required this.onclick,
      required this.url,
      required this.text})
      : super(key: key);

  final bool active;

  final VoidCallback onclick;

  final String url;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6),
      child: InkWell(
        onTap: onclick,
        child: Stack(
          children: [
            Container(
              width: 118,
              height: 52,
              color: Colors.white,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image(
                  image: AssetImage(url),
                  fit: BoxFit.cover,
                  colorBlendMode: BlendMode.darken,
                ),
              ),
            ),
            Container(
              width: 118,
              height: 52,
              decoration: BoxDecoration(
                color:
                    active ? const Color(0xE85835E2) : const Color(0x80000000),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  text,
                  style: LetterStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: active ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
