import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_clock/core/constants/app_constants.dart';
import 'package:smart_clock/data/local_db/local_db.dart';
import 'package:smart_clock/data/models/alarm.dart';
import 'package:smart_clock/di.dart';
import 'package:smart_clock/domain/usecase/create_alarm_by_speech_usecase.dart';
import 'package:smart_clock/domain/usecase/start_listening_usecase.dart';
import 'package:smart_clock/features/home/bloc/home_event.dart';
import 'package:smart_clock/features/home/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  List<Alarm> alarmList = [];
  List<Alarm> alarmDeleteList = [];
  final methodChannel = const MethodChannel('create_alarm_by_speech');
  final pref = getIt.get<SharedPreferences>();

  HomeBloc() : super(InitHomeState()) {
    on<RequestPermissionEvent>(_onRequestPermission);
    on<GetAlarmListEvent>(_onGetAlarmList);
    on<OnLongClickItemEvent>(_onDeleteAlarm);
    on<OnCancelDeleteAlarmEvent>(_onCancelDeleteAlarm);
    on<OnConfirmDeleteAlarmEvent>(_onConfirmDeleteAlarm);
    on<OnGetTextFromSpeechEvent>(_getTextFromSpeech);
    on<OnRecognizeTextEvent>(_onRecogizeText);
    on<OnCreateAlarmBySpeechEvent>(_onCreateAlarmBySpeech);
    on<OnHandleErrorEvent>(_onHandleError);
    on<OnUpdateAlarmEvent>(_onUpdateAlarm);
    on<OnCancelAlarmEvent>(_onCancelAlarm);
    on<OnReloadAlarmListEvent>(_onReloadAlarmList);
  }

  Future<void> _onRequestPermission(
      RequestPermissionEvent event, Emitter<HomeState> emitter) async {
    final status = await Permission.notification.request();
    status.isGranted ? emitter(RequestPermissionState()) : null;
  }

  Future<void> _onGetAlarmList(
      GetAlarmListEvent event, Emitter<HomeState> emitter) async {
    final dataList = await SmartClockLocalDB.getAlarmList();
    alarmList = dataList;
    emitter(GetAlarmListState(dataList));
  }

  void _onDeleteAlarm(OnLongClickItemEvent event, Emitter<HomeState> emitter) {
    List<Alarm> dataList = [];
    alarmDeleteList.contains(event.alarm)
        ? alarmDeleteList.remove(event.alarm)
        : alarmDeleteList.add(event.alarm);
    dataList.addAll(alarmDeleteList);
    emitter(DeleteItemAlarmState(dataList));
  }

  void _onCancelDeleteAlarm(
      OnCancelDeleteAlarmEvent event, Emitter<HomeState> emitter) {
    alarmDeleteList.clear();
    emitter(CancelDeleteAlarmState(alarmDeleteList));
  }

  void _onConfirmDeleteAlarm(
      OnConfirmDeleteAlarmEvent event, Emitter<HomeState> emitter) {
    SmartClockLocalDB.deleteAlarm(event.alarmList);
    alarmList.removeWhere((item) => alarmDeleteList.contains(item));
    emitter(ConfirmDeleteAlarmState(alarmList));
  }

  void _getTextFromSpeech(
      OnGetTextFromSpeechEvent event, Emitter<HomeState> emitter) {
    if (kDebugMode) {
      add(OnCreateAlarmBySpeechEvent(""));
    } else {
      StartListeningUsecase().call((text) {
        add(OnRecognizeTextEvent(text));
      }, (input) {
        add(OnCreateAlarmBySpeechEvent(input));
      });
    }
  }

  void _onRecogizeText(OnRecognizeTextEvent event, Emitter<HomeState> emitter) {
    emitter(RecognizeTextState(event.text));
  }

  Future<void> _onCreateAlarmBySpeech(
      OnCreateAlarmBySpeechEvent event, Emitter<HomeState> emitter) async {
    if (kDebugMode) {
      final result = await methodChannel.invokeMethod(
          'setAlarm', AppConstants.demoAlarm.toJson());
      if (result != null) {
        SmartClockLocalDB.createAlarm(AppConstants.demoAlarm);
        add(GetAlarmListEvent());
      }
    } else {
      emitter(GetTextFromSpeechState(event.prompt));
      EasyLoading.show();
      final headPrompt = pref.getString('HeadPrompt');
      final lastPrompt = pref.getString('LastPrompt');
      final alarm = await CreateAlarmBySpeechUsecase()
          .call("$headPrompt${event.prompt}$lastPrompt${DateTime.now()}");
      EasyLoading.dismiss();
      if (alarm != null) {
        final result =
            await methodChannel.invokeMethod('setAlarm', alarm.toJson());
        if (result != null) {
          SmartClockLocalDB.createAlarm(alarm);
          add(GetAlarmListEvent());
        }
      } else {
        add(OnHandleErrorEvent());
      }
    }
  }

  void _onHandleError(OnHandleErrorEvent event, Emitter<HomeState> emitter) {
    emitter(HandleErrorState(AppConstants.errorText));
  }

  Future<void> _onUpdateAlarm(
      OnUpdateAlarmEvent event, Emitter<HomeState> emitter) async {
    final Alarm? alarm = await SmartClockLocalDB.getAlarmFromId(event.idAlarm);
    if (alarm != null) {
      final result =
          await methodChannel.invokeMethod("cancelAlarm", alarm.toJson());
      if (result != null) {
        alarm.alarmDateTime = event.dateTime;
        alarm.isActive = event.isActive;
        SmartClockLocalDB.updateAlarm(alarm);
        await methodChannel.invokeMethod('setAlarm', alarm.toJson());
        add(OnReloadAlarmListEvent());
      }
    }
  }

  Future<void> _onReloadAlarmList(
      OnReloadAlarmListEvent event, Emitter<HomeState> emitter) async {
    final dataList = await SmartClockLocalDB.getAlarmList();
    emitter(ReloadAlarmListState(dataList));
  }

  Future<void> _onCancelAlarm(
      OnCancelAlarmEvent event, Emitter<HomeState> emitter) async {
    SmartClockLocalDB.updateAlarmStatus(event.alarm.key, event.isActive);
    await methodChannel.invokeMethod("cancelAlarm", event.alarm.toJson());
    emitter(CancelAlarmState());
  }
}
