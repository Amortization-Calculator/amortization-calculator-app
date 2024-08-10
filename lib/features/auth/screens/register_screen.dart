import 'package:amortization_calculator/widgets/custom_appBar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/custom_divider_widget.dart';
import '../../../widgets/loading_overlay_widget.dart';
import '../controller/register_controller.dart';
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
            const SingleChildScrollView(
                child: Column(
              children: [
                CustomAppBar( showLogout: false,),
                Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 9.0, vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Let's create your account",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      SizedBox(height: 24.0),
                      CustomDividerWidget(),
                      SizedBox(height: 24.0),
                      RegisterForm(),
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
