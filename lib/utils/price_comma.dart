class PriceComma {
  static String getComma(int price) {
    String t = price.toString();

    String value = '';
    bool first=true;
    for (int i = 0; i < t.length; i++) {
      if ((t.length - i) % 3 == 0 &&!first) {
        value += ',';
      }
      first=false;
      value += t[i];
    }

    return value;
  }
}
