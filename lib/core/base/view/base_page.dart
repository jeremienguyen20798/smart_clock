import 'package:flutter/material.dart';

import '../../../data/repositories/network_manager_service_impl.dart';

class BasePage extends StatefulWidget {
  final Widget view;
  const BasePage({super.key, required this.view});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  NetworkManagerServiceImpl networkManagerImpl = NetworkManagerServiceImpl();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    networkManagerImpl.internetChangeListen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: networkManagerImpl.onConnectivityChanged,
            builder: (context, snasphot) {
              if (snasphot.hasError) {
                scaffoldMessengerKey.currentState?.showSnackBar(
                    const SnackBar(content: Text('Không có kết nối mạng')));
              } else if (snasphot.hasData) {
                scaffoldMessengerKey.currentState?.showSnackBar(
                    const SnackBar(content: Text('Đã có kết nối mạng')));
              }
              return widget.view;
            }));
  }
}
