import 'package:flutter/material.dart';

class RichTextWidget extends StatelessWidget {
  final String firstText;
  final String secondText;
  final double firstFontSize;
  final double secondFontSize;

  const RichTextWidget({
    required this.firstText,
    required this.secondText,
    required this.firstFontSize,
    required this.secondFontSize,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: firstText,
        style: TextStyle(
          fontSize: firstFontSize,
          color: Color(0xFF970032), // Primary color
          fontWeight: FontWeight.bold,
        ),
        children: <TextSpan>[
          TextSpan(
            text: secondText,
            style: TextStyle(
              fontSize: secondFontSize,
              color: Color(0xFF5e0210), // Secondary color
            ),
          ),
        ],
      ),
    );
  }
}
