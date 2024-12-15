import 'package:smart_clock/di.dart';
import 'package:smart_clock/domain/repository/tts_repository.dart';

class SpeakUsecase {
  final speakRepository = getIt.get<TTSRepository>();

  void speakResult(String content) {
    speakRepository.speak(content);
  }
}
