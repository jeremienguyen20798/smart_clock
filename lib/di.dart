import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_clock/data/repositories/remote_config_repository_impl.dart';
import 'package:smart_clock/data/repositories/speech_to_text_repository_impl.dart';
import 'package:smart_clock/data/repositories/tts_repositories.dart';
import 'package:smart_clock/domain/repository/remote_config_repository.dart';
import 'package:smart_clock/domain/repository/tts_repository.dart';
import 'package:smart_clock/hive_registrar.g.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'domain/repository/speech_to_text_repository.dart';

final GetIt getIt = GetIt.instance;

class DependencyInjection {
  static Future<void> setUp() async {
    final preferences = await SharedPreferences.getInstance();
    getIt.registerSingleton<SharedPreferences>(preferences);
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    Hive.registerAdapters();
    if (kReleaseMode) {
      SpeechToText speechToText = SpeechToText();
      SpeechToTextRepository repository =
          SpeechToTextRepositoryImpl(speechToText);
      getIt.registerSingleton<SpeechToTextRepository>(repository);
      final remoteConfigRepo = RemoteConfigRepositoryImpl();
      getIt.registerSingleton<RemoteConfigRepository>(remoteConfigRepo);
      TTSRepository ttsRepository = TTSRepositories();
      getIt.registerSingleton<TTSRepository>(ttsRepository);
    }
  }
}
