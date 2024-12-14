import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_clock/shared/widgets/alarm_countdown/alarm_countdown_cubit.dart';
import 'package:smart_clock/shared/widgets/alarm_countdown/alarm_countdown_state.dart';

import '../../core/constants/app_constants.dart';

class AlarmNotification extends StatelessWidget {
  const AlarmNotification({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<AlarmCountdownCubit, AlarmCountdownState>(
        builder: (context, state) {
      Duration duration = state.duration ?? Duration.zero;
      log("Duration log: $duration");
      if (state.duration == null) return const SizedBox();
      if (state is SuccessAlarmCountdownState) {
        return Container(
            width: baseWidth,
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.blue,
            ),
            child: const ListTile(
                leading: Icon(Icons.access_alarm, color: Colors.white),
                title: Text(
                  AppConstants.ringText,
                  style: TextStyle(color: Colors.white, fontSize: 14.0),
                )));
      }
      return const SizedBox();
    });
  }
}
