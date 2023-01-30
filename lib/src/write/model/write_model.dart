import 'dart:convert';

import 'package:beontteuk/inmat/auth/inmat_auth.dart';
import 'package:beontteuk/inmat/inmat_api/inmat_api.dart';
import 'package:flutter/widgets.dart';

enum PostType { text, image, blank }

class Post {
  Post(this.postType, {
    this.text = '',
    this.url =
    'https://e7.pngegg.com/pngimages/739/17/png-clipart-product-design-rectangle-gray-walls-angle-rectangle.png',
  });

  PostType postType;

  String text;

  String url;

// @override
// String toString() {
//   // TODO: implement toString
//   return 'postType: $postType, text: $text, url: $url';
//
// }
}

class TextPost extends Post {
  TextPost() : super(PostType.text);

  @override
  String toString() {
    return 'TextPost(text: $text)';
  }
}

class ImagePost extends Post {
  ImagePost({super.url}) : super(PostType.image);

  @override
  String toString() {
    return 'ImagePost(url: $url)';
  }
}

class BlankPost extends Post {
  BlankPost() : super(PostType.blank);

  @override
  String toString() {
    return 'BlankPost()';
  }
}

class WriteModel extends ChangeNotifier {
  WriteModel() {
    print("WriteModel 생성자");
  }

  List<Post> _contents = [TextPost()];

  List<String> _hashTags =  []; //['꼬막', '와사비', "신박한", "쫄깃쫄깃", "존맛"];

  List<Post> get contents => _contents;

  set contents(List<Post> value) {
    _contents = value;
    notifyListeners();
  } // String _description = "";

  String _title = "";

  String _overview = "";

  int _price = 0;

  int _category = 0;

  String _thumbnail ='https://inmat.s3.ap-northeast-1.amazonaws.com/Rectangle+288.png';
      // "https://inmat.s3.ap-northeast-1.amazonaws.com/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA+2023-01-29+%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE+9.40.27.png";
  bool _is_commercial_available = false;

  bool _is_patent_available = false;

  Future<void> upload() async {
    // _hashTags=['해시태그 1', "해시태그 2"];
    print("_title: $_title");
    print("_overview: $_overview");
    // print("_description: $_description");
    print("_price: $_price");
    print("_category: $_category");
    print("_thumbnail: $_thumbnail");
    print("_is_commercial_available: $_is_commercial_available");
    print("_is_patent_available: $_is_patent_available");

    Map<String, List> contentsMap = {
      "content": [],
      "hashTags": _hashTags,
    };

    for (Post post in _contents) {
      switch (post.postType) {
        case PostType.text:
          Map m = {"type": "text", "content": post.text};
          contentsMap['content']?.add(m);
          break;
        case PostType.image:
          Map m = {"type": "image", "content": post.url};
          contentsMap['content']?.add(m);
          break;
        case PostType.blank:
          break;
      }
    }

    print(contentsMap);

    String jsoned = jsonEncode(contentsMap);
    // print(jsoned);


   await InMatApi.community.writePost(user_id: int.parse(InMatAuth.instance.currentUser?.token??'1'),
        title: title,
        overview: overview,
        description: jsoned,
        price: price,
        category: category,
        thumbnail: thumbnail,
        is_commercial_available: is_commercial_available,
        is_patent_available: is_patent_available);
  }

  String get title => _title;

  set title(String value) {
    _title = value;
    notifyListeners();
  }

  String get overview => _overview;

  set overview(String valueString) {
    _overview = valueString;
    notifyListeners();
  }

  //
  // String get description => _description;
  //
  // set description(String value) {
  //   _description = value;
  //   notifyListeners();
  // }

  int get price => _price;

  set price(int value) {
    _price = value;
    notifyListeners();
  }

  int get category => _category;

  set category(int value) {
    _category = value;
    notifyListeners();
  }

  String get thumbnail => _thumbnail;

  set thumbnail(String value) {
    _thumbnail = value;
    notifyListeners();
  }

  bool get is_commercial_available => _is_commercial_available;

  set is_commercial_available(bool value) {
    _is_commercial_available = value;
    notifyListeners();
  }

  bool get is_patent_available => _is_patent_available;

  set is_patent_available(bool value) {
    _is_patent_available = value;
    notifyListeners();
  }



  addHashTag(String hashTag){
    _hashTags.add(hashTag);
    notifyListeners();
  }
  List<String> get hashTags => _hashTags;

  setState() {
    notifyListeners();
  }
}
