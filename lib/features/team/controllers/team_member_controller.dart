import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class TeamMemberController extends GetxController {
  Future<void> launchUrlInApp(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      await launchUrl(uri, mode: LaunchMode.externalNonBrowserApplication);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Could not launch URL.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
  void copyEmailToClipboard(String email) {
    Clipboard.setData(ClipboardData(text: email)).then((_) {
      Get.snackbar(
        'Copied',
        'Email copied to clipboard',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    });
  }
}
