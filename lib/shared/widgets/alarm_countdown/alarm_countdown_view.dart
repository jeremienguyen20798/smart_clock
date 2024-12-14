import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_clock/shared/widgets/alarm_countdown/alarm_countdown_cubit.dart';
import 'package:smart_clock/shared/widgets/alarm_countdown/alarm_countdown_state.dart';

class AlarmCountdownView extends StatefulWidget {
  final TextStyle? textStyle;
  final bool? isNote;

  const AlarmCountdownView({
    super.key,
    this.textStyle,
    this.isNote,
  });

  @override
  State<AlarmCountdownView> createState() => _AlarmCountdownViewState();
}

class _AlarmCountdownViewState extends State<AlarmCountdownView> {
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
            widget.isNote == true
                ? Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6.0),
                    height: 12.0,
                    width: 1.0,
                    color: Colors.grey)
                : const SizedBox(),
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
          widget.isNote == true
              ? Container(
                  margin: const EdgeInsets.symmetric(horizontal: 6.0),
                  height: 12.0,
                  width: 1.0,
                  color: Colors.grey)
              : const SizedBox(),
          Text(countdownText,
              style: widget.textStyle ??
                  const TextStyle(overflow: TextOverflow.ellipsis),
              maxLines: 1),
        ],
      );
    });
  }
}
