import 'package:beontteuk/src/home/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home/providers/home_view_model.dart';
import '../message/massage_page.dart';
import '../profile/screens/profile.dart';
import '../write/screens/write_title.dart';



class NavigatePage extends StatefulWidget {
  const NavigatePage({Key? key}) : super(key: key);

  @override
  State<NavigatePage> createState() => _NavigatePageState();
}

class _NavigatePageState extends State<NavigatePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) => HomeViewModel()),

        // ChangeNotifierProvider(
        //     create: (BuildContext context) => CommunityViewModel()),
      ],
      child: Scaffold(
        bottomNavigationBar: bottomNav(),
        body: Center(
          child: _widgetOptions().elementAt(_selectedIndex),
        ),
      ),
    );
  }

  BottomNavigationBar bottomNav() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey.withOpacity(.60),
      selectedFontSize: 14,
      unselectedFontSize: 12,
      showSelectedLabels: false,
      showUnselectedLabels: false,

      currentIndex: _selectedIndex,
      //현재 선택된 Index
      onTap: (int index) {
        // switch(index){
        //   case 1:
        //     Provider.of<UnivSearchModel>(context,listen: false).InitUnivDatas();
        // }
        setState(() {
          _selectedIndex = index;
        });
      },
      items: const [
        BottomNavigationBarItem(
          label: "홈",

          icon: Icon(Icons.grid_view_outlined,size: 30),
        ),
        BottomNavigationBarItem(
          label: "검색",
          icon: Icon(Icons.drive_file_rename_outline,size: 32,),
        ),
        BottomNavigationBarItem(
          label: "랜덤",
          icon: Icon(Icons.mail_outline,size: 30),
        ),
        // BottomNavigationBarItem(
        //   label: "커뮤니티",
        //   icon: Icon(Icons.question_answer),
        // ),
        BottomNavigationBarItem(
          label: "내 정보",
          // l
          icon: Icon(Icons.account_circle_outlined,size: 34),
        ),
      ],
    );
  }

  List _widgetOptions() {
    return [
      const HomePage(),
      WriteTitle(),
      MessagePage(),
      // const Search(),
      // const RandomFoodSelect(),
      // const Community(),
      const Profile(),
    ];
  }
}
