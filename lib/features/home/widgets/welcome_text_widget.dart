import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/home_service.dart';

class WelcomeTextWidget extends StatelessWidget {
  const WelcomeTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeService homeService = Get.put(HomeService());
    return Obx(() {
      return RichText(
        text: TextSpan(
          text: 'Welcome ',
          style: const TextStyle(
            fontSize: 22,
            color: Color(0xFF970032),
            fontWeight: FontWeight.bold,
          ),
          children: <TextSpan>[
            TextSpan(
              text: homeService.userName.value,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ],
        ),
      );
    });
  }
}
