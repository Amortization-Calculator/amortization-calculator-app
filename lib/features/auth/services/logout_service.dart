import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/login_screen.dart';

class LogoutService {
  Future<void> logout() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      Get.offAll(() => const LoginScreen());

    } catch (e) {
      print("Error clearing shared preferences: $e");
    }
  }
}
