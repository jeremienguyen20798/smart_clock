abstract class NotificationEvent {}

class OnInitEvent extends NotificationEvent {}

class OnTimeIsUpEvent extends NotificationEvent {
  final String notificationId;
  final String alarmId;

  OnTimeIsUpEvent(this.notificationId, this.alarmId);
}
