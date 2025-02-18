import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_clock/features/ringtone/bloc/ringtone_bloc.dart';
import 'package:smart_clock/features/ringtone/bloc/ringtone_event.dart';
import 'package:smart_clock/features/ringtone/view/ringtone_view.dart';

class RingtonePage extends StatelessWidget {
  const RingtonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RingtoneBloc()..add(OnGetRingtoneList()),
      child: const RingtoneView(),
    );
  }
}
