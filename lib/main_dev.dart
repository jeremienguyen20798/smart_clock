import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:smart_clock/di.dart';

import 'app.dart';
import 'smart_clock_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SmartClockBlocObserver();
  await DependencyInjection.setUp();
  runApp(const MyApp());
}
