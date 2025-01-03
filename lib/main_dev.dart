import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_clock/data/local_db/local_db.dart';
import 'package:smart_clock/di.dart';

import 'app.dart';
import 'smart_clock_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SmartClockBlocObserver();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  await DependencyInjection.setUp();
  await SmartClockLocalDB.initialize();
  runApp(const MyApp());
}
