import 'package:beontteuk/utils/colorss.dart';
import 'package:beontteuk/utils/toast.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

import '../image_to_url.dart';
import '../model/write_model.dart';
import 'camera.dart';
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
            // resizeToAvoidBottomInset : false,
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
                    ...contents(context),
                    InkWell(
                      onTap: () {
                        flutterDialog(context);
                      },
                      child: Ink(
                        width: double.infinity,
                        height: 51,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(
                            width: 1,
                            color: Color(0xffDCDCDC),
                          ),
                        ),
                        child: Center(child: Icon(Icons.add)),
                      ),
                    ),
                    SizedBox(
                      height: 90,
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Padding(
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 13),
              child: Material(
                child: InkWell(
                  onTap: () {
                    // if (Provider.of<WriteModel>(context, listen: false)
                    //         .description
                    //         .length ==
                    //     0) {
                    //   Message.showMessage("아이디어 설명을 입력하세요");
                    //   return;
                    // }

                    print(Provider.of<WriteModel>(context, listen: false)
                        .contents);

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
            ),
          );
        },
      ),
    );
  }

  void flutterDialog(BuildContext parentContext) {
    showDialog(
        context: parentContext,
        //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
        // barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            //Dialog Main Title
            contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            content: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: () async {
                      final cameras = await availableCameras();

                      // Get a specific camera from the list of available cameras.
                      final firstCamera = cameras.first;

                      String path = await Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => TakePictureScreen(
                                    camera: firstCamera,
                                  )));

                      // print(path);

                      ImageToUrl image = ImageToUrl();
                      String url = await image.getCameraUrl(path);

                      Provider.of<WriteModel>(parentContext, listen: false)
                          .contents
                          .add(ImagePost(url: url));
                      Provider.of<WriteModel>(parentContext, listen: false)
                          .setState();

                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 54,
                            height: 54,
                            child: SvgPicture.asset(
                                'assets/icons/write_camera.svg'),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "카메라",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colorss.text1,
                                ),
                              ),
                              SizedBox(
                                height: 1,
                              ),
                              Text("직접 찍은 사진 업로드",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colorss.text1,
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: Color(0xffDCDCDC),
                  ),
                  InkWell(
                    onTap: () async {
                      try {
                        ImageToUrl image = ImageToUrl();

                        String url = await image.getUrl();

                        Provider.of<WriteModel>(parentContext, listen: false)
                            .contents
                            .add(ImagePost(url: url));
                        Provider.of<WriteModel>(parentContext, listen: false)
                            .setState();
                      } catch (e) {
                        print(e);
                      }

                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 54,
                            height: 54,
                            child: SvgPicture.asset(
                                'assets/icons/write_gallery.svg'),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "갤러리",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colorss.text1,
                                ),
                              ),
                              SizedBox(
                                height: 1,
                              ),
                              Text("내 파일에서 업로드",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colorss.text1,
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    // margin: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                    height: 1,
                    width: double.infinity,
                    color: Color(0xffDCDCDC),
                  ),
                  InkWell(
                    onTap: () {
                      Provider.of<WriteModel>(parentContext, listen: false)
                          .contents
                          .add(TextPost());
                      Provider.of<WriteModel>(parentContext, listen: false)
                          .setState();

                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 54,
                            height: 54,
                            child:
                                SvgPicture.asset('assets/icons/write_text.svg'),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "글 추가",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colorss.text1,
                                ),
                              ),
                              SizedBox(
                                height: 1,
                              ),
                              Text("텍스트 입력",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colorss.text1,
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  List<Widget> contents(BuildContext context) {
    List<Widget> result = [];

    for (int i = 0; i < Provider.of<WriteModel>(context).contents.length; i++) {
      Post post = Provider.of<WriteModel>(context).contents[i];

      switch (post.postType) {
        case PostType.text:
          result.add(Padding(
            padding: const EdgeInsets.only(bottom: 9.0),
            child: PostField(
              index: i,
            ),
          ));
          break;
        case PostType.image:
          result.add(Padding(
            padding: const EdgeInsets.only(bottom: 9.0),
            child: ImageView(
              index: i,
              url: post.url,
            ),
          ));
          break;
        case PostType.blank:
          result.add(Container());
          break;
      }
    }
    return result;
  }
}

class PostField extends StatelessWidget {
  const PostField({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextField(
          onChanged: (text) {
            Provider.of<WriteModel>(context, listen: false)
                .contents[index]
                .text = text;
          },
          cursorColor: Colorss.brand,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          // maxLines: 100,
          // maxLengthEnforcement: MaxLengthEnforcement.enforced,
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.only(left: 11, right: 11, top: 12, bottom: 16),
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
        Ink(
          color: Color(0xffF3F3F3),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  Provider.of<WriteModel>(context, listen: false)
                      .contents[index] = BlankPost();
                  Provider.of<WriteModel>(context, listen: false).setState();
                },
                child: Ink(
                  color: Color(0xffF3F3F3),
                  padding:
                      EdgeInsets.only(left: 10, right: 10, bottom: 9, top: 0),
                  child: Text(
                    "삭제하기",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: Color(0xff838383),
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ImageView extends StatelessWidget {
  const ImageView({Key? key, required this.url, required this.index})
      : super(key: key);

  final String url;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          child: Image.network(url),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: InkWell(
            onTap: () {
              Provider.of<WriteModel>(context, listen: false).contents[index] =
                  BlankPost();
              Provider.of<WriteModel>(context, listen: false).setState();
            },
            child: Text(
              "삭제하기",
              style: TextStyle(
                color: Color(0xff838383),
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
