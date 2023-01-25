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
  Future<bool> checkNickName(String nickname) async {
    InMatHttp inMatHttp = InMatHttp(
      Http.post,
      message: "닉네임 중복 체크",
      url: "/account/check-duplication",
      body: {'nickname': nickname},
    );
    return await inMatHttp.execute();
  }

  /// 이 밑으로는 추가 안함 ///


  /// 마이페이지 조회 API
  Future<Map<String, dynamic>> getProfile({required String token}) async {
    InMatHttp inMatHttp = InMatHttp(
      Http.get,
      message: "프로필 불러오기",
      url: "/users/profiles",
      token: token,
    );
    return await inMatHttp.execute();
  }






  ///아이디 중복 체크 API
  Future<String> checkId({required String id}) async {
    InMatHttp inMatHttp = InMatHttp(
      Http.post,
      message: "아이디 중복 체크",
      url: "/users/username",
      body: {'username': id},
      token: InMatAuth.instance?.currentUser?.token,
    );
    return await inMatHttp.execute();
  }


}
