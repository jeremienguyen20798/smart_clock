import 'package:smart_clock/data/models/alarm.dart';

abstract class HomeEvent {}

class RequestPermissionEvent extends HomeEvent {}

class GetAlarmListEvent extends HomeEvent {}

class OnLongClickItemEvent extends HomeEvent {
  Alarm alarm;

  OnLongClickItemEvent(this.alarm);
}

class OnCancelDeleteAlarmEvent extends HomeEvent {}

class OnConfirmDeleteAlarmEvent extends HomeEvent {
  List<Alarm> alarmList;

  OnConfirmDeleteAlarmEvent(this.alarmList);
}

class OnGetTextFromSpeechEvent extends HomeEvent {}

class OnRecognizeTextEvent extends HomeEvent {
  final String text;

  OnRecognizeTextEvent(this.text);
}

class OnCreateAlarmBySpeechEvent extends HomeEvent {
  String prompt;

  OnCreateAlarmBySpeechEvent(this.prompt);
}

class OnHandleErrorEvent extends HomeEvent {}

class OnUpdateAlarmEvent extends HomeEvent {
  String idAlarm;
  DateTime dateTime;
  bool isActive;
  AlarmType alarmType;
  String note;

  OnUpdateAlarmEvent(
      this.idAlarm, this.dateTime, this.isActive, this.alarmType, this.note);
}

class OnControlAlarmByToggleSwitchEvent extends HomeEvent {
  Alarm alarm;
  bool isActive;

  OnControlAlarmByToggleSwitchEvent(this.alarm, this.isActive);
}

class OnReloadAlarmListEvent extends HomeEvent {}

class OnShowAlertDialogEvent extends HomeEvent {
  final bool isShowDialog;

  OnShowAlertDialogEvent(this.isShowDialog);
}

class OnCancelAlertDialogEvent extends HomeEvent {}
