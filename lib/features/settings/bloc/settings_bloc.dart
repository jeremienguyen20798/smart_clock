import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_clock/core/constants/app_constants.dart';
import 'package:smart_clock/di.dart';
import 'package:smart_clock/features/settings/bloc/settings_event.dart';
import 'package:smart_clock/features/settings/bloc/settings_state.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final prefs = getIt.get<SharedPreferences>();
  final channel = const MethodChannel('smart_lock_channel');

  SettingsBloc() : super(InitSettingState()) {
    on<OnGetDefaultConfigsEvent>(_onGetDefaultConfigs);
    on<OnPrivacyPolicyEvent>(_onPrivacyPolicy);
    on<OnFullScreenNotificationEvent>(_onFullScreenNotification);
  }

  void _onGetDefaultConfigs(
      OnGetDefaultConfigsEvent event, Emitter<SettingsState> emitter) {
    emitter(GetDefaultConfigsState(false));
  }

  Future<void> _onPrivacyPolicy(
      OnPrivacyPolicyEvent event, Emitter<SettingsState> emitter) async {
    launchUrl(Uri.parse(AppConstants.privacyPolicyUrl));
  }

  void _onFullScreenNotification(
      OnFullScreenNotificationEvent event, Emitter<SettingsState> emitter) {
    channel.invokeMethod('openAppSettings');
  }
}
