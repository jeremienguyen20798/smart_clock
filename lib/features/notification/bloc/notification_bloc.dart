import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_clock/features/notification/bloc/notification_event.dart';
import 'package:smart_clock/features/notification/bloc/notification_state.dart';

import '../../../data/local_db/local_db.dart';

const channel = MethodChannel('android_handle_alarm');

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(InitState()) {
    on<OnInitEvent>(_onInit);
    on<OnTimeIsUpEvent>(_onTimeIsUp);
  }

  void _onInit(OnInitEvent event, Emitter<NotificationState> emitter) {
    channel.setMethodCallHandler((call) async {
      if (call.method == 'sendDataToFlutter') {
        final data = call.arguments;
        if (data != null) {
          String alarmId = data;
          final alarm = await SmartClockLocalDB.getAlarmFromId(alarmId);
          if (alarm != null) {
            alarm.isActive = false;
            alarm.save();
          }
        }
      }
    });
  }

  Future<void> _onTimeIsUp(
      OnTimeIsUpEvent event, Emitter<NotificationState> emitter) async {}
}
