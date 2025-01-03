import 'package:smart_clock/core/utils/string_utils.dart';
import 'package:smart_clock/data/models/alarm.dart';

class AppConstants {
  static const String appName = 'Smart Clock';
  //Home Page
  static const String homeTitleText = 'Chào bạn, ngày mới tốt lành';
  static const String alarm = 'Báo thức';
  static const String deleteAlarm = 'Xoá';

  //Setting Page
  static const String addAlarmTitleText = 'Thêm báo thức';
  static const String alarmSoundContent = 'Nhạc chuông';
  static const String typeRepeatAlarm = 'Lặp lại';
  static const String whenAlarm = 'Rung khi báo thức';
  static const String whenDelete = 'Xoá báo thức sau khi thông báo';
  static const String inputAlarmNote = 'Ghi chú báo thức';
  static const String inputNote = 'Nhập ghi chú';
  static const String cancel = 'Huỷ';
  static const String confirm = 'Đặt';
  static const String edit = 'Chỉnh sửa';
  static const String titleSettings = 'Cài đặt';
  static const String defaultContentNotify = 'Nội dung thông báo mặc định';

  //General
  static const String daily = 'Hằng ngày';
  static const String justOnce = 'Một lần';
  static const String mondayToFriday = 'Thứ hai đến thứ sáu';
  static const String space = ' ';
  static const String emptyText = 'Chưa có báo thức nào';
  static const String titlePrompt = 'Prompt';
  static const String errorText = 'Đã xảy ra lỗi';
  static const String messagePrompt = 'Tạo báo thức với yêu cầu của bạn';
  static Alarm demoAlarm = Alarm(
      alarmId: StringUtils.generateAlarmIdStr(),
      alarmDateTime: DateTime.now().add(const Duration(minutes: 5)),
      isActive: true,
      typeAlarm: AlarmType.justonce.name,
      createAt: DateTime.now());

  static const String deleteAlarmAfterNotify =
      'delete_alarm_after_notification';
}
