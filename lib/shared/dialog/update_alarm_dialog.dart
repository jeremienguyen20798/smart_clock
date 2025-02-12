import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_clock/core/extensions/alarm_type_extension.dart';
import 'package:smart_clock/core/utils/string_utils.dart';
import 'package:smart_clock/data/models/alarm.dart';
import 'package:smart_clock/shared/widgets/alarm_countdown/cubit/alarm_countdown_cubit.dart';
import 'package:smart_clock/shared/widgets/alarm_countdown/view/alarm_countdown_view.dart';

import '../../core/constants/app_constants.dart';

class UpdateAlarmDialog extends StatefulWidget {
  final Alarm alarm;

  const UpdateAlarmDialog({super.key, required this.alarm});

  @override
  State<UpdateAlarmDialog> createState() => _UpdateAlarmDialogState();
}

class _UpdateAlarmDialogState extends State<UpdateAlarmDialog> {
  DateTime dateTime = DateTime.now();
  bool isActive = false;
  AlarmType? typeAlarm;
  TextEditingController noteController = TextEditingController();

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) =>
            AlarmCountdownCubit()..startCountdown(dateTime, isActive),
        child: AlertDialog(
          backgroundColor: Colors.white,
          actionsAlignment: MainAxisAlignment.center,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          titlePadding: const EdgeInsets.all(16.0),
          insetPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          title: ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              'editAlarm'.tr(),
              style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: isActive
                ? AlarmCountdownView(
                    isNote: false, dateTime: dateTime, isActive: isActive)
                : null,
            trailing: Switch(
                value: isActive,
                onChanged: (value) {
                  setState(() {
                    isActive = value;
                  });
                }),
          ),
          content: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 100.0,
                  child: CupertinoDatePicker(
                      initialDateTime: dateTime,
                      onDateTimeChanged: (value) {
                        setState(() {
                          dateTime = DateTime(
                              DateTime.now().year,
                              DateTime.now().month,
                              DateTime.now().day,
                              value.hour,
                              value.minute,
                              value.second,
                              value.millisecond,
                              value.microsecond);
                        });
                      },
                      mode: CupertinoDatePickerMode.time,
                      use24hFormat: true),
                ),
                const SizedBox(height: 32.0),
                TextField(
                  controller: noteController,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'inputAlarmNote'.tr(),
                      hintText: 'inputNote'.tr()),
                ),
                const SizedBox(height: 16.0),
                DropdownButtonFormField<AlarmType>(
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'typeRepeatAlarm'.tr()),
                    items: AlarmType.values
                        .map((item) => DropdownMenuItem<AlarmType>(
                            value: item, child: Text(item.content())))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        typeAlarm = value;
                      });
                    },
                    value: typeAlarm),
              ]),
          actions: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    color: Colors.grey.shade200,
                    elevation: 0.0,
                    height: kMinInteractiveDimension,
                    child: Text(
                      'cancel'.tr(),
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: MaterialButton(
                    onPressed: () {
                      setState(() {
                        Navigator.pop(context, {
                          "dateTime": dateTime,
                          "isActive": true,
                          "typeAlarm": typeAlarm,
                          "note": noteController.text
                        });
                      });
                    },
                    elevation: 0.0,
                    height: kMinInteractiveDimension,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    color: Colors.purple,
                    textColor: Colors.white,
                    child: Text(
                      'edit'.tr(),
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ),
                )
              ],
            )
          ],
        ));
  }

  void initData() {
    dateTime = widget.alarm.alarmDateTime;
    isActive = widget.alarm.isActive;
    typeAlarm = StringUtils.alarmTypeValueOf(
        widget.alarm.typeAlarm ?? AppConstants.justOnce);
    noteController.text = widget.alarm.note ?? AppConstants.alarm;
  }
}
