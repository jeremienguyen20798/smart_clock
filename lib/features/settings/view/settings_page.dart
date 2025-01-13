import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_clock/features/settings/bloc/settings_bloc.dart';
import 'package:smart_clock/features/settings/bloc/settings_event.dart';
import 'package:smart_clock/features/settings/view/settings_view.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => SettingsBloc()..add(OnGetDefaultConfigsEvent()),
        child: const SettingsView());
  }
}
