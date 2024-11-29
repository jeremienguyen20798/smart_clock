import '../../di.dart';
import '../repository/speech_to_text_repository.dart';

class StopListeningUsecase {
  final repository = getIt.get<SpeechToTextRepository>();

  Future<void> call() async {
    await repository.stopListening();
  }
}
