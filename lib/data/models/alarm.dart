import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../core/constants/app_constants.dart';

part 'alarm.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class Alarm extends HiveObject {
  @JsonKey(name: 'alarm_id')
  @HiveField(0)
  String alarmId;

  @JsonKey(name: 'dateTime')
  @HiveField(1)
  DateTime alarmDateTime;

  @JsonKey(name: 'note')
  @HiveField(2)
  String? note;

  @JsonKey(name: 'isVibrate')
  @HiveField(3)
  bool? isVibrate;

  @JsonKey(name: 'isDelete')
  @HiveField(4)
  bool? isDeleteAfterAlarm;

  @JsonKey(name: 'isActive')
  @HiveField(5)
  bool isActive;

  @HiveField(6)
  @JsonKey(name: 'repeat')
  String? typeAlarm;

  @JsonKey(name: 'sound')
  @HiveField(7)
  String? sound;

  @JsonKey(name: 'create_at')
  @HiveField(8)
  DateTime createAt;

  Alarm(
      {required this.alarmId,
      required this.alarmDateTime,
      this.note = AppConstants.alarm,
      this.isVibrate = true,
      this.isDeleteAfterAlarm = false,
      required this.isActive,
      this.typeAlarm,
      this.sound,
      required this.createAt});

  factory Alarm.fromJson(Map<String, dynamic> json) => _$AlarmFromJson(json);

  Map<String, dynamic> toJson() => _$AlarmToJson(this);

  @override
  String toString() {
    debugPrint(
        'Log alarm result: $alarmId, dateTime: ${alarmDateTime.toString()}, note: $note, isActive: $isActive');
    return super.toString();
  }
}

enum AlarmType { daily, justonce, mondaytofriday }
