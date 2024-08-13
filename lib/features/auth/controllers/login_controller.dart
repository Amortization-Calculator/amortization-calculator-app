import 'package:amortization_calculator/features/auth/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../dashboard/screens/dashboard_screen.dart';
import '../../home/screens/home_screen.dart';
import '../../leasing/screens/result_screen.dart';
import '../services/login_service.dart';


class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  final LoginService loginService = LoginService();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  RxBool obscurePassText = true.obs;

  void togglePasswordVisibility() {
    obscurePassText.value = !obscurePassText.value;
  }

  Future<void> login() async {
    FocusScope.of(Get.context!).unfocus();

    if (formKey.currentState!.validate()) {
      isLoading(true);
      try {
        final response = await loginService.loginUser(
          userName: nameController.text,
          password: passwordController.text,
        );

        if (response['success']) {
          final userModel = UserModel.fromJson(response);
          _saveUserToPreferences(userModel);
          Get.defaultDialog(
            title: 'Success',
            textConfirm: 'Login Successfully',
            onConfirm: () {
              if(userModel.userName=='admin'){
                Get.offAll(() => const DashboardScreen());
              }else{
                Get.offAll(() => const HomeScreen());
              }

            },
            confirmTextColor: Colors.white,
            buttonColor: Colors.green,
            barrierDismissible: false,
            radius: 10.0,
            content: const Column(
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 50,
                ),
                SizedBox(height: 10),
              ],
            ),
          );
        } else {
          _showErrorDialog(response['message']);
        }
      } catch (error) {
        _showErrorDialog(error.toString());
      } finally {
        isLoading(false);
      }
    }
  }

  void _saveUserToPreferences(UserModel user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', user.token);
    await prefs.setString('expireDate', user.expireDate);
    await prefs.setString('userName', user.userName);
    await prefs.setString('gender', user.gender);
  }

  void _showErrorDialog(String message) {
    Get.defaultDialog(
      title: 'Error',
      middleText: message,
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
          Text(message), // Display the message
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
