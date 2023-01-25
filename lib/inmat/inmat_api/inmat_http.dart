import 'http_module.dart';
import 'inmat_exception.dart';

enum Http { get, post, patch }

class InMatHttp {
  InMatHttp(
    this.how, {
    required this.url,
    required String? message,
    this.body,
    this.token,
  }) : _message = message ?? "이름없는 http 통신" {
    // 나중에 토큰방식으로 바꾸면 이 코드 삭제 해야함
    body?.addAll({'user_id': token});
  }

  Http how;
  String url;
  Map? body;
  final String _message;
  final String? token;

  String get _url {
    return "http://54.83.101.17:8080$url";
  }

  dynamic execute() async {
    print("$_message 중...");
    Map response = {};

    HttpModule module = HttpModule();
    switch (how) {
      case Http.get:
        response = await module.get(url: _url, token: token);
        break;
      case Http.post:
        response = await module.post(url: _url, body: body, token: token);
        break;
      case Http.patch:
        response = await module.patch(url: _url, body: body, token: token);
        break;
    }
// print(response);

    /// 디버그 할 때 [debug]를 true 로 하면 모든 통신의 값을 출력한다.
    const bool debug = true;
    if (debug) print(response);

    print("$_message 성공!");

    return response["result"];
  }
}

// void main() async {
//   HttpModule module = HttpModule();
//   var response = await module.post(
//     url: 'http://54.83.101.17:8080/account/signup',
//     body: {
//       "nickname": "아아",
//     },
//     token: 'token',
//   );
//
//   print(response);
// }
