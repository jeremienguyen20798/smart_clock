import 'package:smart_clock/di.dart';

import '../repository/speech_to_text_repository.dart';

class StartListeningUsecase {
  final repository = getIt.get<SpeechToTextRepository>();

  Future<void> call(
      Function(String) onRecognize, Function(String) onListening) async {
    await repository.startListening((text) {
      onRecognize(text);
    }, (result) {
      onListening(result);
    });
  }
}
