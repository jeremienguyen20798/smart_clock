import 'package:equatable/equatable.dart';
import 'package:smart_clock/data/models/alarm.dart';

abstract class NotificationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitState extends NotificationState {}

class TimeIsUpState extends NotificationState {
  final Alarm alarm;

  TimeIsUpState(this.alarm);

  @override
  List<Object?> get props => [alarm];
}
