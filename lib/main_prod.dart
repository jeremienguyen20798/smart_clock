import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_clock/di.dart';
import 'package:smart_clock/firebase_options.dart';
import 'package:smart_clock/smart_clock_bloc_observer.dart';

import 'app.dart';
import 'core/constants/app_constants.dart';
import 'data/local_db/local_db.dart';
import 'domain/repository/remote_config_repository.dart';

const channel = MethodChannel('android_handle_alarm');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = SmartClockBlocObserver();
  await DependencyInjection.setUp();
  final remoteConfig = getIt.get<RemoteConfigRepository>();
  remoteConfig.fetchRemoteConstants();
  final prefs = getIt.get<SharedPreferences>();
  final deleteAlarmAfterNotification =
      prefs.getBool(AppConstants.deleteAlarmAfterNotify);
  if (deleteAlarmAfterNotification ?? true) {
    channel.setMethodCallHandler((call) async {
      if (call.method == 'sendDataToFlutter') {
        final id = call.arguments;
        if (id != null) {
          await SmartClockLocalDB.updateAlarmStatus(id, false);
        }
      }
    });
  }
  runApp(const MyApp());
}
