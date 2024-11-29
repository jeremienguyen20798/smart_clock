import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_clock/core/utils/string_utils.dart';
import 'package:smart_clock/data/models/alarm.dart';

import '../../core/constants/app_constants.dart';

class UpdateAlarmDialog extends StatefulWidget {
  final Alarm alarm;

  const UpdateAlarmDialog({super.key, required this.alarm});

  @override
  State<UpdateAlarmDialog> createState() => _UpdateAlarmDialogState();
}

class _UpdateAlarmDialogState extends State<UpdateAlarmDialog> {
  DateTime dateTime = DateTime.now();
  Alarm? updateAlarm;

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      actionsAlignment: MainAxisAlignment.center,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      title: Text(
        StringUtils.formatTime(dateTime),
        style: const TextStyle(
          fontSize: 24.0,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SizedBox(
        height: 200.0,
        child: CupertinoDatePicker(
            initialDateTime: updateAlarm?.alarmDateTime,
            onDateTimeChanged: (value) {
              setState(() {
                dateTime = value;
              });
            },
            mode: CupertinoDatePickerMode.time,
            use24hFormat: true),
      ),
      actions: [
        MaterialButton(
          onPressed: () {
            updateAlarm?.alarmDateTime = dateTime;
            Navigator.pop(context, updateAlarm);
          },
          elevation: 0.0,
          minWidth: MediaQuery.of(context).size.width,
          height: kMinInteractiveDimension,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          color: Colors.purple,
          textColor: Colors.white,
          child: const Text(
            AppConstants.edit,
            style: TextStyle(fontSize: 16.0),
          ),
        )
      ],
    );
  }

  void initData() {
    dateTime = widget.alarm.alarmDateTime;
    updateAlarm = widget.alarm;
  }
}
