import 'package:equatable/equatable.dart';

abstract class SettingsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitSettingState extends SettingsState {}

class GetDefaultConfigsState extends SettingsState {
  final String? ringtone;
  final bool isEnable;

  GetDefaultConfigsState(this.ringtone, this.isEnable);

  @override
  List<Object?> get props => [ringtone, isEnable];
}

class DeleteAlarmAfterNotificationState extends SettingsState {
  final bool isEnable;

  DeleteAlarmAfterNotificationState(this.isEnable);

  @override
  List<Object?> get props => [isEnable];
}
