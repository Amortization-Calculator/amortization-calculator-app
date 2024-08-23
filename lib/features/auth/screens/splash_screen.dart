import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/splash_controller.dart';
import '../../internet/controllers/network_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SplashController authController = Get.put(SplashController());
    final NetworkController networkController = Get.find<NetworkController>();


    networkController.connectionStatus.listen((status) {
      if (status != ConnectivityResult.none) {
        authController.checkLoginStatus();
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('lib/assets/logo_1024.png'),
      ),
    );
  }
}
