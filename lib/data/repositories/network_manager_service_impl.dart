import 'dart:async';

import "package:connectivity_plus/connectivity_plus.dart";
import 'package:smart_clock/domain/repository/network_manager_service.dart';

class NetworkManagerServiceImpl implements NetworkManagerService {
  final Connectivity _connectivity = Connectivity();
  final StreamController<List<ConnectivityResult>> _controller =
      StreamController<List<ConnectivityResult>>.broadcast();

  @override
  void internetChangeListen() {
    _connectivity.onConnectivityChanged.listen((result) {
      _controller.add(result);
    });
  }

  Stream<List<ConnectivityResult>> get onConnectivityChanged => _controller.stream;

  @override
  Future<bool> isConnected() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    return !connectivityResult.contains(ConnectivityResult.none);
  }
}
