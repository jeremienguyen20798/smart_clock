import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_clock/features/ringtone/bloc/ringtone_bloc.dart';
import 'package:smart_clock/features/ringtone/bloc/ringtone_event.dart';
import 'package:smart_clock/features/ringtone/bloc/ringtone_state.dart';

import '../../../core/utils/dialog_utils.dart';
import '../../../data/models/ringtone.dart';

class RingtoneView extends StatelessWidget {
  const RingtoneView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'ringtone'.tr(),
            style: const TextStyle(
              fontSize: 18.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body:
            BlocBuilder<RingtoneBloc, RingtoneState>(builder: (context, state) {
          List<Ringtone> ringtones = [];
          if (state is GetRingtoneListState) {
            ringtones = state.ringtones;
          }
          if (ringtones.isNotEmpty) {
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
                    context
                        .read<RingtoneBloc>()
                        .add(OnDownloadRingtoneEvent(ringtones[index].url));
                  },
                  icon: const Icon(Icons.cloud_download, color: Colors.blue),
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }));
  }
}
