import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../home/screens/home_screen.dart';
import '../services/register_service.dart';
import '../../../constants/enums.dart';

class RegisterController extends GetxController {
  final formKey = GlobalKey<FormState>();
  Rx<IndividualCompanyEnum> individualCompanyEnum =
      IndividualCompanyEnum.Individual.obs;
  Rx<GenderEnum> genderEnum = GenderEnum.Male.obs;

  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController confirmPasswordTextController =
      TextEditingController();

  // Focus Nodes
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  // Visibility and Loading states
  bool obscurePassText = true;
  bool obscureConfirmPassText = true;
  var isLoading = false.obs;

  final RegisterService registerService = RegisterService();

  Future<void> registerUser() async {
    if (formKey.currentState!.validate()) {
      isLoading(true);
      try {
        final response = await registerService.registerUser(
          userName: nameController.text,
          email: emailController.text,
          password: passwordTextController.text,
          phoneNumber: phoneController.text,
          gender: genderEnum.value == GenderEnum.Male ? 'MALE' : 'FEMALE',
          userType: individualCompanyEnum.value == IndividualCompanyEnum.Individual
              ? 'INDIVIDUAL'
              : 'COMPANY',
        );

        if (response['success']) {
          // Save token using SharedPreferences
          var token = response['token'];
          var gender = response['gender'];
          var expTime = response['expireDate'];
          var userName = response['userName'];

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

}
