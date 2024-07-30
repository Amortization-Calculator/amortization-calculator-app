import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/register_service.dart';

class RegisterController extends GetxController {
  var isLoading = false.obs;
  RegisterService registerService = RegisterService();

  Future<void> registerUser({
    required String firstName,
    required String lastName,
    required String userName,
    required String email,
    required String password,
    required String phoneNumber,
    required String gender,
    required String userType,
  }) async {
    isLoading(true);
    final response = await registerService.registerUser(
      firstName: firstName,
      lastName: lastName,
      userName: userName,
      email: email,
      password: password,
      phoneNumber: phoneNumber,
      gender: gender,
      userType: userType,
    );
    isLoading(false);

    if (response['success']) {
      Get.defaultDialog(
        title: 'Success',
        middleText: response['message'],
        textConfirm: 'back to login page',
        onConfirm: () {
          Get.back();
          Get.back();

        },
        confirmTextColor: Colors.white,
        buttonColor: Colors.green,
        barrierDismissible: false,
        radius: 10.0,
        content: Column(
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 50,
            ),
            SizedBox(height: 10),
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
          print(response['message']);
          Get.back();
        },
        confirmTextColor: Colors.white,
        buttonColor: Colors.red,
        barrierDismissible: false,
        radius: 10.0,
        content: Column(
          children: [
            Icon(
              Icons.error,
              color: Colors.red,
              size: 50,
            ),
            SizedBox(height: 10),
            Text(response['message']),
          ],
        ),
      );
    }
  }
}
