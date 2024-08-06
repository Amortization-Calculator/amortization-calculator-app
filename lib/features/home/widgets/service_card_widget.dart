import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceCardWidget extends StatelessWidget {
  final Widget page;
  final String iconPath;
  final String title;

  const ServiceCardWidget({
    super.key,
    required this.page,
    required this.iconPath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => page);
      },
      borderRadius: BorderRadius.circular(15.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Image.asset(
                iconPath,
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
