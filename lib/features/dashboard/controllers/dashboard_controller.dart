import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/dashboard_service.dart';

class DashboardController extends GetxController {
  var userCount = 0.obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  final DashboardService dashboardService = DashboardService();

  @override
  void onInit() {
    super.onInit();
    fetchUserCount();
  }

  void fetchUserCount() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      userCount.value = await dashboardService.fetchUserCount();
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }


  void deactivateAllUsers() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final status = await dashboardService.deactivateAllUsers();
      if (status == 'All users are deactivated.') {
        Get.dialog(
          AlertDialog(
            title: const Text('Success'),
            content: Text(status),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back(); // Close the dialog
                },
                child: const Text('OK'),
              ),
            ],
          ),
          barrierDismissible: false,
        );
      } else {
        Get.dialog(
          AlertDialog(
            title: const Text('Failure'),
            content: Text(status),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back(); // Close the dialog
                },
                child: const Text('OK'),
              ),
            ],
          ),
          barrierDismissible: false,
        );
      }
    } catch (e) {
      Get.dialog(
        AlertDialog(
          title: const Text('Error'),
          content: Text('An error occurred: ${e.toString()}'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        ),
        barrierDismissible: false,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
