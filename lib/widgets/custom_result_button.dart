import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomResultButton extends StatelessWidget {
  final Future<void> Function() onPressed;
  final String? imagePath;   // Optional image path
  final IconData? iconData;  // Optional icon
  final String buttonText;
  final Color buttonColor;
  final Color textColor;

  const CustomResultButton({
    required this.onPressed,
    this.imagePath,
    this.iconData,
    required this.buttonText,
    required this.buttonColor,
    this.textColor = Colors.white,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        minimumSize: Size(double.infinity, 50.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (imagePath != null)
            Image.asset(
              imagePath!,
              height: 24.h,
              width: 24.w,
            ),
          if (iconData != null)
            Icon(
              iconData,
              size: 24.sp,
              color: textColor,
            ),
          if (imagePath != null || iconData != null) // Add spacing only when an image or icon is present
            SizedBox(width: 10.w),
          Text(
            buttonText,
            style: TextStyle(
              color: textColor,  // Use the user-specified or default text color
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }
}
