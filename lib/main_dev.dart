import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:smart_clock/di.dart';
import 'package:smart_clock/my_bloc_observer.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await DependencyInjection.setUp();
  runApp(const MyApp());
}
