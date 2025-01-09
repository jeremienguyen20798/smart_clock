import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_clock/di.dart';
import 'package:smart_clock/firebase_options.dart';
import 'package:smart_clock/smart_clock_bloc_observer.dart';

import 'app.dart';
import 'data/local_db/local_db.dart';
import 'domain/repository/remote_config_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = SmartClockBlocObserver();
  await DependencyInjection.setUp();
  final remoteConfig = getIt.get<RemoteConfigRepository>();
  remoteConfig.fetchRemoteConstants();
  await SmartClockLocalDB.initialize();
  runApp(EasyLocalization(
      path: 'assets/translations',
      supportedLocales: const [Locale('en', 'US'), Locale('vi', 'VN')],
      fallbackLocale: const Locale('vi', 'VN'),
      child: const MyApp()));
}
