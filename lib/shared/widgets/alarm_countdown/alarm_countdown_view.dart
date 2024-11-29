import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_clock/shared/widgets/alarm_countdown/alarm_countdown_cubit.dart';
import 'package:smart_clock/shared/widgets/alarm_countdown/alarm_countdown_state.dart';

class AlarmCountdown extends StatefulWidget {
  final TextStyle? textStyle;

  const AlarmCountdown({
    super.key,
    this.textStyle,
  });

  @override
  State<AlarmCountdown> createState() => _AlarmCountdownState();
}

class _AlarmCountdownState extends State<AlarmCountdown> {
  @override
  void initState() {
    context.read<AlarmCountdownCubit>().startCountdown();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlarmCountdownCubit, AlarmCountdownState>(
        builder: (context, state) {
      if (state.duration == null) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 6.0),
                height: 12.0,
                width: 1.0,
                color: Colors.grey),
            Text(
              'Đang tính toán...',
              style: widget.textStyle ??
                  const TextStyle(
                      overflow: TextOverflow.ellipsis, fontSize: 14.0),
              maxLines: 1,
            ),
          ],
        );
      }
      if (state.duration == Duration.zero) return const SizedBox();
      final hours = state.duration!.inHours;
      final minutes = state.duration!.inMinutes % 60;
      String countdownText = 'Báo thức sau $hours giờ $minutes phút';
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 6.0),
              height: 12.0,
              width: 1.0,
              color: Colors.grey),
          Text(countdownText,
              style: widget.textStyle ??
                  const TextStyle(overflow: TextOverflow.ellipsis),
              maxLines: 1),
        ],
      );
    });
  }
}
