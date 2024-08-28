import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GenericRadioTileWidget<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final String title;
  final void Function(T?)? onChanged;
  final Color tileColor;
  final Color activeColor;
  final double borderRadius;

  const GenericRadioTileWidget({
    super.key,
    required this.value,
    required this.groupValue,
    required this.title,
    required this.onChanged,
    this.tileColor = const Color(0xFFe0516f),
    this.activeColor = Colors.white,
    this.borderRadius = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile<T>(
      value: value,
      tileColor: tileColor,
      activeColor: activeColor,
      dense: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius.sp),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 13.sp,
        ),
      ),
      groupValue: groupValue,
      onChanged: onChanged,
    );
  }
}
