import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:smart_clock/core/utils/datetime_utils.dart';
import 'package:smart_clock/shared/widgets/alarm_countdown/cubit/alarm_countdown_state.dart';

class AlarmCountdownCubit extends Cubit<AlarmCountdownState> {
  Timer? _timer;
  AlarmCountdownCubit() : super(AlarmCountdownState(duration: Duration.zero));

  void startCountdown(DateTime dateTime, bool isActive) {
    _timer?.cancel();
    if (isActive) {
      _timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
        Duration duration = DateTimeUtils.calculateRemainingTime(dateTime);
        if (duration.inMilliseconds == 0) {
          _timer?.cancel();
          emit(SuccessAlarmCountdownState());
        } else {
          emit(AlarmCountdownState(duration: duration));
        }
      });
    }
    emit(AlarmCountdownState());
  }

  void turnOffNotification() {
    emit(TurnOffNotificationState());
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
