import 'package:beontteuk/utils/colorss.dart';
import 'package:beontteuk/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

import '../model/write_model.dart';
import 'write_category.dart';

class WriteContext extends StatelessWidget {
  const WriteContext({Key? key, required this.writeModel}) : super(key: key);

  final WriteModel writeModel;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WriteModel>.value(
      value: writeModel,
      child: Consumer(
        builder: (context, a, b) {
          return Scaffold(
            appBar: AppBar(title: const Text('글 작성')),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      "아이디어 상세설명",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colorss.text1,
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    TextField(
                      onChanged: (text) {
                        Provider.of<WriteModel>(context, listen: false)
                            .description = text;
                      },
                      cursorColor: Colorss.brand,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      // maxLines: 100,
                      // maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            left: 11, right: 11, top: 12, bottom: 16),
                        filled: true,
                        fillColor: Color(0xffF3F3F3),
                        hintText: "아이디어의 상세 설명을 적어주세요.",
                        hintStyle: TextStyle(
                          fontSize: 16,
                          // fontWeight: FontWeight.bold,
                          color: Colorss.text2,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Padding(
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 13),
              child: InkWell(
                onTap: () {
                  if(Provider.of<WriteModel>(context,listen: false).description.length==0){
                    Message.showMessage("아이디어 설명을 입력하세요");
                    return;
                  }

                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) {
                        return WriteCategory(writeModel: writeModel);
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
                      style: TextStyle(
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
        },
      ),
    );
  }
}
