import 'package:smart_clock/data/models/ringtone.dart';
import 'package:smart_clock/di.dart';
import 'package:smart_clock/domain/repository/ringtone_repository.dart';

class RingtoneUsecase {
  final repository = getIt.get<RingtoneRepository>();

  Future<List<Ringtone>> getRingtoneList() async {
    final ringtoneList = await repository.crawlRingtones();
    return ringtoneList;
  }

  Future<String?> downloadRingtoneByUrl(String url) async {
    final ringtoneUrl = await repository.crawlRingtoneData(url);
    return ringtoneUrl;
  }
}
