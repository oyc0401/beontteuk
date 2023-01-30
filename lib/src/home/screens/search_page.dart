import 'package:beontteuk/src/home/screens/searchedPage.dart';
import 'package:beontteuk/src/home/widgets/search_input.dart';
import 'package:beontteuk/utils/colorss.dart';
import 'package:beontteuk/utils/letter_space_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);

  String search = '';

  InputController controller = InputController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 45,
        title: Text("검색"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              height: 36,
              child: SearchInput(
                onChanged: (text) {
                  search = text;
                },
                onSubmitted: (text) {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => SearchedPage(
                        text: search,
                      ),
                    ),
                  );
                },
                inputController: controller,
                onClickDelete: () {
                  search = '';
                },
                showDelete: search != "",
              ),
            ),
            SizedBox(
              height: 14,
            ),
            Row(
              children: [
                hashTag("꼬막"),
                hashTag("와사비"),
                hashTag("신박한"),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                hashTag("쫄깃쫄깃"),
                hashTag("존맛"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget hashTag(String tag) {
    return Padding(
      padding: EdgeInsets.only(right: 5.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: () {
          search = tag;
          controller.set(tag);
        },
        child: Ink(
          height: 37,
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Color(0xffECECEC),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Center(
            child: Text(
              "#$tag",
              style: LetterStyle(fontSize: 16, color: Colorss.text1),
            ),
          ),
        ),
      ),
    );
  }
}
