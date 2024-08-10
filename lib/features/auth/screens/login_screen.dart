import 'package:amortization_calculator/features/auth/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/text_form_widget.dart';
import '../controller/login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 60.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'lib/assets/logo-transparent-png.png',
                    height: 150.0,
                  ),
                  SizedBox(height: 24.0),
                  Text(
                    'Welcome back,',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Understand Your Repayment Plan.',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF94364a),
                    ),
                  ),
                  SizedBox(height: 24.0),
                  Form(
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          isDouble: false,
                        ),
                        Obx(() => TextFormField(
                          focusNode: _loginController.passwordFocusNode,
                          obscureText: _loginController.obscurePassText.value,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.visiblePassword,
                          controller: _loginController.passwordController,
                          validator: (value) {
                            if (value == null || value.length < 6) {
                              return 'Please enter a valid password';
                            }
                            return null;
                          },
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
                            border: OutlineInputBorder(),
                            labelText: "Password",
                          ),
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        )),
                        SizedBox(height: 50.0),
                        Obx(() => Column(
                          children: [
                            ElevatedButton(
                              onPressed: _loginController.isLoading.value
                                  ? null
                                  : _loginController.login,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _loginController.isLoading.value
                                    ? Colors.grey
                                    : Color(0xFF148C79),
                                minimumSize: Size(double.infinity, 50),
                              ),
                              child: Text(
                                _loginController.isLoading.value
                                    ? 'Logging in...'
                                    : 'Login',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            SizedBox(height: 12.0),
                            ElevatedButton(
                              onPressed: () {
                                Get.to(() => RegisterScreen());
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFe1e2e2),
                                minimumSize: Size(double.infinity, 50),
                              ),
                              child: Text(
                                'Create Account',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Obx(() => _loginController.isLoading.value
              ? Container(
            color: Colors.black54,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
              : SizedBox.shrink()),
        ],
      ),
    );
  }
}
