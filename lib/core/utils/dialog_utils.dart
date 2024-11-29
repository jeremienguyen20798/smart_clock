import 'package:flutter/material.dart';
import 'package:smart_clock/data/models/alarm.dart';
import 'package:smart_clock/shared/dialog/update_alarm_dialog.dart';

import '../../shared/dialog/edit_message_dialog.dart';

class DialogUtils {

  static void showEditAlarmDialog(
      BuildContext context, Alarm alarm, Function(Alarm) onEdit) {
    showDialog(
        context: context,
        builder: (_) => UpdateAlarmDialog(alarm: alarm)).then((value) {
      if (value != null && value is Alarm) {
        onEdit(value);
      }
    });
  }

  static void showEditMessageNotiDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => const EditMessageDialog());
  }
}
