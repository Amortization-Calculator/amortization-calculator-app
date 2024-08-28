import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResultWidget extends StatelessWidget {
  final double financeAmount;
  final String name;

  const ResultWidget({
    super.key,
    required this.financeAmount,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final NumberFormat currencyFormatter = NumberFormat('#,##0', 'en_US');

    return Container(
      padding: EdgeInsets.all(24.w),
      width: double.infinity,
      constraints: BoxConstraints(maxWidth: 600.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1.w,
            blurRadius: 1.w,
            offset: Offset(0.w, 1.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 8.h),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: currencyFormatter.format(max(0, financeAmount).round()),
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                TextSpan(
                  text: ' EGP',
                  style: TextStyle(
                    fontSize: 32.sp,
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
