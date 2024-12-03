import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_clock/shared/widgets/alarm_countdown/alarm_countdown_cubit.dart';

import '../../core/constants/app_constants.dart';
import 'alarm_countdown/alarm_countdown_state.dart';

class AlarmNotification extends StatelessWidget {
  final Function() onCancel;

  const AlarmNotification({super.key, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    double baseWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<AlarmCountdownCubit, AlarmCountdownState>(
        builder: (context, state) {
      if (state is TurnOffNotificationState) {
        log("Cancel alarm and disable switch");
        onCancel();
      } else if (state is SuccessAlarmCountdownState) {
        return Container(
            width: baseWidth,
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.blue,
            ),
            child: ListTile(
              leading: const Icon(Icons.access_alarm, color: Colors.white),
              title: const Text(
                AppConstants.ringText,
                style: TextStyle(color: Colors.white, fontSize: 14.0),
              ),
              trailing: TextButton(
                  onPressed: () {
                    context.read<AlarmCountdownCubit>().turnOffNotification();
                  },
                  child: const Text(
                    AppConstants.turnOffNotification,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )),
            ));
      }
      return const SizedBox();
    });
  }
}
