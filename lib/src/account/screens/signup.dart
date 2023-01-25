import 'dart:convert';

import 'package:beontteuk/inmat/auth/inmat_account.dart';
import 'package:beontteuk/inmat/inmat_api/http_module.dart';
import 'package:beontteuk/src/navigation/navigation.dart';
import 'package:beontteuk/utils/toast.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String nickname = '';
  String email = '';
  String password = '';
  String rePassword = '';

  bool checkNickname = false;
  bool checkEmail = true;

  void clickSignUp() async {
    if (nickname == '') {
      Message.showMessage("닉네임을 입력해주세요.");
      return;
    }
    if (!checkNickname) {
      print('닉네임 중복확인을 해주세요');
      Message.showMessage("닉네임 중복확인을 해주세요");
      return;
    }
    if (email == '') {
      Message.showMessage("이메일을 입력해주세요.");
      return;
    }

    if (password == '') {
      Message.showMessage("비밀번호를 입력해주세요.");
      return;
    }


    if (password != rePassword) {
      print('비밀번호가 일치하지 않습니다.');
      Message.showMessage("비밀번호가 일치하지 않습니다.");
      return;
    }

    try {
      var bytes = utf8.encode(password);
      Digest digest = sha1.convert(bytes);
      print(digest.toString());

      print('회원가입: name: 홍길동, password: ${digest.toString()}, email: $email, nickname: $nickname');
      await InMatAccount.registerEmail(
          name: '홍길동', password: digest.toString(), email: email, nickname: nickname);

      Navigator.pop(context);
    } catch (e) {
      print("회원가입 오류: $e");
    }
  }

  void clickNicknameCheck() async {
    if (nickname == '') {
      Message.showMessage("닉네임을 입력해주세요.");
      return;
    }
    checkNickname = await InMatAccount.checkNickName(nickname);
    print(checkNickname);
    if (!checkNickname) {
      Message.showMessage("닉네임을 사용할 수 없습니다.");
    } else {
      Message.showMessage("사용 가능한 닉네임 입니다.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 45.0,
        title: const Text('회원가입'),
        // leadingWidth: 10,
        titleSpacing: 0,
        // leading: Container(color: Colors.blue,),
        // leading: IconButton(
        //   icon:  Icon(Icons.ba),
        //
        //   onPressed: () {
        //     Navigator.pop(context);
        //     // 뒤로가기 버튼 누르면 이동하는 곳
        //   },
        // ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 48),
                  const Text(
                    '우리의 가족이\n되어 주세요.',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.64,
                      color: Color(0xff262626),
                    ),
                  ),
                  const SizedBox(height: 21),
                  const Text(
                    '닉네임',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.32,
                      color: Color(0xff262626),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                    height: 50,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 6, 0),
                            child: TextField(
                              onChanged: (text) {
                                nickname = text;
                                checkNickname = false;
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                filled: true,
                                fillColor: Color(0xfff3f3f3),
                                hintText: '닉네임을 입력하세요.',
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: -0.32,
                                  color: Color(0xff838383),
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => clickNicknameCheck(),
                          child: Container(
                            width: 109,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xff5735e2)),
                            ),
                            child: const Center(
                              child: Text(
                                '중복확인',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: -0.32,
                                  color: Color(0xff5735e2),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                    child: const Text(
                      '이메일',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.32,
                        color: Color(0xff262626),
                      ),
                    ),
                  ),
                  Container(
                    // autogroupcwvv5Qh (LcG1rmQYoLqsMSLp7QCwvV)
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    height: 50,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 6, 0),
                            child: TextField(
                              onChanged: (text) {
                                email = text;
                                checkEmail = false;
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                filled: true,
                                fillColor: Color(0xfff3f3f3),
                                hintText: '이메일을 입력하세요.',
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: -0.32,
                                  color: Color(0xff838383),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 109,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xff5735e2)),
                          ),
                          child: const Center(
                            child: Text(
                              '중복확인',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                letterSpacing: -0.32,
                                color: Color(0xff5735e2),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // yeV (17:882)
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                    child: const Text(
                      '비밀번호',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.32,
                        color: Color(0xff262626),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 6),
                    child: TextField(
                      onChanged: (text) {
                        password = text;
                      },
                      obscureText: true,
                      obscuringCharacter: '*',
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Color(0xfff3f3f3),
                        hintText: '비밀번호를 입력하세요.',
                        hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.32,
                          color: Color(0xff838383),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 27),
                    child: TextField(
                      onChanged: (text) {
                        rePassword = text;
                      },
                      obscureText: true,
                      obscuringCharacter: '*',
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Color(0xfff3f3f3),
                        hintText: '비밀번호를 다시 입력하세요.',
                        hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.32,
                          color: Color(0xff838383),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xff5735e2),
                      borderRadius: BorderRadius.circular(3),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x5e5735e2),
                          offset: Offset(0, 3),
                          blurRadius: 5.5,
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: () => clickSignUp(),
                      child: const Center(
                        child: Text(
                          '회원가입',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.36,
                            color: Color(0xffffffff),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
