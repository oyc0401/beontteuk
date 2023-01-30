import 'package:beontteuk/src/home/screens/home.dart';
import 'package:beontteuk/src/home/screens/search_page.dart';
import 'package:beontteuk/utils/colorss.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../message/massage_page.dart';
import '../profile/screens/profile.dart';
import '../write/screens/write_title.dart';

class NavigationModel with ChangeNotifier {
  int selectedIndex = 0;

  setIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}

class NavigatePage extends StatefulWidget {
  const NavigatePage({Key? key}) : super(key: key);

  @override
  State<NavigatePage> createState() => _NavigatePageState();
}

class _NavigatePageState extends State<NavigatePage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (BuildContext context) => NavigationModel()),

        // ChangeNotifierProvider(
        //     create: (BuildContext context) => CommunityViewModel()),
      ],
      child: Consumer(builder: (context, ob, child) {
        return Scaffold(
          bottomNavigationBar: bottomNav(context),
          body: Center(
            child: _widgetOptions()
                .elementAt(Provider.of<NavigationModel>(context).selectedIndex),
          ),
        );
      }),
    );
  }

  Widget bottomNav(BuildContext context) {
    return SizedBox(
      // height: 66,
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colorss.text1,
        unselectedItemColor: Colors.grey.withOpacity(.60),
        selectedFontSize: 14,
        unselectedFontSize: 12,
        showSelectedLabels: false,
        showUnselectedLabels: false,



        currentIndex: Provider.of<NavigationModel>(context).selectedIndex,
        //현재 선택된 Index
        onTap: (int index) {
          // switch(index){
          //   case 1:
          //     Provider.of<UnivSearchModel>(context,listen: false).InitUnivDatas();
          // }
          setState(() {
            Provider.of<NavigationModel>(context,listen: false).setIndex(index);
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: "홈",
            icon: Icon(Icons.grid_view_outlined, size: 30),
          ),
          BottomNavigationBarItem(
            label: "검색",
            icon: Icon(
              Icons.search_outlined,
              size: 32,
            ),
          ),
          BottomNavigationBarItem(
            label: "랜덤",
            icon: Icon(Icons.mail_outline, size: 30),
          ),
          // BottomNavigationBarItem(
          //   label: "커뮤니티",
          //   icon: Icon(Icons.question_answer),
          // ),
          BottomNavigationBarItem(
            label: "내 정보",
            // l
            icon: Icon(Icons.account_circle_outlined, size: 34),
          ),
        ],
      ),
    );
  }

  List _widgetOptions() {
    return [
      const HomePage(),
      SearchPage(),
      MessagePage(),
      // const Search(),
      // const RandomFoodSelect(),
      // const Community(),
       Profile(),
    ];
  }
}
