import 'dart:developer';

import 'package:smart_clock/domain/repository/speech_to_text_repository.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechToTextRepositoryImpl extends SpeechToTextRepository {
  final stt.SpeechToText _speechToText;

  SpeechToTextRepositoryImpl(this._speechToText);

  @override
  Future<void> startListening(
      Function(String) onRecognizeText, Function(String) onListening) async {
    bool available = await _speechToText.initialize();
    if (!available) throw Exception("Speech recognition not available");
    await _speechToText.listen(onResult: (result) {
      onRecognizeText(result.recognizedWords);
      if (result.finalResult) {
        log('Result listening: ${result.recognizedWords}');
        onListening(result.recognizedWords);
      }
    });
  }

  @override
  Future<void> stopListening() async {
    await _speechToText.stop();
  }
}
