import 'dart:ui';

import 'package:beontteuk/src/write/screens/write_context.dart';
import 'package:beontteuk/utils/colorss.dart';
import 'package:beontteuk/utils/letter_space_text_style.dart';
import 'package:beontteuk/utils/letter_space_text_style.dart';
import 'package:beontteuk/utils/letter_space_text_style.dart';
import 'package:beontteuk/utils/letter_space_text_style.dart';
import 'package:beontteuk/utils/letter_space_text_style.dart';
import 'package:beontteuk/utils/letter_space_text_style.dart';
import 'package:beontteuk/utils/letter_space_text_style.dart';
import 'package:beontteuk/utils/letter_space_text_style.dart';
import 'package:beontteuk/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/write_model.dart';

class WriteTitle extends StatelessWidget {
  WriteTitle({super.key});

  WriteModel writeModel = WriteModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WriteModel>(
      create: (BuildContext context) => writeModel,
      child: Consumer(builder: (context, a, s) {
        return Scaffold(
          resizeToAvoidBottomInset : false,
          appBar: AppBar(title: const Text('글 작성')),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 39,
                ),
                Text(
                  "아이디어 업로드\n독려 문구",
                  style: LetterStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colorss.text1,
                  ),
                ),
                SizedBox(
                  height: 41,
                ),
                Text(
                  "아이디어 제목",
                  style: LetterStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colorss.text1,
                  ),
                ),
                TextField(
                  onChanged: (text) {
                    Provider.of<WriteModel>(context, listen: false).title =
                        text;
                  },
                  cursorColor: Colorss.brand,

                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        Provider.of<WriteModel>(context, listen: false).title =
                            '';
                      },
                      icon: Icon(Icons.cancel,color: Color(0xffEAEAEA),),
                    ),

                    hintText: "제목을 입력하세요. (30자 내외)",
                    hintStyle: LetterStyle(
                      fontSize: 16,
                      // fontWeight: FontWeight.bold,
                      color: Colorss.text2,
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff262626))),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff262626))),
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "${Provider.of<WriteModel>(context).title.length}자 / 30자",
                      style: LetterStyle(
                        fontSize: 14,
                        // fontWeight: FontWeight.bold,
                        color: Colorss.text1,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "아이디어 요약",
                  style: LetterStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colorss.text1,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                TextField(
                  onChanged: (text) {
                    Provider.of<WriteModel>(context, listen: false).overview =
                        text;
                  },
                  cursorColor: Colorss.brand,
                  maxLines: 5,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                        left: 11, right: 11, top: 12, bottom: 16),
                    filled: true,
                    fillColor: Color(0xffF3F3F3),
                    hintText: "아이디어의 특징을 간단히 요약해 주세요. (150자 내외)",
                    hintStyle: LetterStyle(
                      fontSize: 16,
                      // fontWeight: FontWeight.bold,
                      color: Colorss.text2,
                    ),
                    border: InputBorder.none,
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "${Provider.of<WriteModel>(context).overview.length}자 / 150자",
                      style: LetterStyle(
                        fontSize: 14,
                        // fontWeight: FontWeight.bold,
                        color: Colorss.text1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Padding(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 13),
            child: InkWell(
              onTap: () {
                if(Provider.of<WriteModel>(context,listen: false).title.length==0){
                  Message.showMessage("제목을 입력하세요");
                  return;
                }
                if(Provider.of<WriteModel>(context,listen: false).overview.length==0){
                  Message.showMessage("아이디어 요약을 입력하세요");
                  return;
                }


                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) {
                      return WriteContext(writeModel: writeModel);
                    },
                  ),
                );
              },
              borderRadius: BorderRadius.circular(4),
              child: Ink(
                height: 49,
                width: double.infinity,
                child: Center(
                  child: Text(
                    "다음",
                    style: LetterStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colorss.brand,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
