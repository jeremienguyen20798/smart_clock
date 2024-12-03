import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_clock/core/utils/string_utils.dart';
import 'package:smart_clock/data/models/alarm.dart';
import 'package:smart_clock/shared/widgets/alarm_countdown/alarm_countdown_cubit.dart';
import 'package:smart_clock/shared/widgets/alarm_countdown/alarm_countdown_view.dart';

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

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => AlarmCountdownCubit(dateTime),
        child: AlertDialog(
          backgroundColor: Colors.white,
          actionsAlignment: MainAxisAlignment.center,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          titlePadding: const EdgeInsets.all(16.0),
          insetPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          title: ListTile(
            contentPadding: EdgeInsets.zero,
            title: RichText(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                text: TextSpan(
                    text: StringUtils.formatTime(widget.alarm.alarmDateTime),
                    style: const TextStyle(
                      fontSize: 24.0,
                      color: Colors.purple,
                    ),
                    children: [
                      TextSpan(
                          text: " ${widget.alarm.note ?? AppConstants.alarm}",
                          style: const TextStyle(
                              fontSize: 18.0, color: Colors.black))
                    ])),
            subtitle: const AlarmCountdownView(),
            trailing: Switch(
                value: isActive,
                onChanged: (value) {
                  setState(() {
                    isActive = value;
                  });
                }),
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 100.0,
            child: CupertinoDatePicker(
                initialDateTime: widget.alarm.alarmDateTime,
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
                    child: const Text(
                      AppConstants.cancel,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: MaterialButton(
                    onPressed: () {
                      setState(() {
                        Navigator.pop(context,
                            {"dateTime": dateTime, "isActive": isActive});
                      });
                    },
                    elevation: 0.0,
                    height: kMinInteractiveDimension,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    color: Colors.purple,
                    textColor: Colors.white,
                    child: const Text(
                      AppConstants.edit,
                      style: TextStyle(fontSize: 16.0),
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
  }
}
