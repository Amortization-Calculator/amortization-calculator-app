import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../widgets/loading_overlay_widget.dart';
import '../controllers/login_controller.dart';
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
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 40.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeaderWidget(),
                  SizedBox(height: 24.h),
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
