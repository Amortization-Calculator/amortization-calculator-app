import 'package:flutter/material.dart';

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
    this.tileColor = const Color(0xFF148C79),
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
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15
        ),
      ),
      groupValue: groupValue,
      onChanged: onChanged,
    );
  }
}
