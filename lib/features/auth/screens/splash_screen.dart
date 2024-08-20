import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/splash_controller.dart';
import '../../internet/controllers/network_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the SplashController and NetworkController
    final SplashController authController = Get.put(SplashController());
    final NetworkController networkController = Get.find<NetworkController>();

    // Observe the connection status and act accordingly
    networkController.connectionStatus.listen((status) {
      if (status != ConnectivityResult.none) {
        // When there's an active connection, proceed to check login status
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
