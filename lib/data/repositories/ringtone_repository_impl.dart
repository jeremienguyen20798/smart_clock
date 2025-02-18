import 'package:smart_clock/data/models/ringtone.dart';
import 'package:smart_clock/domain/repository/ringtone_repository.dart';

import '../../core/constants/app_constants.dart';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html;

class RingtoneRepositoryImpl extends RingtoneRepository {
  
  @override
  Future<String?> crawlRingtoneData(String url) async {
    final response = await http.get(Uri.parse(url));
    final document = html.parse(response.body);
    final elements = document.getElementsByClassName('single-top');
    final ringtoneContentElement = elements.last;
    final audioItems =
        ringtoneContentElement.getElementsByClassName('audio-item-play');
    final audioPlayers = audioItems.first.children;
    final audioUrl = audioPlayers.first
        .getElementsByTagName('source')
        .first
        .attributes['src'];
    return audioUrl;
  }

  @override
  Future<List<Ringtone>> crawlRingtones() async {
    List<Ringtone> dataList = [];
    final response = await http.get(Uri.parse(AppConstants.ringtoneUrl));
    final documents = html.parse(response.body);
    final elements = documents.getElementsByClassName('page-100-item');
    for (var element in elements) {
      if (element.className == 'page-100-item') {
        final items = element.getElementsByClassName('item');
        final title = items.first.getElementsByTagName('h3').first.text.trim();
        final numberOfListens = items[1].text.trim();
        final url =
            items.last.getElementsByTagName('a').first.attributes['href'] ?? '';
        dataList.add(
            Ringtone(name: title, url: url, numberOfListens: numberOfListens));
      }
    }
    return dataList;
  }
}
