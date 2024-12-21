abstract class SettingsEvent {}

class OnGetDefaultConfigsEvent extends SettingsEvent {}

class OnControlDeleteAlarmAfterNotificationEvent extends SettingsEvent {
  bool isEnable;

  OnControlDeleteAlarmAfterNotificationEvent(this.isEnable);
}
