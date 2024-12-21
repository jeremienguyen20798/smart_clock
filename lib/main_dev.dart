import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_clock/di.dart';

import 'app.dart';
import 'core/constants/app_constants.dart';
import 'data/local_db/local_db.dart';
import 'smart_clock_bloc_observer.dart';

const channel = MethodChannel('android_handle_alarm');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SmartClockBlocObserver();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  await DependencyInjection.setUp();
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
