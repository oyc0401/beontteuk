import '../inmat_api/inmat_api.dart';

class InMatAccount {
  static registerEmail({
    required String name,
    required String password,
    required String email,
    required String nickname,
  }) async {
    await InMatApi.account.register(
      name: name,
      password: password,
      email: email,
      nickname: nickname,
    );
  }

  static Future<bool> checkNickName(String nickName) async {
    return await InMatApi.account.checkNickName(nickName);
  }

  static Future<bool> checkId({
    required String id,
  }) async {
    String message = await InMatApi.account.checkId(id: id);
    return message == "아이디 사용가능!";
  }
}

