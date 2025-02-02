import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html;
import 'package:smart_clock/core/constants/app_constants.dart';
import 'package:smart_clock/core/utils/dialog_utils.dart';
import 'package:smart_clock/data/models/ringtone.dart';

class RingtoneBottomsheet extends StatelessWidget {
  const RingtoneBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Ringtone>>(
        future: crawlRingtones(),
        builder: (context, snapshot) {
          List<Ringtone> ringtones = [];
          if (snapshot.data != null) {
            ringtones = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.only(top: kToolbarHeight * 0.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    contentPadding:
                        const EdgeInsets.only(left: 12.0, right: 12.0),
                    title: const Text(
                      'Nhạc chuông',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: IconButton(
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.grey.shade300)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.black,
                        )),
                  ),
                  Expanded(
                      child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: ringtones.length,
                    itemBuilder: (context, index) => ListTile(
                      onTap: () {
                        DialogUtils.showPlayerDialog(context,
                            ringtones[index].name, ringtones[index].url);
                      },
                      horizontalTitleGap: 16.0,
                      title: Text(
                        ringtones[index].name,
                        maxLines: 1,
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                            fontSize: 16.0),
                      ),
                      subtitle: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.headphones,
                              color: Colors.blue, size: 16.0),
                          const SizedBox(width: 4.0),
                          Text(
                            ringtones[index].formatNumber(),
                            style: const TextStyle(
                                color: Colors.black,
                                overflow: TextOverflow.ellipsis,
                                fontSize: 14.0),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.cloud_download,
                            color: Colors.blue),
                      ),
                    ),
                  ))
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }

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
