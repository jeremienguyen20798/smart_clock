abstract class NetworkManagerService {
  void internetChangeListen();

  Future<bool> isConnected();
}
