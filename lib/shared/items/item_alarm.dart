import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_clock/core/constants/app_constants.dart';
import 'package:smart_clock/core/extensions/alarm_type_extension.dart';
import 'package:smart_clock/core/utils/dialog_utils.dart';
import 'package:smart_clock/core/utils/string_utils.dart';
import 'package:smart_clock/features/home/bloc/home_bloc.dart';
import 'package:smart_clock/shared/widgets/alarm_countdown/alarm_countdown_cubit.dart';
import 'package:smart_clock/shared/widgets/alarm_countdown/alarm_countdown_view.dart';
import 'package:smart_clock/shared/widgets/alarm_notification.dart';

import '../../data/models/alarm.dart';
import '../../features/home/bloc/home_event.dart';

class ItemAlarm extends StatefulWidget {
  final Alarm alarm;
  final bool? isDelete;

  const ItemAlarm({
    super.key,
    required this.alarm,
    this.isDelete,
  });

  @override
  State<ItemAlarm> createState() => _ItemAlarmState();
}

class _ItemAlarmState extends State<ItemAlarm> {
  bool isAlarmActive = false;

  @override
  void initState() {
    isAlarmActive = widget.alarm.isActive;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => AlarmCountdownCubit(widget.alarm.alarmDateTime),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const AlarmNotification(),
            ListTile(
              onLongPress: () {
                context
                    .read<HomeBloc>()
                    .add(OnLongClickItemEvent(widget.alarm));
              },
              onTap: () {
                DialogUtils.showEditAlarmDialog(context, widget.alarm, (alarm) {
                  context.read<HomeBloc>().add(OnUpdateAlarmEvent(alarm));
                });
              },
              title: RichText(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                      text: StringUtils.formatTime(widget.alarm.alarmDateTime),
                      style: const TextStyle(
                        fontSize: 24.0,
                        color: Colors.black,
                      ),
                      children: [
                        const TextSpan(text: AppConstants.space),
                        TextSpan(
                            text: widget.alarm.note ?? AppConstants.alarm,
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey,
                            )),
                      ])),
              subtitle: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(widget.alarm.typeAlarm ?? AlarmType.justonce.content(),
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                      )),
                  const Expanded(
                    child: AlarmCountdown(
                        textStyle: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                      overflow: TextOverflow.ellipsis,
                    )),
                  )
                ],
              ),
              trailing: widget.isDelete == null
                  ? Switch(
                      value: isAlarmActive,
                      onChanged: (value) {
                        setState(() {
                          isAlarmActive = value;
                          context
                              .read<HomeBloc>()
                              .add(OnCancelAlarmEvent(widget.alarm, value));
                        });
                      })
                  : Checkbox(
                      value: widget.isDelete,
                      onChanged: (value) {
                        context
                            .read<HomeBloc>()
                            .add(OnLongClickItemEvent(widget.alarm));
                      }),
            ),
          ],
        ));
  }
}