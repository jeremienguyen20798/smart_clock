import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_clock/core/extensions/locale_extension.dart';
import 'package:smart_clock/core/utils/bottomsheet_utils.dart';
import 'package:smart_clock/features/settings/bloc/settings_bloc.dart';
import 'package:smart_clock/features/settings/bloc/settings_state.dart';

import '../../../core/utils/dialog_utils.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
      String localeName = 'Vietnamese';
      if (state is GetDefaultConfigsState) {
        localeName = context.locale.toLanguageName();
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
          title: Text(
            'settingsTitle'.tr(),
            style: const TextStyle(
              fontSize: 18.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Column(
          children: [
            ListTile(
              title: Text(
                'defaultContentNotify'.tr(),
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: RichText(
                  text: TextSpan(
                      text: 'alarm'.tr(),
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
                        text: 'edit'.tr(),
                        style: const TextStyle(
                            color: Colors.deepPurple, fontSize: 14.0))
                  ])),
            ),
            ListTile(
              title: const Text('Hiện thị thông báo ở màn hình khoá',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
              trailing: Switch(value: true, onChanged: (value) {}),
            ),
            ListTile(
              title: Text(
                'alarmSoundContent'.tr(),
                style: const TextStyle(
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
            ListTile(
              onTap: () {
                BottomsheetUtils.showChangeLanguageBottomSheet(context,
                    (locale) {
                  localeName = locale.toLanguageTag();
                  context.setLocale(locale);
                });
              },
              title: Text(
                'changeLanguage'.tr(),
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    localeName,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.deepPurple,
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
            ListTile(
              title: Text(
                'appVersion'.tr(),
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: const Text(
                'Version 1.0.0',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.deepPurple,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
