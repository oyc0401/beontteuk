import 'package:flutter/widgets.dart';

class WriteModel extends ChangeNotifier {
  WriteModel() {
    print("WriteModel 생성자");
  }

  String _title = "";

  String _overview = "";

  String _description = "";

  int _price = 0;

  int _category = -1;

  String _thumbnail = "";

  bool _is_commercial_available = false;

  bool _is_patent_available = false;

  Future<void> upload() async {
    print("_title: $_title");
    print("_overview: $_overview");
    print("_description: $_description");
    print("_price: $_price");
    print("_category: $_category");
    print("_thumbnail: $_thumbnail");
    print("_is_commercial_available: $_is_commercial_available");
    print("_is_patent_available: $_is_patent_available");
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

  String get description => _description;

  set description(String value) {
    _description = value;
    notifyListeners();
  }

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
}
