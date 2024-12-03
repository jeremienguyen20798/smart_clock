import 'package:hive_ce/hive.dart';
import 'package:smart_clock/data/models/alarm.dart';

class SmartClockLocalDB {
  static Future<void> createAlarm(Alarm alarm) async {
    final alarmBox = await Hive.openBox<Alarm>('alarms');
    alarmBox.put(alarm.alarmId, alarm);
  }

  static Future<bool> checkAlarmExists(Alarm alarm) async {
    final alarmBox = await Hive.openBox<Alarm>('alarms');
    return alarmBox.containsKey(alarm.key);
  }

  static Future<void> updateAlarm(Alarm alarm) async {
    await alarm.save();
  }

  static Future<void> updateAlarmStatus(String id, bool value) async {
    final alarmBox = await Hive.openBox<Alarm>('alarms');
    final alarm = alarmBox.get(id);
    if (alarm != null) {
      alarm.isActive = value;
      alarm.save();
    }
  }

  static Future<Alarm?> getAlarmFromId(String id) async {
    final alarmBox = await Hive.openBox<Alarm>('alarms');
    return alarmBox.get(id);
  }

  static Future<void> deleteAlarm(List<Alarm> dataList) async {
    final alarmBox = await Hive.openBox<Alarm>('alarms');
    final alarmKeys = dataList.map((e) => e.key).toList();
    alarmBox.deleteAll(alarmKeys);
  }

  static Future<List<Alarm>> getAlarmList() async {
    final alarmBox = await Hive.openBox<Alarm>('alarms');
    return alarmBox.values.toList();
  }
}
