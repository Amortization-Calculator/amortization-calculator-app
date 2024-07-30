import 'package:flutter/material.dart';

class CustomRadioTile<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final String title;
  final ValueChanged<T?> onChanged;

  CustomRadioTile({
    required this.value,
    required this.groupValue,
    required this.title,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile<T>(
      contentPadding: EdgeInsets.all(0.0),
      value: value,
      tileColor: Color(0xFFe05170),
      activeColor: Colors.white,
      dense: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.5)),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          color: Colors.white,
        ),
      ),
      groupValue: groupValue,
      onChanged: onChanged,
    );
  }
}
