import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_clock/data/local_db/local_db.dart';
import 'package:smart_clock/di.dart';

import 'app.dart';
import 'smart_clock_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  Bloc.observer = SmartClockBlocObserver();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  await DependencyInjection.setUp();
  await SmartClockLocalDB.initialize();
  runApp(EasyLocalization(
      path: 'assets/translations',
      supportedLocales: const [Locale('en', 'US'), Locale('vi', 'VN')],
      fallbackLocale: const Locale('vi', 'VN'),
      child: const MyApp()));
}
