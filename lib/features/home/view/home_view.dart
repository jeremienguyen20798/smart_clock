import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:smart_clock/core/utils/battery_saver_utils.dart';
import 'package:smart_clock/core/utils/dialog_utils.dart';
import 'package:smart_clock/data/models/alarm.dart';
import 'package:smart_clock/features/home/bloc/home_bloc.dart';
import 'package:smart_clock/features/home/bloc/home_event.dart';
import 'package:smart_clock/features/home/bloc/home_state.dart';
import 'package:smart_clock/features/home/view/alarm_list.dart';
import 'package:smart_clock/shared/widgets/prompt_widget.dart';
import 'package:smart_clock/features/settings/view/settings_page.dart';

List<Alarm> alarmList = [];
bool isDelete = false;
List<Alarm>? deleteAlarms;
String? recognizeText, prompt;

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is GetAlarmListState) {
          prompt = null;
          alarmList = state.alarms;
          context.read<HomeBloc>().add(RequestPermissionEvent());
        } else if (state is DeleteItemAlarmState) {
          isDelete = state.deleteAlarms.isNotEmpty;
          deleteAlarms = state.deleteAlarms;
        } else if (state is CancelDeleteAlarmState) {
          isDelete = state.deleteAlarms.isNotEmpty;
          deleteAlarms = state.deleteAlarms;
        } else if (state is ConfirmDeleteAlarmState) {
          alarmList = state.deleteAlarms;
          isDelete = false;
          deleteAlarms = null;
        } else if (state is HandleErrorState) {
          EasyLoading.showError(state.message);
          prompt = null;
        } else if (state is RecognizeTextState) {
          recognizeText = state.text;
        } else if (state is GetTextFromSpeechState) {
          recognizeText = null;
          prompt = state.result;
        } else if (state is ReloadAlarmListState) {
          alarmList = state.alarmList;
        }
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: isDelete
                ? IconButton(
                    onPressed: () {
                      context.read<HomeBloc>().add(OnCancelDeleteAlarmEvent());
                    },
                    icon: const Icon(Icons.close))
                : null,
            title: Text(
                isDelete
                    ? "${'deleteSelected'.tr()} ${deleteAlarms?.length} ${'items'.tr()}"
                    : 'homeTitle'.tr(),
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                )),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const SettingsPage()));
                  },
                  icon: const Icon(Icons.more_vert))
            ],
          ),
          body: recognizeText != null
              ? Center(
                  child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(recognizeText!,
                      textAlign: TextAlign.center,
                      style:
                          const TextStyle(color: Colors.black, fontSize: 14.0)),
                ))
              : prompt != null
                  ? Center(child: PromptWidget(input: prompt!))
                  : AlarmList(alarmList: alarmList, deleteList: deleteAlarms),
          floatingActionButton: isDelete
              ? null
              : MaterialButton(
                  elevation: 2.5,
                  minWidth: 56.0,
                  height: 56.0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0)),
                  onPressed: () {
                    context.read<HomeBloc>().add(OnGetTextFromSpeechEvent());
                  },
                  child: kDebugMode
                      ? const Icon(Icons.add)
                      : const Icon(Icons.mic),
                ),
          persistentFooterAlignment: AlignmentDirectional.center,
          persistentFooterButtons: isDelete
              ? [
                  MaterialButton(
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onPressed: () {
                      context
                          .read<HomeBloc>()
                          .add(OnConfirmDeleteAlarmEvent(deleteAlarms ?? []));
                    },
                    minWidth: MediaQuery.of(context).size.width * 0.45,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    elevation: 0.0,
                    color: Colors.white,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.delete_outline, color: Colors.black),
                        const SizedBox(height: 4.0),
                        Text('deleteAlarm'.tr(),
                            style: const TextStyle(color: Colors.black))
                      ],
                    ),
                  ),
                ]
              : null,
        );
      },
      listener: (BuildContext context, HomeState state) {
        if (state is ShowAlertDialogState) {
          DialogUtils.showAlertDialog(
              context, 'warning'.tr(), 'warningContent'.tr(), () async {
            await BatterySaverUtils.openBatterySaverSetting();
          }, () {
            context.read<HomeBloc>().add(OnCancelAlertDialogEvent());
          });
        }
      },
    );
  }
}
