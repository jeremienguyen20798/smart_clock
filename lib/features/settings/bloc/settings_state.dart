import 'package:equatable/equatable.dart';

abstract class SettingsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitSettingState extends SettingsState {}

class GetDefaultConfigsState extends SettingsState {
  final bool isEnable;

  GetDefaultConfigsState(this.isEnable);

  @override
  List<Object?> get props => [isEnable];
}

class DeleteAlarmAfterNotificationState extends SettingsState {
  final bool isEnable;

  DeleteAlarmAfterNotificationState(this.isEnable);

  @override
  List<Object?> get props => [isEnable];
}
