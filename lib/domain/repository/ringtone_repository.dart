import 'package:smart_clock/data/models/ringtone.dart';

abstract class RingtoneRepository {
  Future<List<Ringtone>> crawlRingtones();

  Future<String?> crawlRingtoneData(String url);
}
