abstract class SpeechToTextRepository {
  Future<void> startListening(
      Function(String) onRecognizeText, Function(String) onListening);
  Future<void> stopListening();
}
