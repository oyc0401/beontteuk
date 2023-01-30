import 'package:beontteuk/src/home/screens/home.dart';
import 'package:beontteuk/src/navigation/navigation.dart';
import 'package:beontteuk/src/write/image_to_url.dart';
import 'package:beontteuk/utils/letter_space_text_style.dart';
import 'package:beontteuk/utils/letter_space_text_style.dart';
import 'package:beontteuk/utils/letter_space_text_style.dart';
import 'package:beontteuk/utils/letter_space_text_style.dart';
import 'package:beontteuk/utils/letter_space_text_style.dart';
import 'package:beontteuk/utils/letter_space_text_style.dart';
import 'package:beontteuk/utils/letter_space_text_style.dart';
import 'package:beontteuk/utils/letter_space_text_style.dart';
import 'package:beontteuk/utils/letter_space_text_style.dart';
import 'package:beontteuk/utils/letter_space_text_style.dart';
import 'package:beontteuk/utils/letter_space_text_style.dart';
import 'package:beontteuk/utils/letter_space_text_style.dart';
import 'package:beontteuk/utils/letter_space_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                      style: LetterStyle(
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
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        // for (int i = 0; i <= 10; i++)
                        Category(
                          onclick: () {
                            Provider.of<WriteModel>(context, listen: false)
                                .category = 0;
                          },
                          text: "요리/식품",
                          url: "assets/home/strawberries-1396330_1920.jpg",
                          active:
                              Provider.of<WriteModel>(context, listen: false)
                                      .category ==
                                  0,
                        ),
                        Category(
                          onclick: () {
                            Provider.of<WriteModel>(context, listen: false)
                                .category = 1;
                          },
                          text: "취미",
                          url: "assets/home/knitting-1268932_1920.jpg",
                          active:
                              Provider.of<WriteModel>(context, listen: false)
                                      .category ==
                                  1,
                        ),
                        Category(
                          onclick: () {
                            Provider.of<WriteModel>(context, listen: false)
                                .category = 2;
                          },
                          text: "친환경",
                          url: "assets/home/leaf-1453071_1920.jpg",
                          active:
                              Provider.of<WriteModel>(context, listen: false)
                                      .category ==
                                  2,
                        ),
                        Category(
                          onclick: () {
                            Provider.of<WriteModel>(context, listen: false)
                                .category = 3;
                          },
                          text: "사무",
                          url: "assets/home/laptop-3196481_1920.jpg",
                          active:
                              Provider.of<WriteModel>(context, listen: false)
                                      .category ==
                                  3,
                        ),

                        Category(
                          onclick: () {
                            Provider.of<WriteModel>(context, listen: false)
                                .category = 4;
                          },
                          text: "IT",
                          url: "assets/home/laptop-2620118_1920.jpg",
                          active:
                              Provider.of<WriteModel>(context, listen: false)
                                      .category ==
                                  4,
                        ),
                        Category(
                          onclick: () {
                            Provider.of<WriteModel>(context, listen: false)
                                .category = 5;
                          },
                          text: "패션/의류",
                          url: "assets/home/closet-912694_1920.jpg",
                          active:
                              Provider.of<WriteModel>(context, listen: false)
                                      .category ==
                                  5,
                        ),
                        Category(
                          onclick: () {
                            Provider.of<WriteModel>(context, listen: false)
                                .category = 6;
                          },
                          text: "인테리어",
                          url: "assets/home/living-room-2732939_1920.jpg",
                          active:
                              Provider.of<WriteModel>(context, listen: false)
                                      .category ==
                                  6,
                        ),
                      ],
                    ),
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
                          style: LetterStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colorss.text1,
                          ),
                        ),
                        Container(
                            height: 45,
                            child: TextField(
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^[0-9]*$')),
                              ],
                              onChanged: (text) {
                                if (text != '') {
                                  Provider.of<WriteModel>(context,
                                          listen: false)
                                      .price = int.parse(text);
                                }
                              },

                              keyboardType: TextInputType.number,
                              cursorColor: Colorss.brand,
                              decoration: InputDecoration(
                                hintText: "무료",
                                hintStyle: LetterStyle(
                                  fontSize: 16,
                                  // fontWeight: FontWeight.bold,
                                  color: Colorss.text2,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff262626))),
                                border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff262626))),
                              ),
                            )),
                        SizedBox(
                          height: 31,
                        ),
                        Text(
                          "대표 이미지 선택",
                          style: LetterStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colorss.text1,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        InkWell(
                          onTap: () async {
                            try {
                              ImageToUrl image = ImageToUrl();

                              String url = await image.getUrl();

                              Provider.of<WriteModel>(context, listen: false)
                                  .thumbnail = url;
                            } catch (e) {
                              print(e);
                            }
                          },
                          child: Stack(
                            children: [
                              Container(
                                width: 10000,
                                child: ClipRRect(

                                  borderRadius: BorderRadius.circular(3),
                                  child: Image.network(
                                      Provider.of<WriteModel>(context)
                                          .thumbnail,fit: BoxFit.fitWidth,),
                                ),
                              ),
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    color: Color(0x80000000),
                                    width: double.infinity,
                                    height: double.infinity,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.camera_alt_outlined,
                                          color: Colors.white,
                                          size: 40,
                                        ),
                                        Text(
                                          "이미지 업로드",
                                          style: LetterStyle(
                                            fontSize: 14,
                                            // fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
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
                          style: LetterStyle(
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
                              style: LetterStyle(
                                fontSize: 16,
                                // fontWeight: FontWeight.bold,
                                color: Colorss.text1,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "불가능",
                              style: LetterStyle(
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
                              style: LetterStyle(
                                fontSize: 16,
                                // fontWeight: FontWeight.bold,
                                color: Colorss.text1,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "불가능",
                              style: LetterStyle(
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
                          style: LetterStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colorss.text1,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 37,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              for (String tag
                                  in Provider.of<WriteModel>(context).hashTags)
                                Padding(
                                  padding: EdgeInsets.only(right: 8),
                                  child: InkWell(
                                    onTap: () {
                                      Provider.of<WriteModel>(context,
                                              listen: false)
                                          .hashTags
                                          .remove(tag);
                                      Provider.of<WriteModel>(context,
                                              listen: false)
                                          .setState();
                                    },
                                    child: Ink(
                                      height: 37,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      decoration: BoxDecoration(
                                        color: Color(0xffECECEC),
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "#$tag",
                                          style: LetterStyle(
                                              fontSize: 16,
                                              color: Colorss.text1),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              Container(
                                height: 46,
                                width: 410,
                                child: NewWidget(),
                              ),
                            ],
                          ),
                        ),


                        SizedBox(
                          height: 33,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 16, right: 16, bottom: 23),
                          child: InkWell(
                            onTap: () async {
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

                              await Provider.of<WriteModel>(context,
                                      listen: false)
                                  .upload();

                              Navigator.pushAndRemoveUntil(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => NavigatePage()),
                                  (route) => false);
                              // Navigator.pop(context);
                            },
                            borderRadius: BorderRadius.circular(4),
                            child: Ink(
                              height: 49,
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  "발행하기",
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

class NewWidget extends StatelessWidget {
  NewWidget({
    super.key,
  });

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onSubmitted: (text) {
        Provider.of<WriteModel>(context, listen: false).addHashTag(text);
        controller.text = '';


      },

      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            borderSide:
            BorderSide(color: Color(0xff262626))),
        border: UnderlineInputBorder(
            borderSide:
            BorderSide(color: Color(0xff262626))),
      ),
    );
  }
}
