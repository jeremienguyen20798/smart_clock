import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:smart_clock/core/utils/string_utils.dart';

import '../../domain/usecase/ringtone_usecase.dart';

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
  Duration? duration, position;
  bool isPlaying = false;

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
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(StringUtils.formatRingtoneDuration(position),
                      style:
                          const TextStyle(fontSize: 14.0, color: Colors.white)),
                  Expanded(
                      child: Slider(
                          value: position != null && duration != null
                              ? (position!.inSeconds / duration!.inSeconds)
                              : 0.0,
                          allowedInteraction: SliderInteraction.slideOnly,
                          onChanged: (value) {})),
                  Text(StringUtils.formatRingtoneDuration(duration),
                      style:
                          const TextStyle(fontSize: 14.0, color: Colors.white)),
                  duration != null
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              if (ringtonePlayer.playing) {
                                ringtonePlayer.pause();
                                isPlaying = false;
                              } else {
                                ringtonePlayer.play();
                                isPlaying = true;
                              }
                            });
                          },
                          icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow,
                              color: Colors.white))
                      : const SizedBox(),
                ],
              ),
            ),
          ],
        ));
  }

  Future<void> getRingtoneData() async {
    final ringtoneUrl =
        await RingtoneUsecase().downloadRingtoneByUrl(widget.ringtoneUrl);
    if (ringtoneUrl != null) {
      ringtonePlayer.setUrl(ringtoneUrl);
      ringtonePlayer.load().then((value) {
        setState(() {
          duration = value;
        });
      });
      ringtonePlayer.positionStream.listen((event) {
        setState(() {
          position = event;
        });
      });
    }
  }
}
