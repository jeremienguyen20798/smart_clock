import 'package:flutter_tts/flutter_tts.dart';
import 'package:smart_clock/domain/repository/tts_repository.dart';

class TTSRepositories extends TTSRepository {
  FlutterTts flutterTts = FlutterTts();

  @override
  Future<dynamic> speak(String input) async {
    final result = await flutterTts.speak(input);
    return result;
  }
}
