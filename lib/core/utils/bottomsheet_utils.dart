import 'package:flutter/material.dart';
import 'package:smart_clock/shared/widgets/change_language.dart';

class BottomsheetUtils {
  static void showChangeLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => const ChangeLanguage());
  }
}
