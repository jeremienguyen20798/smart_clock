abstract class SettingsEvent {}

class OnGetDefaultConfigsEvent extends SettingsEvent {}

class OnPrivacyPolicyEvent extends SettingsEvent {}

class OnFullScreenNotificationEvent extends SettingsEvent {}

class OnEditContentNotificationEvent extends SettingsEvent {
  final String message;

  OnEditContentNotificationEvent(this.message);
}
