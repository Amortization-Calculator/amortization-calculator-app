import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ServiceCardWidget extends StatelessWidget {
  final String page;
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
        Get.toNamed(page);
      },
      borderRadius: BorderRadius.circular(15.r),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
          color: Colors.white,
          elevation: 1,
          child: Padding(
            padding: EdgeInsets.all(16.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 80.h,
                  width: 80.w,
                  child: Image.asset(
                    iconPath,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 40.sp,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
