import 'package:flutter/material.dart';
import 'package:smart_clock/shared/widgets/change_language.dart';

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
}
