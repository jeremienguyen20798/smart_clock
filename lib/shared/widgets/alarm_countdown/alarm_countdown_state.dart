class AlarmCountdownState {
  Duration? duration;

  AlarmCountdownState({this.duration});
}

class SuccessAlarmCountdownState extends AlarmCountdownState {}

class TurnOffNotificationState extends AlarmCountdownState {}
