import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_clock/di.dart';
import 'package:smart_clock/firebase_options.dart';
import 'package:smart_clock/smart_clock_bloc_observer.dart';

import 'app.dart';
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
  runApp(const MyApp());
}
