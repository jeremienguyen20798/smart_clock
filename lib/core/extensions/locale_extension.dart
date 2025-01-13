import 'package:flutter/material.dart';

extension LocaleExtension on Locale {
  String toLanguageName() {
    return languageCode == 'vi' ? 'Vietnamese' : 'English';
  }
}
