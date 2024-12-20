import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_clock/di.dart';
import 'package:smart_clock/features/settings/bloc/settings_event.dart';
import 'package:smart_clock/features/settings/bloc/settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final prefs = getIt.get<SharedPreferences>();

  SettingsBloc() : super(InitSettingState()) {
    on<OnGetDefaultConfigsEvent>(_onGetDefaultConfigs);
    on<OnControlDeleteAlarmAfterNotificationEvent>(
        _onControlDeleteAlarmAfterNotification);
  }

  void _onGetDefaultConfigs(
      OnGetDefaultConfigsEvent event, Emitter<SettingsState> emitter) {
    final isEnabled = prefs.getBool('delete_alarm_after_notification') ?? true;
    emitter(GetDefaultConfigsState(isEnabled));
  }

  void _onControlDeleteAlarmAfterNotification(
      OnControlDeleteAlarmAfterNotificationEvent event,
      Emitter<SettingsState> emitter) {
    prefs.setBool('delete_alarm_after_notification', event.isEnable);
    emitter(DeleteAlarmAfterNotificationState(event.isEnable));
  }
}
