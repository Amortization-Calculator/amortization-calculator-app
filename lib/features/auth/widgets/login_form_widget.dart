import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../validators.dart';
import '../controllers/login_controller.dart';
import '../../../widgets/text_form_widget.dart';
import '../screens/register_screen.dart';

class LoginFormWidget extends StatelessWidget {
  final LoginController _loginController = Get.put(LoginController());

  LoginFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginController.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormWidget(
            labelText: 'Name',
            hintText: 'Enter your name',
            controller: _loginController.nameController,
            focusNode: _loginController.nameFocusNode,
            nextFocusNode: _loginController.passwordFocusNode,
            icon: Icons.person,
            isNumeric: false,
            validator: (value) => validateName(value),
            isDouble: false,
          ),
          Obx(
            () => TextFormField(
              focusNode: _loginController.passwordFocusNode,
              obscureText: _loginController.obscurePassText.value,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.visiblePassword,
              controller: _loginController.passwordController,
              validator: (value) => validatePassword(value),
              decoration: InputDecoration(
                hintText: "Enter Your Password",
                suffixIcon: GestureDetector(
                  onTap: _loginController.togglePasswordVisibility,
                  child: Icon(
                    _loginController.obscurePassText.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.black,
                  ),
                ),
                border: const OutlineInputBorder(),
                labelText: "Password",
              ),
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 50.0),
          Obx(() => Column(
                children: [
                  ElevatedButton(
                    onPressed: _loginController.isLoading.value
                        ? null
                        : _loginController.login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _loginController.isLoading.value
                          ? Colors.grey
                          : const Color(0xFF148C79),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: Text(
                      _loginController.isLoading.value
                          ? 'Logging in...'
                          : 'Login',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(() =>  RegisterScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFe1e2e2),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      'Create Account',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
