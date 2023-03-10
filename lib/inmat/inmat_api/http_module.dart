import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import 'inmat_exception.dart';

class HttpModule {
  Future<Map> get({
    required String url,
    String? token,
  }) async {
    final Response response = await http.get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    _throwHttpException(response);

    return json.decode(utf8.decode(response.bodyBytes));
  }

  Future<Map> post({
    required String url,
    required Map? body,
    String? token,
  }) async {
    final Response response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(body),
    );

    _throwHttpException(response);

    return json.decode(utf8.decode(response.bodyBytes));
  }

  Future<Map> patch({
    required String url,
    required Map? body,
    required String? token,
  }) async {
    final Response response = await http.patch(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(body),
    );
    _throwHttpException(response);

    return json.decode(utf8.decode(response.bodyBytes));
  }

  void _throwHttpException(Response response) {
    if(!(response.statusCode==200 ||response.statusCode==201)){
      print('예외 code 발생 ${response.statusCode}: ${utf8.decode(response.bodyBytes)}');
    }

    switch (response.statusCode) {
      case 200:
      case 201:
        return;
      case 400:
        throw SignInFailed();
      case 401:
        throw ExpirationAccessToken();
      case 403:
        throw AccessDenied();
      case 2000:
        throw Invalidate();
      case 3010:
        throw SignInFailed();
      case 3030:
        throw OverlappingAccount();
      case 3035:
        throw OverlappingNickName();
      case 4000:
        throw DataBaseFailed();
      default:
        throw Exception(
            'unexpected status code: ${response.statusCode}, ${utf8.decode(response.bodyBytes)}');
    }
  }
}
