import 'dart:developer';

import 'package:android_power_manager/android_power_manager.dart';

class BatterySaverUtils {
  static Future<bool> isBatterySaverEnabled() async {
    try {
      final isBatteryOptimize =
          await AndroidPowerManager.isIgnoringBatteryOptimizations;
      return isBatteryOptimize ?? false;
    } catch (e) {
      log("Error: $e");
      return false;
    }
  }

  static Future<bool> openBatterySaverSetting() {
    AndroidPowerManager.requestIgnoreBatteryOptimizations();
    return isBatterySaverEnabled();
  }
}
