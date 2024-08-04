import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../home/screens/home_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? expireDateStr = prefs.getString('expireDate');
    print("token");
    print(token);
    print('expireDateStr');
    print(expireDateStr);


    //---------------------------------------------//
    // LogoutService logoutService = LogoutService();
    // await logoutService.logout();
    //---------------------------------------------//


    if (token != null && expireDateStr != null) {
      // Parse the expiration date
      DateTime expireDate = DateTime.parse(expireDateStr);

      if (DateTime.now().isAfter(expireDate)) {
        // Token is expired, delete it and redirect to RegisterScreen
        await prefs.remove('token');
        await prefs.remove('expireDate');
        Get.offAll(() => const LoginScreen());
      } else {
        // Token is valid, redirect to HomeScreen
        Get.offAll(() =>  const HomeScreen());
        // Get.offAll(() => LoginScreen());
      }
    } else {
      // No token, user is not logged in
      Get.offAll(() => const LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
