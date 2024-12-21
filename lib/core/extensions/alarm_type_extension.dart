import 'package:smart_clock/core/constants/app_constants.dart';
import 'package:smart_clock/data/models/alarm.dart';

extension AlarmTypeExtension on AlarmType {
  String content() {
    switch (this) {
      case AlarmType.daily:
        return AppConstants.daily;
      case AlarmType.justonce:
        return AppConstants.justOnce;
      case AlarmType.mondaytofriday:
        return AppConstants.mondayToFriday;
    }
  }
}
