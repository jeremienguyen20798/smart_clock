import 'package:equatable/equatable.dart';

import '../../../data/models/ringtone.dart';

abstract class RingtoneState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialRingtoneState extends RingtoneState {}

class GetRingtoneListState extends RingtoneState {
  final List<Ringtone> ringtones;

  GetRingtoneListState(this.ringtones);

  @override
  List<Object?> get props => [ringtones];
}
