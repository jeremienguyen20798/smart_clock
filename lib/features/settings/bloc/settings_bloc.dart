import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_clock/core/constants/app_constants.dart';
import 'package:smart_clock/di.dart';
import 'package:smart_clock/features/settings/bloc/settings_event.dart';
import 'package:smart_clock/features/settings/bloc/settings_state.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final prefs = getIt.get<SharedPreferences>();

  SettingsBloc() : super(InitSettingState()) {
    on<OnGetDefaultConfigsEvent>(_onGetDefaultConfigs);
    on<OnPrivacyPolicyEvent>(_onPrivacyPolicy);
  }

  void _onGetDefaultConfigs(
      OnGetDefaultConfigsEvent event, Emitter<SettingsState> emitter) {
    emitter(GetDefaultConfigsState(false));
  }

  Future<void> _onPrivacyPolicy(
      OnPrivacyPolicyEvent event, Emitter<SettingsState> emitter) async {
    launchUrl(Uri.parse(AppConstants.privacyPolicyUrl));
  }
}
