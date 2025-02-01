//import 'package:android_intent_plus/android_intent.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:smart_clock/core/extensions/locale_extension.dart';
import 'package:smart_clock/core/utils/bottomsheet_utils.dart';
import 'package:smart_clock/features/settings/bloc/settings_bloc.dart';
import 'package:smart_clock/features/settings/bloc/settings_event.dart';
import 'package:smart_clock/features/settings/bloc/settings_state.dart';

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
                'settingAlarm'.tr(),
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 16.0),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading:
                        const Icon(Icons.music_note, color: Colors.deepPurple),
                    title: Text(
                      'alarmSoundContent'.tr(),
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: RichText(
                      maxLines: 1,
                      text: TextSpan(
                        text: 'default'.tr(),
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                        children: const [
                          TextSpan(
                              text: 'iPhone ringtone',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                  overflow: TextOverflow.ellipsis)),
                        ],
                      ),
                    ),
                    trailing: MaterialButton(
                      onPressed: () {
                        BottomsheetUtils.showRingtoneBottomSheet(context);
                      },
                      color: Colors.blue,
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0)),
                      child: Text(
                        'viewMore'.tr(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      context
                          .read<SettingsBloc>()
                          .add(OnFullScreenNotificationEvent());
                    },
                    leading: const Icon(Icons.screen_lock_portrait_outlined,
                        color: Colors.deepPurple),
                    contentPadding: EdgeInsets.zero,
                    title: Text('displayAlarmInLockScreen'.tr(),
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
                    trailing: Switch(
                        value: false,
                        onChanged: (value) {
                          context
                              .read<SettingsBloc>()
                              .add(OnFullScreenNotificationEvent());
                        }),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    onTap: () {
                      EasyLoading.showToast('Tính năng đang phát triển');
                    },
                    leading:
                        Icon(Icons.auto_awesome, color: Colors.yellow.shade800),
                    title: Text(
                      'Tạo báo thức với AI khi offline'.tr(),
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12.0),
            ListTile(
              title: Text(
                'settingsApp'.tr(),
                style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 16.0),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.language_outlined,
                        color: Colors.deepPurple),
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
                    trailing: Text(
                      localeName,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      context.read<SettingsBloc>().add(OnPrivacyPolicyEvent());
                    },
                    contentPadding: EdgeInsets.zero,
                    leading:
                        const Icon(Icons.article, color: Colors.deepPurple),
                    title: Text(
                      'termsOfUse'.tr(),
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey,
                          size: 18.0,
                        )),
                  ),
                  ListTile(
                    onTap: () {
                      context.read<SettingsBloc>().add(OnPrivacyPolicyEvent());
                    },
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.privacy_tip_outlined,
                        color: Colors.deepPurple),
                    title: Text(
                      'privacyPolicy'.tr(),
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          context
                              .read<SettingsBloc>()
                              .add(OnPrivacyPolicyEvent());
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey,
                          size: 18.0,
                        )),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      'appVersion'.tr(),
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: const Text(
                      'Version 1.0.2',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
