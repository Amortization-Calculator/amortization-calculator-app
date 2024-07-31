import 'package:amortization_calculator_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/login_service.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  LoginService loginService = LoginService();

  Future<void> loginUser({
    required String userName,
    required String password,
  }) async {
    isLoading(true);
    try {
      final response = await loginService.loginUser(
        userName: userName,
        password: password,
      );

      if (response['success']) {
        print('here1');
        print(response['token']);
        print(response['userName']);

        // Save token using SharedPreferences
        var token = response['token'];
        var userName = response['userName'];
        var gender= response['gender'];
        var expTime= response['expireDate'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString('gender', gender);
        await prefs.setString('expireDate', expTime);
        await prefs.setString('userName', userName);

        Get.defaultDialog(
          title: 'Success',
          textConfirm: 'Login Successfully',
          onConfirm: () {
            Get.offAll(() => const HomeScreen());
          },
          confirmTextColor: Colors.white,
          buttonColor: Colors.green,
          barrierDismissible: false,
          radius: 10.0,
          content: Column(
            children: [
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 50,
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      } else {
        print('here2');
        Get.defaultDialog(
          title: 'Error',
          middleText: response['message'],
          textConfirm: 'OK',
          onConfirm: () {
            Get.back();
          },
          confirmTextColor: Colors.white,
          buttonColor: Colors.red,
          barrierDismissible: false,
          radius: 10.0,
          content: Column(
            children: [
              const Icon(
                Icons.error,
                color: Colors.red,
                size: 50,
              ),
              const SizedBox(height: 10),
              Text(response['message']),
            ],
          ),
        );
      }
    } catch (error) {
      // Handle registration error
      print('Login failed: $error');
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Login failed: $error',
        textConfirm: 'OK',
        onConfirm: () {
          Get.back();
        },
        confirmTextColor: Colors.white,
        buttonColor: Colors.red,
        barrierDismissible: false,
        radius: 10.0,
        content: Column(
          children: [
            const Icon(
              Icons.error,
              color: Colors.red,
              size: 50,
            ),
            const SizedBox(height: 10),
            Text('Login failed: $error'),
          ],
        ),
      );
    } finally {
      isLoading(false);
    }
  }
}
