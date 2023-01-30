import 'package:beontteuk/inmat/auth/inmat_auth.dart';
import 'package:beontteuk/inmat/inmat_api/inmat_api.dart';
import 'package:beontteuk/src/message/writeMail.dart';
import 'package:beontteuk/utils/letter_space_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/colorss.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  List mails = [
    // {
    //   "index": 1,
    //   "from_id": 1234,
    //   "to_id": 1234,
    //   "description": "string",
    //   "sended": "2023-01-26T13:29:20.803Z"
    // }
  ];

  init() async {
    mails = await InMatApi.community
        .getMail(int.parse(InMatAuth.instance.currentUser!.token));
  }

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 16,
            ),

            Text(
              "받은 쪽지함",
              style: LetterStyle(
                color: Colorss.text1,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),

            mails.isEmpty
                ? Expanded(
                    child: Center(
                        child: Text(
                      "쪽지가 없습니다.",
                      style: LetterStyle(
                        color: Colorss.text1,
                        fontSize: 14,
                        // fontWeight: FontWeight.bold,
                      ),
                    )),
                  )
                : Column(
                    children: [
                      for (Map map in mails)
                        MailBox(
                          image: "dsada",
                          description: map['description'],
                          sended: map['sended'],
                          user_id: map['from_id'],
                          to_user_id: map['to_id'],
                        ),
                    ],
                  )

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

class MailBox extends StatelessWidget {
  const MailBox(
      {Key? key,
      required this.description,
      required this.sended,
      required this.image,
      required this.to_user_id,
      required this.user_id})
      : super(key: key);

  // final int index;
  // final int from_id;
  // final int to_id;

  final String description;
  final String sended;

  final String image;

  final int to_user_id;
  final int user_id;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => WriteMail(text: '쪽지보내기',

                    )));
      },
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 47,
                height: 47,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
                child: Text(image),
              ),
              const SizedBox(
                width: 14,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'nickname',
                    style: const LetterStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colorss.text1,
                    ),
                  ),
                  Text(
                    "가입일 $sended",
                    style: const LetterStyle(
                      fontSize: 14,
                      // fontWeight: FontWeight.bold,
                      color: Colorss.text2,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 7,
          ),
          Container(
            width: double.infinity,
            color: Color(0xffF3F3F3),
            margin: EdgeInsets.only(bottom: 16),
            padding: EdgeInsets.symmetric(horizontal: 13, vertical: 16),
            child: Text(description),
          )
        ],
      ),
    );
  }
}
