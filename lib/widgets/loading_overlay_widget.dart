import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingOverlayWidget extends StatelessWidget {
  final RxBool isLoading;

  const LoadingOverlayWidget({required this.isLoading, super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (isLoading.value) {
        return  Container(
          color: Colors.black54,
          width: double.infinity, // Full screen width
          height: double.infinity, // Full screen height
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }
}
