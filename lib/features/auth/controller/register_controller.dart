import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../home/screens/home_screen.dart';
import '../services/register_service.dart';

class RegisterController extends GetxController {
  var isLoading = false.obs;
  RegisterService registerService = RegisterService();

  Future<void> registerUser({
    required String userName,
    required String email,
    required String password,
    required String phoneNumber,
    required String gender,
    required String userType,
  }) async {
    isLoading(true);
    try {
      final response = await registerService.registerUser(
        userName: userName,
        email: email,
        password: password,
        phoneNumber: phoneNumber,
        gender: gender,
        userType: userType,
      );

      if (response['success']) {
        // Save token using SharedPreferences
        var token = response['token'];
        var gender= response['gender'];
        var expTime= response['expireDate'];
        var userName = response['userName'];
        // print(expTime);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString('gender', gender);
        await prefs.setString('expireDate', expTime);
        await prefs.setString('userName', userName);

        Get.defaultDialog(
          title: 'Success',
          middleText: response['message'],
          textConfirm: 'Registered Successfully',
          onConfirm: () {
            Get.offAll(() => HomeScreen());
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
              Text(response['message']),
            ],
          ),
        );
      } else {
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
      print('Registration failed: $error');
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Registration failed: $error',
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
            Text('Registration failed: $error'),
          ],
        ),
      );
    } finally {
      isLoading(false);
    }
  }
}
