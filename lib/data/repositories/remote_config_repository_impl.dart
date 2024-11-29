import 'dart:developer';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_clock/domain/repository/remote_config_repository.dart';

import '../../di.dart';

class RemoteConfigRepositoryImpl extends RemoteConfigRepository {
  final remoteConfig = FirebaseRemoteConfig.instance;
  final pref = getIt.get<SharedPreferences>();

  @override
  Future<void> fetchRemoteConstants() async {
    try {
      final result = await remoteConfig.fetchAndActivate();
      if (result) {
        String geminiAPIKey = remoteConfig.getString('GeminiKey');
        String headPrompt = remoteConfig.getString('HeadConfigPrompt');
        String lastPrompt = remoteConfig.getString('LastConfigPrompt');
        log("API key: $geminiAPIKey");
        pref.setString('GeminiKey', geminiAPIKey);
        pref.setString('HeadPrompt', headPrompt);
        pref.setString('LastPrompt', lastPrompt);
      }
    } catch (error) {
      log("Error: $error");
    }
  }
}
