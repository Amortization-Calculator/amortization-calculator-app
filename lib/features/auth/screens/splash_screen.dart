
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final SplashController authController = Get.put(SplashController());

    authController.checkLoginStatus();

    return  Scaffold(
      body: Center(
        child: Image.asset(
          'lib/assets/logo_1024.png'
      ),
      ),
    );
  }
}
