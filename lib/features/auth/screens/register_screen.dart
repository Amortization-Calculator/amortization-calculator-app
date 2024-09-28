import 'package:amortization_calculator/widgets/custom_appBar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../widgets/custom_divider_widget.dart';
import '../../../widgets/loading_overlay_widget.dart';
import '../controllers/register_controller.dart';
import '../widgets/register_form.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final RegisterController _registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<RegisterController>(
        builder: (controller) => Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomAppBar(showLogout: false),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Let's create your account",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22.sp,
                          ),
                        ),
                        // SizedBox(height: 5.h),
                        CustomDividerWidget(),
                        SizedBox(height: 5.h),
                        const RegisterForm(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            LoadingOverlayWidget(isLoading: _registerController.isLoading),
          ],
        ),
      ),
    );
  }
}
