import 'package:equatable/equatable.dart';
import 'package:smart_clock/data/models/alarm.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitHomeState extends HomeState {}

class RequestPermissionState extends HomeState {}

class GetAlarmListState extends HomeState {
  final List<Alarm> alarms;

  GetAlarmListState(this.alarms);

  @override
  List<Object?> get props => [alarms];
}

class CancelDeleteAlarmState extends HomeState {
  final List<Alarm> deleteAlarms;

  CancelDeleteAlarmState(this.deleteAlarms);

  @override
  List<Object?> get props => [deleteAlarms];
}

class ConfirmDeleteAlarmState extends HomeState {
  final List<Alarm> deleteAlarms;

  ConfirmDeleteAlarmState(this.deleteAlarms);

  @override
  List<Object?> get props => [deleteAlarms];
}

class DeleteItemAlarmState extends HomeState {
  final List<Alarm> deleteAlarms;

  DeleteItemAlarmState(this.deleteAlarms);

  @override
  List<Object?> get props => [deleteAlarms];
}

class GetTextFromSpeechState extends HomeState {
  final String result;

  GetTextFromSpeechState(this.result);

  @override
  List<Object?> get props => [result];
}

class RecognizeTextState extends HomeState {
  final String text;

  RecognizeTextState(this.text);

  @override
  List<Object?> get props => [text];
}

class HandleErrorState extends HomeState {
  final String message;

  HandleErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class ReloadAlarmListState extends HomeState {
  final List<Alarm> alarmList;

  ReloadAlarmListState(this.alarmList);

  @override
  List<Object?> get props => [alarmList];
}

class UpdateAlarmState extends HomeState {
  final Alarm alarm;

  UpdateAlarmState(this.alarm);

  @override
  List<Object?> get props => [alarm];
}

class UpdateAlarmByToggleSwitchState extends HomeState {
  final Alarm alarm;

  UpdateAlarmByToggleSwitchState(this.alarm);

  @override
  List<Object?> get props => [alarm];
}

class ShowAlertDialogState extends HomeState {
  final bool isShowDialog;

  ShowAlertDialogState(this.isShowDialog);

  @override
  List<Object?> get props => [isShowDialog];
}

class CancelAlertDialogState extends HomeState {}