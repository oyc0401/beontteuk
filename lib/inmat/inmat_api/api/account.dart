part of '../inmat_api.dart';

class AccountApi {
  ///로그인 API
  Future<Map<String, dynamic>> signIn(
      {required String email, required String password}) async {
    InMatHttp inMatHttp = InMatHttp(
      Http.post,
      message: "로그인",
      url: "/account/signin",
      body: {
        "email": email,
        "password": password,
      },
    );
    return await inMatHttp.execute();
  }

  ///회원 가입 API
  Future<void> register({
    required String name,
    required String password,
    required String email,
    required String nickname,
  }) async {
    InMatHttp inMatHttp = InMatHttp(
      Http.post,
      message: "회원가입",
      url: "/account/signup",
      body: {
        "name": name,
        "email": email,
        "password": password,
        "password_check": password,
        "nickname": nickname,
        "nickname_validate": true,
      },
    );
    return await inMatHttp.execute();
  }

  ///닉네임 중복 체크 API
  Future<Map> checkNickName(String nickname) async {
    InMatHttp inMatHttp = InMatHttp(
      Http.post,
      message: "닉네임 중복 체크",
      url: "/account/check-duplication-nickname",
      body: {'nickname': nickname},
    );
    return await inMatHttp.execute();
  }

  ///이메일 중복 체크 API
  Future<bool> checkEmail(String email) async {
    InMatHttp inMatHttp = InMatHttp(
      Http.post,
      message: "이메일 중복 체크",
      url: "/account/check-duplication-email",
      body: {'email': email},
    );
    return await inMatHttp.execute();
  }

  /// 마이페이지 조회 API
  Future<Map<String, dynamic>> getProfile({required String token}) async {
    InMatHttp inMatHttp = InMatHttp(
      Http.get,
      message: "프로필 불러오기",
      url: "/userinfo/$token",
      token: token,
    );
    List list=await inMatHttp.execute();
    if(list.isEmpty){
      throw ExpirationAccessToken();
    }
    return list[0];
  }

  /// 이 밑으로는 추가 안함 ///













}
