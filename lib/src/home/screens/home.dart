import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../ideas/screens/idea_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

// [SliverAppBar]s are typically used in [CustomScrollView.slivers], which in
// turn can be placed in a [Scaffold.body].
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
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [Icon(Icons.ac_unit), Text('로고')],
                    ),
                    Container(
                      width: double.infinity,
                      child: Text(
                        '어플 아이덴티티\n홍보문구',
                        style: TextStyle(color: Colors.black, fontSize: 30),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 80,
              child: Center(
                child: Text('검색창'),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 120,
              color: Colors.red,
              child: Text("카테고리"),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) => IdeaView()));
                  },
                  child: Container(
                    color: index.isOdd ? Colors.white : Colors.black12,
                    height: 100.0,
                    child: Center(
                      child: Text('$index', textScaleFactor: 5),
                    ),
                  ),
                );
              },
              childCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}
