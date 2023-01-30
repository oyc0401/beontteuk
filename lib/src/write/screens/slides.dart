import 'dart:ui';

import 'package:beontteuk/src/write/image_to_url.dart';
import 'package:beontteuk/src/write/model/write_model.dart';
import 'package:beontteuk/utils/colorss.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'camera.dart';

class SlideWidget extends StatefulWidget {
  SlideWidget({Key? key, required this.widgets}) : super(key: key);

  List<Widget> widgets;

  @override
  State<SlideWidget> createState() => _SlideWidgetState();
}

class _SlideWidgetState extends State<SlideWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widgets = widget.widgets;
  }

  List<Widget> widgets = [];

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.secondary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.secondary.withOpacity(0.15);
    final Color draggableItemColor = colorScheme.secondary;

    Widget proxyDecorator(
        Widget child, int index, Animation<double> animation) {
      return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          final double animValue = Curves.easeInOut.transform(animation.value);
          final double elevation = lerpDouble(0, 6, animValue)!;
          return Material(
            elevation: elevation,
            color: draggableItemColor,
            shadowColor: draggableItemColor,
            child: child,
          );
        },
        child: child,
      );
    }

    return ReorderableListView(
      // padding: const EdgeInsets.symmetric(horizontal: 40),
      proxyDecorator: proxyDecorator,
      children: [
        SizedBox(
          key: Key("abc1"),
          height: 25,
        ),
        Text(
          key: Key("abc2"),
          "아이디어 상세설명",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colorss.text1,
          ),
        ),
        SizedBox(
          key: Key("abc3"),
          height: 12,
        ),

        for (int index = 0; index < widgets.length; index += 1) widgets[index],
        InkWell(
          key: Key("abc4"),
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
          key: Key("abc5"),
          height: 90,
        ),
      ],
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final Widget item = widgets.removeAt(oldIndex);
          widgets.insert(newIndex, item);
        });
      },
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
}
