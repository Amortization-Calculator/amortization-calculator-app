import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../widgets/slider_widget.dart';

class SliderContainerWidget extends StatelessWidget {
  final double sliderValue;
  final Function(double) onValueChanged;

  const SliderContainerWidget({
    super.key,
    required this.sliderValue,
    required this.onValueChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1.w,
            blurRadius: 1.w,
            offset: Offset(0.w, 0.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Duration',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text(
                '${sliderValue.round()} years',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          SliderWidget(
            onValueChanged: onValueChanged,
          ),
        ],
      ),
    );
  }
}
