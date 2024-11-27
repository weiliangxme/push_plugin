import 'package:intl/intl.dart';

String formatTimestamp(int timestamp) {
  DateTime now = DateTime.now();
  DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);

  if (now.day == date.day && now.month == date.month && now.year == date.year) {
    return DateFormat('HH:mm').format(date);
  } else if (now.difference(date).inDays < 7 && now.year == date.year) {
    return DateFormat('EEEE').format(date);
  } else if (now.year == date.year) {
    return DateFormat('MM/dd').format(date);
  } else {
    return DateFormat('M/d/yyyy').format(date);
  }
}

String formatMessageTimestamp(int timestamp) {
  DateTime now = DateTime.now();
  DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);

  if (now.day == date.day && now.month == date.month && now.year == date.year) {
    return DateFormat('HH:mm').format(date);
  } else if (now.difference(date).inDays < 7 && now.year == date.year) {
    return DateFormat('EEEE HH:mm').format(date);
  } else if (now.year == date.year) {
    return DateFormat('MM/dd HH:mm').format(date);
  } else {
    return DateFormat('M/d/yyyy HH:mm').format(date);
  }
}
