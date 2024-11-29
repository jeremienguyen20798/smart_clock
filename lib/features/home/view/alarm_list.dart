import 'package:flutter/material.dart';
import 'package:smart_clock/data/models/alarm.dart';
import 'package:smart_clock/shared/widgets/empty_view.dart';

import '../../../shared/items/item_alarm.dart';

class AlarmList extends StatelessWidget {
  final List<Alarm> alarmList;
  final List<Alarm>? deleteList;

  const AlarmList({
    super.key,
    required this.alarmList,
    this.deleteList,
  });

  @override
  Widget build(BuildContext context) {
    return alarmList.isNotEmpty
        ? ListView.separated(
            shrinkWrap: true,
            itemCount: alarmList.length,
            itemBuilder: (context, index) {
              return ItemAlarm(
                alarm: alarmList[index],
                isDelete: deleteList != null && deleteList!.isNotEmpty
                    ? deleteList!.contains(alarmList[index])
                    : null,
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 12.0))
        : const EmptyView();
  }
}
