import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:smart_clock/data/models/alarm.dart';
import 'package:smart_clock/domain/repository/genmini_ai_model.dart';

import '../../core/utils/string_utils.dart';

class CreateAlarmBySpeechUsecase {
  final GenminiAIModel _genminiAIModel = GenminiAIModel();

  Future<Alarm?> call(String textInput) async {
    final response =
        await _genminiAIModel.createAlarmBySpeech([Content.text(textInput)]);
    if (response == null) {
      return null;
    }
    final alarm = StringUtils.convertResponseToAlarm(response.text);
    return alarm;
  }
}
