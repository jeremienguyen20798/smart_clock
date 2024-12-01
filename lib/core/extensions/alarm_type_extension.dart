import 'package:smart_clock/core/constants/app_constants.dart';
import 'package:smart_clock/data/models/alarm.dart';

extension AlarmTypeExtension on AlarmType {
  String content() {
    switch (this) {
      case AlarmType.daily:
        return AppConstants.daily;
      case AlarmType.justonce:
        return AppConstants.justOnce;
      case AlarmType.custom:
        return AppConstants.custom;
      case AlarmType.mondaytofriday:
        return AppConstants.mondayToFriday;
    }
  }

  int value() {
    switch (this) {
      case AlarmType.daily:
        return 0;
      case AlarmType.justonce:
        return 1;
      case AlarmType.custom:
        return 2;
      case AlarmType.mondaytofriday:
        return 3;
    }
  }
}