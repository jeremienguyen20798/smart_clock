import 'package:easy_localization/easy_localization.dart';
import 'package:smart_clock/data/models/alarm.dart';

extension AlarmTypeExtension on AlarmType {
  String content() {
    switch (this) {
      case AlarmType.daily:
        return 'daily'.tr();
      case AlarmType.justonce:
        return 'justOnce'.tr();
      case AlarmType.mondaytofriday:
        return 'mondayToFriday'.tr();
    }
  }
}
