import 'package:smart_clock/core/utils/string_utils.dart';
import 'package:smart_clock/data/models/alarm.dart';

class AppConstants {
  static const String appName = 'Smart Clock';
  //Home Page
  static const String homeTitleText = 'Chào, Nguyễn Hoàng Phúc';
  static const String alarm = 'Báo thức';
  static const String deleteAlarm = 'Xoá';
  static const String turnOffNotification = 'Tắt thông báo';

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

  static const String daily = 'Hằng ngày';
  static const String justOnce = 'Một lần';
  static const String mondayToFriday = 'Thứ hai đến thứ sáu';
  static const String custom = 'Tuỳ chỉnh';

  static const String timeAlarmDemo = '23:00';
  static const String noteAlarmDemo = 'Đọc sách 30 phút';
  static const String reAlarmDemo = 'Báo thức sau 6 giờ 20 phút';
  static const String space = ' ';
  static const String barText = ' | ';
  static const String alarmSoundDemo = 'Báo thức tự nhiên';
  static const String emptyText = 'Chưa có báo thức nào';
  static const String titlePrompt = 'Prompt';
  static const String errorText = 'Đã xảy ra lỗi';
  static const String messagePrompt = 'Tạo báo thức với yêu cầu của bạn';
  static const String ringText = 'Đổ chuông';
  static Alarm demoAlarm = Alarm(
      alarmId: StringUtils.generateAlarmIdStr(),
      alarmDateTime: DateTime.now().add(const Duration(minutes: 2)),
      isActive: true);
}
