import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:smart_clock/core/constants/app_constants.dart';
import 'package:smart_clock/features/home/view/home_page.dart';

import 'data/repositories/network_manager_service_impl.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  NetworkManagerServiceImpl networkManagerImpl = NetworkManagerServiceImpl();

  @override
  void initState() {
    networkManagerImpl.internetChangeListen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ConnectivityResult>>(
        stream: networkManagerImpl.onConnectivityChanged,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.contains(ConnectivityResult.none)) {
              EasyLoading.showToast("Không có kết nối mạng");
            }
          }
          return MaterialApp(
              title: AppConstants.appName,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              builder: EasyLoading.init(),
              home: const HomePage());
        });
  }
}
