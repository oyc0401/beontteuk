import 'package:beontteuk/utils/letter_space_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/colorss.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("받은 쪽지함"),
        toolbarHeight: 45,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(
              height: 16,
            ),

            Text(
              "받은 쪽지함",
              style: const LetterStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colorss.text1,
              ),
            ),


            Row(children: [
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
                    "nickname",
                    style: const LetterStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colorss.text1,
                    ),
                  ),
                  Text(
                    "지난주",
                    style: const LetterStyle(
                      fontSize: 16,
                      // fontWeight: FontWeight.bold,
                      color: Colorss.text2,
                    ),
                  ),
                ],
              ),
            ],),


            // CupertinoButton(
            //   child: Text("쪽지 페이지 이동"),
            //   onPressed: () {
            //     Navigator.push(context,
            //         CupertinoPageRoute(builder: (context) => MessagePage()));
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
