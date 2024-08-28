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
             CustomDividerWidget(),
            const SizedBox(height: 20),
            Center(
              child: Obx(() {

                final userCount = dashboardController.isLoading.value
                    ? 0
                    : dashboardController.userCount.value;

                // Show an error message if there is an error
                if (dashboardController.errorMessage.isNotEmpty) {
                  return Text(
                    'Error: ${dashboardController.errorMessage.value}',
                    style: const TextStyle(color: Colors.red),
                  );
                }

                // Display the result widget with the user count
                return ResultWidget(
                  title: 'Number Of Users',
                  suffix: 'User',
                  value: userCount,
                );
              }),
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
