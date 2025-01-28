import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
    on<OnEditContentNotificationEvent>(_onEditContentNotification);
  }

  void _onGetDefaultConfigs(
      OnGetDefaultConfigsEvent event, Emitter<SettingsState> emitter) {
    final messageDefault =
        prefs.getString(AppConstants.editContentNotification);
    emitter(GetDefaultConfigsState(messageDefault, false));
  }

  Future<void> _onPrivacyPolicy(
      OnPrivacyPolicyEvent event, Emitter<SettingsState> emitter) async {
    launchUrl(Uri.parse(AppConstants.privacyPolicyUrl));
  }

  void _onFullScreenNotification(
      OnFullScreenNotificationEvent event, Emitter<SettingsState> emitter) {
    channel.invokeMethod('openAppSettings');
  }

  void _onEditContentNotification(
      OnEditContentNotificationEvent event, Emitter<SettingsState> emitter) {
    prefs.setString(AppConstants.editContentNotification, event.message);
    EasyLoading.showSuccess('Đã thay đổi nội dung thành công');
  }
}
