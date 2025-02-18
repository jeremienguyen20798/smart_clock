abstract class RingtoneEvent {}

class OnGetRingtoneList extends RingtoneEvent {}

class OnDownloadRingtoneEvent extends RingtoneEvent {
  final String ringtoneUrl;

  OnDownloadRingtoneEvent(this.ringtoneUrl);
}


