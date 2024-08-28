import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFormWidget extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final IconData icon;
  final String? Function(String?) validator;
  final bool isDouble;
  final bool isNumeric;

  const TextFormWidget({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.controller,
    required this.focusNode,
    required this.nextFocusNode,
    required this.icon,
    required this.validator,
    required this.isDouble,
    required this.isNumeric,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0.h),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        inputFormatters: isNumeric
            ? (isDouble
            ? [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,3}'))]
            : [FilteringTextInputFormatter.digitsOnly])
            : [],
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, size: 24.0.sp),
          hintText: hintText,
          contentPadding: EdgeInsets.all(20.0.w),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0.r),
          ),
          labelText: labelText,
          labelStyle: TextStyle(fontSize: 16.0.sp),
        ),
        validator: validator,
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(nextFocusNode);
        },
      ),
    );
  }
}
