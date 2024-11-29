import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:smart_clock/data/models/alarm.dart';

class StringUtils {
  static String formatTime(DateTime dateTime) {
    final timeFormat = DateFormat('HH:mm');
    return timeFormat.format(dateTime);
  }

  static String formatDateToStr(DateTime dateTime) {
    final dateFormat = DateFormat('dd/mm/yyyy');
    return dateFormat.format(dateTime);
  }

  static Alarm? convertResponseToAlarm(String? json) {
    if (json == null) {
      return null;
    }
    final result =
        json.replaceAll(RegExp(r'```'), "").trim().replaceAll('json', '');
    final alarm = Alarm.fromJson(jsonDecode(result));
    return alarm;
  }
}
