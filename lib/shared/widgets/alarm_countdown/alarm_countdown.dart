import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_clock/data/models/alarm.dart';
import 'package:smart_clock/features/home/bloc/home_bloc.dart';
import 'package:smart_clock/shared/widgets/alarm_countdown/cubit/alarm_countdown_cubit.dart';
import 'package:smart_clock/shared/widgets/alarm_countdown/view/alarm_countdown_view.dart';

class AlarmCountdown extends StatelessWidget {
  final Alarm alarm;

  const AlarmCountdown({super.key, required this.alarm});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => AlarmCountdownCubit()),
          BlocProvider(create: (_) => HomeBloc()),
        ],
        child: AlarmCountdownView(
            dateTime: alarm.alarmDateTime, isActive: alarm.isActive));
  }
}
