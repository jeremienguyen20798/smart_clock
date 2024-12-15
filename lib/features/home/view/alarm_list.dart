import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_clock/data/models/alarm.dart';
import 'package:smart_clock/features/home/bloc/home_bloc.dart';
import 'package:smart_clock/features/home/bloc/home_state.dart';
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
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      Alarm? alarm;
      if (state is UpdateAlarmState) {
        alarm = state.alarm;
      } else if (state is UpdateAlarmByToggleSwitchState) {
        alarm = state.alarm;
      }
      return alarmList.isNotEmpty
          ? ListView.separated(
              shrinkWrap: true,
              itemCount: alarmList.length,
              itemBuilder: (context, index) {
                return ItemAlarm(
                  alarm: alarm != null
                      ? alarmList[index].alarmId == alarm.alarmId
                          ? alarm
                          : alarmList[index]
                      : alarmList[index],
                  isDelete: deleteList != null && deleteList!.isNotEmpty
                      ? deleteList!.contains(alarmList[index])
                      : null,
                );
              },
              separatorBuilder: (context, index) =>
                  const SizedBox(height: 12.0))
          : const EmptyView();
    });
  }
}
