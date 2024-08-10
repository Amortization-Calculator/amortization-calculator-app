import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/loading_overlay_widget.dart';
import '../controller/login_controller.dart';
import '../widgets/header_widget.dart';
import '../widgets/login_form_widget.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 9.0, vertical: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeaderWidget(),
                  const SizedBox(height: 24.0),
                  LoginFormWidget(),
                ],
              ),
            ),
          ),
          LoadingOverlayWidget(
            isLoading: _loginController.isLoading,
          ),
        ],
      ),
    );
  }
}
