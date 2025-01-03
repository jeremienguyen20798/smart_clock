import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_clock/features/settings/bloc/settings_bloc.dart';
import 'package:smart_clock/features/settings/bloc/settings_event.dart';
import 'package:smart_clock/features/settings/bloc/settings_state.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/utils/dialog_utils.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
      bool isDeleteAfterNotification = true;
      if (state is GetDefaultConfigsState) {
        isDeleteAfterNotification = state.isEnable;
      } else if (state is DeleteAlarmAfterNotificationState) {
        isDeleteAfterNotification = state.isEnable;
      }
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back)),
            title: const Text(
              AppConstants.titleSettings,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Column(
            children: [
              ListTile(
                title: const Text(
                  AppConstants.whenDelete,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Switch(
                    value: isDeleteAfterNotification,
                    onChanged: (value) {
                      context.read<SettingsBloc>().add(
                          OnControlDeleteAlarmAfterNotificationEvent(value));
                    }),
              ),
              ListTile(
                title: const Text(
                  AppConstants.defaultContentNotify,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: RichText(
                    text: TextSpan(
                        text: AppConstants.alarm,
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                        children: [
                      const TextSpan(text: '  '),
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              DialogUtils.showEditMessageNotiDialog(context);
                            },
                          text: 'Sửa',
                          style: const TextStyle(
                              color: Colors.deepPurple, fontSize: 14.0))
                    ])),
                trailing: Switch(value: true, onChanged: (value) {}),
              ),
              ListTile(
                title: const Text(
                  'Nhạc chuông báo thức',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Ringtone',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    InkWell(
                        onTap: () {},
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey,
                          size: 18.0,
                        ))
                  ],
                ),
              ),
            ],
          ));
    });
  }
}
