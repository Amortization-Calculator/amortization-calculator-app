import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitleWidget extends StatelessWidget {
  final String firstText;
  final String secondText;
  final double fontSize;

  const TitleWidget({
    required this.firstText,
    required this.secondText,
    this.fontSize = 18.0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: firstText,
        style: TextStyle(
          fontSize: fontSize.sp,
          color: const Color(0xFF970032),
          fontWeight: FontWeight.bold,
        ),
        children: <TextSpan>[
          TextSpan(
            text: secondText,
            style: TextStyle(
              fontSize: fontSize.sp,
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
