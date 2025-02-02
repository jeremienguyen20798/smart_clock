import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:smart_clock/data/models/alarm.dart';
import 'package:uuid/uuid.dart';

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

  static String generateAlarmIdStr() {
    return const Uuid().v1();
  }

  // static String enumValueOf(String name) {
  //   final result = AlarmType.values.firstWhere((e) => e.name == name);
  //   return result.content();
  // }

  static AlarmType alarmTypeValueOf(String name) {
    final result = AlarmType.values.firstWhere((e) => e.name == name);
    return result;
  }

  static String formatRingtoneDuration(Duration? duration) {
    if (duration == null) {
      return '00:00';
    }
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
