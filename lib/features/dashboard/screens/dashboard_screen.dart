import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/custom_appBar_widget.dart';
import '../../../widgets/custom_divider_widget.dart';
import '../../../widgets/custom_result_button.dart';
import '../../../widgets/result_widget.dart';
import '../../home/widgets/welcome_text_widget.dart';
import '../controllers/dashboard_controller.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DashboardController dashboardController =
        Get.put(DashboardController());

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const WelcomeTextWidget(),
            const SizedBox(height: 20),
            const CustomDividerWidget(),
            const SizedBox(height: 20),
            Center(
              child: Obx(
                () {
                  return ResultWidget(
                    title: 'Number Of Users',
                    suffix: 'User',
                    value: dashboardController.userCount,
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            CustomResultButton(
              buttonColor: Colors.red,
              onPressed: () async {
                dashboardController.deactivateAllUsers();
              },
              buttonText: 'Deactivate All Users',
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
