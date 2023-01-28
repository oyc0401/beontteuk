import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/colorss.dart';
import '../model/write_model.dart';

class WriteCategory extends StatelessWidget {
  WriteCategory({Key? key, required this.writeModel}) : super(key: key);

  final WriteModel writeModel;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WriteModel>.value(
      value: writeModel,
      child: Consumer(
        builder: (context, a, b) {
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 26,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "카테고리",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colorss.text1,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 52,
                    child:
                        ListView(scrollDirection: Axis.horizontal, children: [
                      const SizedBox(
                        width: 10,
                      ),
                      for (int i = 0; i <= 10; i++)
                        Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: InkWell(
                            onTap: () {
                              if (Provider.of<WriteModel>(context,
                                          listen: false)
                                      .category ==
                                  i) {
                                Provider.of<WriteModel>(context, listen: false)
                                    .category = -1;
                              } else {
                                Provider.of<WriteModel>(context, listen: false)
                                    .category = i;
                              }
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
                                    color: Provider.of<WriteModel>(context).category == i
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
                                        fontWeight:
                                            Provider.of<WriteModel>(context).category ==
                                                    i
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 27,
                        ),
                        Text(
                          "아이디어 가격",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colorss.text1,
                          ),
                        ),
                        Container(height: 30, child: TextField()),
                        SizedBox(
                          height: 31,
                        ),
                        Text(
                          "대표 이미지 선택",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colorss.text1,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        InkWell(
                          child: Stack(
                            children: [
                              Ink(
                                height: 188,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.camera_alt_outlined,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                                      Text(
                                        "이미지 업로드",
                                        style: TextStyle(
                                          fontSize: 14,
                                          // fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        Text(
                          "이용 가능 범위",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colorss.text1,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Text(
                              "상업적 용도",
                              style: TextStyle(
                                fontSize: 16,
                                // fontWeight: FontWeight.bold,
                                color: Colorss.text1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Text(
                              "특허 출원",
                              style: TextStyle(
                                fontSize: 16,
                                // fontWeight: FontWeight.bold,
                                color: Colorss.text1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        Text(
                          "해시태그",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colorss.text1,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 46,
                          child: TextField(),
                        ),
                        SizedBox(
                          height: 33,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 16, right: 16, bottom: 23),
                          child: InkWell(
                            onTap: () async{


                              // if(Provider.of<WriteModel>(context,listen: false).description.length==0){
                              //   Message.showMessage("아이디어 설명을 입력하세요");
                              //   return;
                              // }

                              // Navigator.push(
                              //   context,
                              //   CupertinoPageRoute(
                              //     builder: (context) {
                              //       return WriteCategory(writeModel: writeModel);
                              //     },
                              //   ),
                              // );


                             await Provider.of<WriteModel>(context,listen: false).upload();
                            },
                            borderRadius: BorderRadius.circular(4),
                            child: Ink(
                              height: 49,
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  "발행하기",
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
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
