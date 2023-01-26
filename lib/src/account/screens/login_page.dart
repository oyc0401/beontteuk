import 'package:beontteuk/src/account/screens/signup.dart';
import 'package:beontteuk/utils/letter_space_text_style.dart';
import 'package:beontteuk/utils/colorss.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/login_model.dart';
import '../widget/text_button.dart';
import '../widget/text_forms.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 45.0,
        title: const Text('로그인'),
        // leadingWidth: 10,
        titleSpacing: 0,
        // leading: Container(color: Colors.blue,),
        // leadingWidth: 40,
        // leading: IconButton(
        //   icon: Icon(Icons.add),
        //   onPressed: () {
        //     Navigator.pop(context);
        //     // 뒤로가기 버튼 누르면 이동하는 곳
        //   },
        // ),
      ),
      body: ChangeNotifierProvider<EmailSignInModel>(
        create: (context) => EmailSignInModel(),
        child: Consumer<EmailSignInModel>(builder: (context, model, child) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 41),
                  const Text(
                    "그대를 기다리고 있었네",
                    style: LetterStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.w700,
                      color: Colorss.text1,
                    ),
                  ),
                  const Text(
                    "설빙 한딸기빙수",
                    style: LetterStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.w700,
                      color: Colorss.text1,
                    ),
                  ),
                  const SizedBox(height: 25),
                  const LoginInputs(),
                  // const AddButton(),
                  const SizedBox(height: 20),
                  const SizedBox(height: 18),
                  LoginButton(
                    onclick: () {
                      Provider.of<EmailSignInModel>(context, listen: false)
                          .login(context);


                    },
                  ),
                  const SizedBox(height: 18),

                  const ForgotBox(),

                  Flexible(
                    child: Container(
                        // color: Colors.blue,
                        ),
                  ),

                  const RegisterButton(),
                  const SizedBox(
                    height: 9,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
    required this.onclick,
  }) : super(key: key);
  final VoidCallback onclick;

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: 45,
      // color: Style.brand,

      decoration: BoxDecoration(
        color: Colorss.brand,
        borderRadius: const BorderRadius.all(Radius.circular(3)),
        boxShadow: [
          BoxShadow(
            color: Colorss.brand.withOpacity(0.6),
            blurRadius: 10,
            offset: const Offset(0, 12),
            // color: Color(0xff00D99E).withOpacity(.6),
            spreadRadius: -10,
          ),
        ],
      ),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(3)),
        onTap: onclick,
        child: const Center(
          child: Text(
            "로그인",
            style: LetterStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class CheckToggle extends StatelessWidget {
  const CheckToggle(
    this.text, {
    Key? key,
    required this.onclick,
    required this.activate,
  }) : super(key: key);
  final String text;
  final VoidCallback onclick;
  final bool activate;

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: 40,
      child: InkWell(
        onTap: onclick,
        child: Row(
          children: [
            Ink(
              height: 20,
              width: 20,
              decoration: activate
                  ? BoxDecoration(
                      color: Colorss.brand,
                      borderRadius: BorderRadius.circular(20),
                    )
                  : BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colorss.line1,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
            ),
            const SizedBox(width: 9),
            Text(
              text,
              style: const LetterStyle(
                fontSize: 16.0,
                color: Colorss.text1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddButton extends StatelessWidget {
  const AddButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      child: Row(
        children: [
          CheckToggle(
            "자동로그인",
            activate: Provider.of<EmailSignInModel>(context).isAutoLogin,
            onclick: () {
              Provider.of<EmailSignInModel>(context, listen: false)
                  .touchAutoLogin();
            },
          ),
          const SizedBox(width: 9),
          const SizedBox(width: 19),
          CheckToggle(
            "아이디 저장",
            activate: Provider.of<EmailSignInModel>(context).isSaveID,
            onclick: () {
              Provider.of<EmailSignInModel>(context, listen: false)
                  .touchSaveID();
            },
          ),
        ],
      ),
    );
  }
}

class ForgotBox extends StatelessWidget {
  const ForgotBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider.of<EmailSignInModel>(context).onceWrong
        ? AnimatedContainer(
            height: Provider.of<EmailSignInModel>(context).onceWrong ? 76 : 76,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(3)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                  // color: Color(0xff00D99E).withOpacity(.6),
                ),
              ],
            ),
            duration: const Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 12),
                const Text(
                  "잠깐! 비밀번호를 잊으셨나요?",
                  style: LetterStyle(
                    fontSize: 16.0,
                    color: Colorss.text1,
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "아이디찾기 ",
                      style: LetterStyle(
                        fontSize: 14,
                        color: Color(0xff4992FF),
                      ),
                    ),
                    Text(
                      "혹은",
                      style:
                          LetterStyle(fontSize: 14, color: Colorss.text2),
                    ),
                    Text(
                      " 비밀번호 찾기",
                      style: LetterStyle(
                        fontSize: 14,
                        color: Color(0xff4992FF),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        : Container();
  }
}

class RegisterButton extends StatelessWidget {
  const RegisterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextMiniButton(
          "회원가입",
          onclick: () {
            Navigator.push(context,
                CupertinoPageRoute(builder: (context) => const SignUpPage()));
          },
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
          style: const LetterStyle(
            fontSize: 14,
            color: Colorss.text2,
          ),
        ),
        Container(
          width: 1,
          height: 11,
          color: Colorss.line2,
        ),
        TextMiniButton(
          "아이디찾기",
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
          onclick: () {},
          style: const LetterStyle(
            fontSize: 14,
            color: Colorss.text2,
          ),
        ),
        Container(
          width: 1,
          height: 11,
          color: Colorss.line2,
        ),
        TextMiniButton(
          "비밀번호 찾기",
          onclick: () {},
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
          style: const LetterStyle(
            fontSize: 14,
            color: Colorss.text2,
          ),
        ),
      ],
    );
  }
}
