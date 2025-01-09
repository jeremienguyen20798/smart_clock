import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_clock/shared/widgets/alarm_countdown/cubit/alarm_countdown_cubit.dart';
import 'package:smart_clock/shared/widgets/alarm_countdown/cubit/alarm_countdown_state.dart';

class AlarmCountdownView extends StatefulWidget {
  final DateTime dateTime;
  final bool isActive;
  final bool? isNote;

  const AlarmCountdownView({
    super.key,
    required this.dateTime,
    required this.isActive,
    this.isNote = true,
  });

  @override
  State<AlarmCountdownView> createState() => _AlarmCountdownViewState();
}

class _AlarmCountdownViewState extends State<AlarmCountdownView> {
  DateTime dateTime = DateTime.now();
  bool isActive = false;
  String countdownText = '';

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AlarmCountdownView oldWidget) {
    if (oldWidget.dateTime != widget.dateTime ||
        oldWidget.isActive != widget.isActive) {
      initData();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlarmCountdownCubit, AlarmCountdownState>(
        builder: (context, state) {
      if (state.duration != null) {
        if (state.duration == Duration.zero) {
          countdownText = 'calculating'.tr();
        } else {
          final hours = state.duration!.inHours;
          final minutes = state.duration!.inMinutes % 60;
          countdownText =
              '${'alarmAfter'.tr()} $hours ${'hour'.tr()} $minutes ${'minute'.tr()}';
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.isNote == true
                ? Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6.0),
                    height: 12.0,
                    width: 1.0,
                    color: Colors.grey)
                : const SizedBox(),
            Text(countdownText,
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 1),
          ],
        );
      }
      return const SizedBox();
    });
  }

  void initData() {
    setState(() {
      isActive = widget.isActive;
      dateTime = widget.dateTime;
      context.read<AlarmCountdownCubit>().startCountdown(dateTime, isActive);
    });
  }
}
