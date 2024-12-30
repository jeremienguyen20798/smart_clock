import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_clock/core/base/bloc/base_bloc.dart';
import 'package:smart_clock/core/base/bloc/base_state.dart';
import 'package:smart_clock/features/home/view/home_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<BaseBloc, BaseState>(
        listener: (context, state) {
          if (state is NoInternetState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Không có kết nối mạng')));
          }
        },
        child: const HomeView());
  }
}
