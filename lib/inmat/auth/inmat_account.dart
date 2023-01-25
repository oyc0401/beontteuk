import 'package:beontteuk/inmat/inmat_api/inmat_exception.dart';

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
    try {
      Map map = await InMatApi.account.checkNickName(nickName);
      return map['success'] ?? false;
    } on SignInFailed {
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> checkId({
    required String id,
  }) async {
    String message = await InMatApi.account.checkId(id: id);
    return message == "아이디 사용가능!";
  }
}
