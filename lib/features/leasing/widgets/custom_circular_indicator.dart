import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CustomCircularIndicator extends StatelessWidget {
  final double percentage;

  const CustomCircularIndicator({
    required this.percentage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 95.w,
      lineWidth: 15.w,
      animation: true,
      percent: percentage,
      center: Text(
        "${(percentage * 100).toStringAsFixed(1)}%",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.sp,
        ),
      ),
      footer: Text(
        "Financing Ratio",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17.sp,
        ),
      ),
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: const Color(0xFF94364a),
    );
  }
}
