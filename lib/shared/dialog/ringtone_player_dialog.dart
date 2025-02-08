import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html;
import 'package:just_audio/just_audio.dart';
import 'package:smart_clock/core/utils/string_utils.dart';

class RingtonePlayerDialog extends StatefulWidget {
  final String name;
  final String ringtoneUrl;

  const RingtonePlayerDialog(
      {super.key, required this.name, required this.ringtoneUrl});

  @override
  State<RingtonePlayerDialog> createState() => _RingtonePlayerDialogState();
}

class _RingtonePlayerDialogState extends State<RingtonePlayerDialog> {
  final ringtonePlayer = AudioPlayer();
  Duration? duration;

  @override
  void initState() {
    getRingtoneData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
        titlePadding: const EdgeInsets.symmetric(horizontal: 12.0),
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            widget.name,
            maxLines: 1,
            style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis),
          ),
          trailing: IconButton(
              color: Colors.grey,
              splashRadius: 24.0,
              onPressed: () {
                ringtonePlayer.pause();
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close, color: Colors.black)),
        ),
        insetPadding: const EdgeInsets.symmetric(horizontal: 12.0),
        contentPadding: EdgeInsets.zero,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: Colors.black,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(StringUtils.formatRingtoneDuration(duration),
                      style:
                          const TextStyle(fontSize: 14.0, color: Colors.white)),
                  Expanded(child: Slider(value: 0.3, onChanged: (value) {})),
                  duration != null
                      ? IconButton(
                          onPressed: () {
                            ringtonePlayer.play();
                          },
                          icon:
                              const Icon(Icons.play_arrow, color: Colors.white))
                      : const SizedBox(),
                  duration != null
                      ? IconButton(
                          onPressed: () async {
                            final ringtoneUrl =
                                await crawlRingtoneData(widget.ringtoneUrl);
                            if (ringtoneUrl != null) {
                              FileDownloader.downloadFile(
                                downloadDestination: DownloadDestinations.appFiles,
                                  url: ringtoneUrl, name: "ringtone");
                            }
                          },
                          icon: const Icon(Icons.pause, color: Colors.white))
                      : const SizedBox()
                ],
              ),
            ),
          ],
        ));
  }

  Future<void> getRingtoneData() async {
    final ringtoneUrl = await crawlRingtoneData(widget.ringtoneUrl);
    if (ringtoneUrl != null) {
      ringtonePlayer.setUrl(ringtoneUrl);
      ringtonePlayer.load().then((value) {
        setState(() {
          duration = value;
        });
      });
    }
  }

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
}
