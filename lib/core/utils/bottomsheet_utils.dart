import 'package:flutter/material.dart';
import 'package:smart_clock/shared/widgets/change_language.dart';
import 'package:smart_clock/shared/widgets/ringtone_bottomsheet.dart';

class BottomsheetUtils {
  static void showChangeLanguageBottomSheet(
      BuildContext context, Function(Locale) onChange) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => const ChangeLanguage()).then((value) {
      if (value != null) {
        onChange(value);
      }
    });
  }

  static void showRingtoneBottomSheet(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        isScrollControlled: true,
        context: context,
        builder: (_) => const RingtoneBottomsheet());
  }
}
