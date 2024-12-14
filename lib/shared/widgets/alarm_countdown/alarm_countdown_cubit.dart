import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:smart_clock/core/utils/datetime_utils.dart';
import 'package:smart_clock/shared/widgets/alarm_countdown/alarm_countdown_state.dart';

class AlarmCountdownCubit extends Cubit<AlarmCountdownState> {
  DateTime dateTime;
  Timer? _timer;
  AlarmCountdownCubit(this.dateTime) : super(AlarmCountdownState());

  void startCountdown() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      Duration duration = DateTimeUtils.calculateRemainingTime(dateTime);
      if (duration.inSeconds == 0) {
        timer.cancel();
        emit(SuccessAlarmCountdownState());
      } else {
        emit(AlarmCountdownState(duration: duration));
      }
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
