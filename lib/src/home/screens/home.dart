import 'package:beontteuk/inmat/inmat_api/inmat_api.dart';
import 'package:beontteuk/src/navigation/navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../../../utils/colorss.dart';
import '../../../utils/date_parse.dart';
import '../../ideas/screens/idea_view.dart';
import '../../write/screens/write_title.dart';
import 'search_page.dart';

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
    ideas = await InMatApi.community.getIdeas();

    print(ideas);
    setState(() {});
  }

  List ideas = [];

  int clickIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.white,
            pinned: true,
            expandedHeight: 160.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: const [
                        SizedBox(
                          width: 29,
                          height: 29,
                          // color: Colors.grey,
                          child: Image(
                              image:
                                  AssetImage('assets/home/LOGO_rounded.png')),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          '번뜩',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: double.infinity,
                      child: Text(
                        '반짝반짝 빛나네\n번뜩이는 아이디어',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 32,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // SliverToBoxAdapter(
          //   child: Container(
          //     height: 24,
          //   ),
          // ),
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
                height: 36,
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
                      style: TextStyle(fontSize: 16, color: Color(0xff838383)),
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
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
              child: ListView(scrollDirection: Axis.horizontal, children: [
                const SizedBox(
                  width: 10,
                ),
                for (int i = 0; i <= 10; i++)
                  Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: InkWell(
                      onTap: () {
                        if (clickIndex == i) {
                          clickIndex = -1;
                        } else {
                          clickIndex = i;
                        }

                        setState(() {});
                      },
                      child: Stack(
                        children: [
                          Container(
                            width: 118,
                            height: 52,
                            color: Colors.white,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: const Image(
                                image: AssetImage(
                                    'assets/home/strawberries-1396330_1920.jpg'),
                                fit: BoxFit.cover,
                                colorBlendMode: BlendMode.darken,
                              ),
                            ),
                          ),
                          Container(
                            width: 118,
                            height: 52,
                            decoration: BoxDecoration(
                              color: clickIndex == i
                                  ? const Color(0xE85835E2)
                                  : const Color(0x80000000),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                '요리/식품',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: clickIndex == i
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ]),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 34,
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '최신 아이디어',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(
            context, CupertinoPageRoute(builder: (context) => WriteTitle()));
      }),
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
      required this.index})
      : super(key: key);

  final int index;
  final String thumbnaill;
  final String title;
  final String created;
  final int price;
  final int bookmarkCount;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => IdeaView(
                      index: index,
                    )));
      },
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
                  child: Image.network(thumbnaill,fit: BoxFit.cover),
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
                    style: const TextStyle(
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
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "$price원",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(Icons.bookmark_outline),
                          Text(
                            '$bookmarkCount',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colorss.text1,
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
