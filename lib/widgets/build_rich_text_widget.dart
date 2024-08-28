import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RichTextWidget extends StatelessWidget {
  final String firstText;
  final String secondText;
  final double firstFontSize;
  final double secondFontSize;

  const RichTextWidget({
    required this.firstText,
    required this.secondText,
    required this.firstFontSize,
    required this.secondFontSize,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: firstText,
        style: TextStyle(
          fontSize: firstFontSize.sp,
          color: const Color(0xFF970032), // Primary color
          fontWeight: FontWeight.bold,
        ),
        children: <TextSpan>[
          TextSpan(
            text: secondText,
            style: TextStyle(
              fontSize: secondFontSize.sp,
              color: const Color(0xFF5e0210), // Secondary color
            ),
          ),
        ],
      ),
    );
  }
}
