import 'package:bloc/bloc.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_clock/di.dart';
import 'package:smart_clock/domain/usecase/ringtone_usecase.dart';
import 'package:smart_clock/features/ringtone/bloc/ringtone_event.dart';
import 'package:smart_clock/features/ringtone/bloc/ringtone_state.dart';

import '../../../core/constants/app_constants.dart';

class RingtoneBloc extends Bloc<RingtoneEvent, RingtoneState> {
  final prefs = getIt.get<SharedPreferences>();

  RingtoneBloc() : super(InitialRingtoneState()) {
    on<OnGetRingtoneList>(_getRingtones);
    on<OnDownloadRingtoneEvent>(_onDownloadRingtone);
  }

  Future<void> _getRingtones(
      OnGetRingtoneList event, Emitter<RingtoneState> emitter) async {
    final ringtones = await RingtoneUsecase().getRingtoneList();
    emitter(GetRingtoneListState(ringtones));
  }

  Future<void> _onDownloadRingtone(
      OnDownloadRingtoneEvent event, Emitter<RingtoneState> emitter) async {
    final String? ringtoneUrl =
        await RingtoneUsecase().downloadRingtoneByUrl(event.ringtoneUrl);
    final splitted = ringtoneUrl?.split('/');
    prefs.setString(AppConstants.ringtoneName, splitted?.last ?? '');
    FileDownloader.downloadFile(
        url: event.ringtoneUrl,
        name: splitted?.last,
        downloadDestination: DownloadDestinations.appFiles);
  }
}
