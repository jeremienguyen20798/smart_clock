import 'package:flutter/material.dart';
import 'package:smart_clock/data/models/alarm.dart';
import 'package:smart_clock/shared/dialog/no_internet_dialog.dart';
import 'package:smart_clock/shared/dialog/update_alarm_dialog.dart';

import '../../shared/dialog/edit_message_dialog.dart';

class DialogUtils {
  static void showEditAlarmDialog(
      BuildContext context, Alarm alarm, Function(DateTime, bool) onEdit) {
    showDialog(
        context: context,
        builder: (_) => UpdateAlarmDialog(alarm: alarm)).then((value) {
      if (value != null) {
        final DateTime dateTime = value['dateTime'];
        final bool isActive = value['isActive'];
        onEdit(dateTime, isActive);
      }
    });
  }

  static void showEditMessageNotiDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => const EditMessageDialog());
  }

  static void showNoInternetDialog(BuildContext context) {
    showDialog(context: context, builder: (_) => const NoInternetDialog());
  }
}
