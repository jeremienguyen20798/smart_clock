import 'package:flutter/material.dart';
import 'package:smart_clock/data/models/alarm.dart';
import 'package:smart_clock/shared/dialog/ringtone_player_dialog.dart';
import 'package:smart_clock/shared/dialog/update_alarm_dialog.dart';
import 'package:smart_clock/shared/widgets/warning_dialog.dart';

class DialogUtils {
  static void showEditAlarmDialog(BuildContext context, Alarm alarm,
      Function(DateTime, bool, AlarmType) onEdit) {
    showDialog(
        context: context,
        builder: (_) => UpdateAlarmDialog(alarm: alarm)).then((value) {
      if (value != null) {
        final DateTime dateTime = value['dateTime'];
        final bool isActive = value['isActive'];
        final AlarmType type = value['typeAlarm'];
        onEdit(dateTime, isActive, type);
      }
    });
  }

  static void showAlertDialog(BuildContext context, String title,
      String content, Function() onSettings, Function() onCancel) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return WarningDialog(title: title, content: content);
        }).then((value) {
      if (value != null) {
        onSettings();
      } else {
        onCancel();
      }
    });
  }

  static void showPlayerDialog(
      BuildContext context, String nameRingtone, String url) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return RingtonePlayerDialog(name: nameRingtone, ringtoneUrl: url);
        });
  }
}
