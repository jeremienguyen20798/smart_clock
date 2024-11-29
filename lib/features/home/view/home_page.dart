import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_clock/features/home/bloc/home_bloc.dart';
import 'package:smart_clock/features/home/bloc/home_event.dart';
import 'package:smart_clock/features/home/view/home_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc()
        ..add(RequestPermissionEvent())
        ..add(GetAlarmListEvent()),
      child: const HomeView(),
    );
  }
}
