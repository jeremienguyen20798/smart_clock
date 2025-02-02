import 'package:smart_clock/core/utils/string_utils.dart';
import 'package:smart_clock/data/models/alarm.dart';

class AppConstants {
  static const String appName = 'Smart Clock';
  //Home Page
  static const String alarm = 'Báo thức';

  //General
  static const String daily = 'Hằng ngày';
  static const String justOnce = 'Một lần';
  static const String mondayToFriday = 'Thứ hai đến thứ sáu';
  static const String space = ' ';
  static const String emptyText = 'Chưa có báo thức nào';
  static const String titlePrompt = 'Prompt';
  static const String errorText = 'Đã xảy ra lỗi';

  static const String privacyPolicyUrl =
      'https://www.termsfeed.com/live/abc23aaf-9363-466d-a53e-c91bdc1e75f1';
  static const String ringtoneUrl =
      'https://nhacchuongviet.com/top-100-nhac-bao-thuc-hot-nhat/';
  static Alarm demoAlarm = Alarm(
      alarmId: StringUtils.generateAlarmIdStr(),
      alarmDateTime: DateTime.now().add(const Duration(minutes: 5)),
      isActive: true,
      typeAlarm: AlarmType.justonce.name,
      createAt: DateTime.now());

  static const String deleteAlarmAfterNotify =
      'delete_alarm_after_notification';

  static const String editContentNotification = 'edit_content_notification';
}
