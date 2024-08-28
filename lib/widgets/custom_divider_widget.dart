import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDividerWidget extends StatelessWidget {
  final double height;
  final double index;

   CustomDividerWidget({
    super.key,
    double? height,
    double? index,
  })  : height = height ?? 20.h,
        index = index ?? 140.w;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Divider(
        height: height,
        thickness: 2,
        indent: index,
        endIndent: index,
        color: const Color(0xFF94364a),
      ),
    );
  }
}
