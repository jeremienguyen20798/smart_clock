import 'package:hive_ce/hive.dart';
import 'package:smart_clock/data/models/alarm.dart';

extension HiveRegistrar on HiveInterface {
  void registerAdapters() {
    registerAdapter(AlarmAdapter());
  }
}
