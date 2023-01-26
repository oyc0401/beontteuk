import 'package:intl/intl.dart';

class DateParse {
  DateParse._();

  static String toDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    return formattedDate;
  }

  static String toKorean(String date) {
    DateTime dateTime = DateTime.parse(date);
    DateTime now = DateTime.now();

    Duration duration = now.difference(dateTime);

    int second = duration.inSeconds;
    if (second < 60) {
      return '$second초 전';
    }

    int minute = duration.inMinutes;
    if (minute < 60) {
      return '$minute분 전';
    }

    int hour = duration.inHours;
    if (hour < 12) {
      return '$hour시간 전';
    }

    int day = duration.inDays;
    if (day < 31) {
      return '$day일 전';
    }

    return toDate(date);
  }
}
