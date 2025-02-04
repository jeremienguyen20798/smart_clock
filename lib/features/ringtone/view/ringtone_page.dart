import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html;

import '../../../core/constants/app_constants.dart';
import '../../../core/utils/dialog_utils.dart';
import '../../../data/models/ringtone.dart';

class RingtonePage extends StatelessWidget {
  const RingtonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'ringtone'.tr(),
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: FutureBuilder(
            future: crawlRingtones(),
            builder: (context, snapshot) {
              List<Ringtone> ringtones = [];
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              }
              ringtones = snapshot.data!;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: ringtones.length,
                itemBuilder: (context, index) => ListTile(
                  onTap: () {
                    DialogUtils.showPlayerDialog(
                        context, ringtones[index].name, ringtones[index].url);
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
                    onPressed: () {
                      
                    },
                    icon: const Icon(Icons.cloud_download, color: Colors.blue),
                  ),
                ),
              );
            }));
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
