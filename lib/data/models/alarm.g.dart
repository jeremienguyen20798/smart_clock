// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AlarmAdapter extends TypeAdapter<Alarm> {
  @override
  final int typeId = 0;

  @override
  Alarm read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Alarm(
      alarmId: fields[0] as String,
      alarmDateTime: fields[1] as DateTime,
      note: fields[2] == null ? AppConstants.alarmTab : fields[2] as String?,
      isVibrate: fields[3] == null ? true : fields[3] as bool?,
      isDeleteAfterAlarm: fields[4] == null ? false : fields[4] as bool?,
      isActive: fields[5] as bool,
      typeAlarm: fields[6] as String?,
      sound: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Alarm obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.alarmId)
      ..writeByte(1)
      ..write(obj.alarmDateTime)
      ..writeByte(2)
      ..write(obj.note)
      ..writeByte(3)
      ..write(obj.isVibrate)
      ..writeByte(4)
      ..write(obj.isDeleteAfterAlarm)
      ..writeByte(5)
      ..write(obj.isActive)
      ..writeByte(6)
      ..write(obj.typeAlarm)
      ..writeByte(7)
      ..write(obj.sound);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlarmAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Alarm _$AlarmFromJson(Map<String, dynamic> json) => Alarm(
      alarmId: json['alarm_id'] as String,
      alarmDateTime: DateTime.parse(json['dateTime'] as String),
      note: json['note'] as String? ?? AppConstants.alarmTab,
      isVibrate: json['isVibrate'] as bool? ?? true,
      isDeleteAfterAlarm: json['isDelete'] as bool? ?? false,
      isActive: json['isActive'] as bool,
      typeAlarm: json['repeat'] as String?,
      sound: json['sound'] as String?,
    );

Map<String, dynamic> _$AlarmToJson(Alarm instance) => <String, dynamic>{
      'alarm_id': instance.alarmId,
      'dateTime': instance.alarmDateTime.toIso8601String(),
      'note': instance.note,
      'isVibrate': instance.isVibrate,
      'isDelete': instance.isDeleteAfterAlarm,
      'isActive': instance.isActive,
      'repeat': instance.typeAlarm,
      'sound': instance.sound,
    };
