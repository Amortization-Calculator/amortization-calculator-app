import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResultWidget extends StatelessWidget {
  final int value;
  final String title;
  final String suffix;

  const ResultWidget({
    super.key,
    required this.value,
    required this.title,
    required this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    final formattedValue = value.toString();
    return Container(
      padding: EdgeInsets.all(24.0.w),
      width: double.infinity,
      constraints: BoxConstraints(maxWidth: 400.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20.0.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 8.0.h),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: formattedValue,
                  style: TextStyle(
                    fontSize: 32.0.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                TextSpan(
                  text: ' $suffix',
                  style: TextStyle(
                    fontSize: 32.0.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
