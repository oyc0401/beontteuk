import 'package:beontteuk/inmat/auth/inmat_auth.dart';
import 'package:beontteuk/src/ideas/screens/idea_view.dart';
import 'package:beontteuk/utils/letter_space_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../inmat/inmat_api/inmat_api.dart';
import '../../../utils/colorss.dart';
import '../../../utils/date_parse.dart';
import 'home.dart';

class SearchedPage extends StatefulWidget {
  const SearchedPage({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  State<SearchedPage> createState() => _SearchedPageState();
}

class _SearchedPageState extends State<SearchedPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  List li = [];

  bool sucess = false;

  bool get noShow {
    return sucess && li.isEmpty;
  }

  init() async {
    li = await InMatApi.community.getSearch(widget.text);
    print(li);

    sucess = true;
    setState(() {});
  }

  Widget body() {
    return Column(
      children: [
        for (Map map in li)
          HomeCard(
            onclick: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => IdeaView(
                    index: map['index'],
                  ),
                ),
              );

              Navigator.pop(context);
            },
            title: map['title'],
            created: DateParse.toKorean(map['created']),
            index: map['index'],
            price: map['price'],
            thumbnaill: map['thumbnail'],
            bookmarkCount: map['collection_cnt'],
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("검색"),
      ),
      body: Column(
        children: [
          !noShow
              ? body()
              : Expanded(
                  child: Center(
                  child: Text(
                    '검색 결과가 없습니다.',
                    style: const LetterStyle(
                      fontSize: 16,
                      // fontWeight: FontWeight.bold,
                      color: Colorss.text1,
                    ),
                  ),
                )),
        ],
      ),
    );
  }
}
