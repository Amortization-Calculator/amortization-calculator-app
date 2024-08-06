import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/custom_divider_widget.dart';
import '../../../widgets/loading_overlay_widget.dart';
import '../controller/register_controller.dart';
import '../widgets/register_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RegisterController registerController = Get.put(RegisterController());

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.white,
        elevation: 0.5,
        shadowColor: Colors.black,
      ),
      body: GetBuilder<RegisterController>(
        builder: (controller) => Stack(
          children: [
            const SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(8.0),
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
            ),
            LoadingOverlayWidget(isLoading: registerController.isLoading),
          ],
        ),
      ),
    );
  }
}
