import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_clock/di.dart';
import 'package:smart_clock/features/settings/bloc/settings_event.dart';
import 'package:smart_clock/features/settings/bloc/settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final prefs = getIt.get<SharedPreferences>();

  SettingsBloc() : super(InitSettingState()) {
    on<OnGetDefaultConfigsEvent>(_onGetDefaultConfigs);
  }

  void _onGetDefaultConfigs(
      OnGetDefaultConfigsEvent event, Emitter<SettingsState> emitter) {
    emitter(GetDefaultConfigsState(false));
  }
}
