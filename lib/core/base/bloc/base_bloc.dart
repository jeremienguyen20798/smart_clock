import 'package:bloc/bloc.dart';
import 'package:smart_clock/core/base/bloc/base_event.dart';
import 'package:smart_clock/core/base/bloc/base_state.dart';

import '../../../data/repositories/network_manager_service_impl.dart';

class BaseBloc extends Bloc<BaseEvent, BaseState> {
  NetworkManagerServiceImpl networkManagerImpl = NetworkManagerServiceImpl();

  BaseBloc() : super(InitialState()) {
    on<OnCheckInternetStatusEvent>(_onCheckInternetStatus);
  }

  Future<void> _onCheckInternetStatus(
      OnCheckInternetStatusEvent event, Emitter<BaseState> emitter) async {
    final isConnected = await networkManagerImpl.isConnected();
    isConnected ? emitter(HasInternetState()) : emitter(NoInternetState());
  }
}
