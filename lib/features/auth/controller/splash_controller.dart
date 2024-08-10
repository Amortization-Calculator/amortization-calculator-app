import 'package:get/get.dart';

import '../../home/screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../services/splash_service.dart';

class SplashController extends GetxController {
   final SplashService splashService = SplashService();

  Future<void> checkLoginStatus() async {
    String? token = await splashService.getToken();
    String? expireDateStr = await splashService.getExpireDate();

    if (token != null && expireDateStr != null) {

      DateTime expireDate = DateTime.parse(expireDateStr);

      if (DateTime.now().isAfter(expireDate)) {
        await splashService.removeToken();
        Get.offAll(() =>  LoginScreen());
      } else {
        Get.offAll(() => const HomeScreen());
      }
    } else {
      Get.offAll(() =>  LoginScreen());
    }
  }
}