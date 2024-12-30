import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:smart_clock/core/base/bloc/base_bloc.dart';
import 'package:smart_clock/core/constants/app_constants.dart';
import 'package:smart_clock/features/home/view/home_page.dart';

import 'core/base/bloc/base_event.dart';
import 'core/base/view/base_page.dart';
import 'features/home/bloc/home_bloc.dart';
import 'features/home/bloc/home_event.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: AppConstants.appName,
        scaffoldMessengerKey: scaffoldMessengerKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true),
        builder: EasyLoading.init(),
        home: MultiBlocProvider(providers: [
          BlocProvider(create: (_) => BaseBloc()..add(OnCheckInternetStatusEvent())),
          BlocProvider(
              create: (_) => HomeBloc()
                ..add(RequestPermissionEvent())
                ..add(GetAlarmListEvent()))
        ], child: const BasePage(view: HomePage())));
  }
}
