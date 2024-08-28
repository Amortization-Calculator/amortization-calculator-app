import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          'lib/assets/logo-transparent-png.png',
          height: 150.h,
        ),
        SizedBox(height: 24.h),
        Text(
          'Welcome back,',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Understand Your Repayment Plan.',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF94364a),
          ),
        ),
      ],
    );
  }
}
