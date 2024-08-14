import 'package:flutter/material.dart';

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
  }) : assert(imagePath != null || iconData != null, 'Either imagePath or iconData must be provided.');

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        minimumSize: const Size(double.infinity, 50.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (imagePath != null)
            Image.asset(
              imagePath!,
              height: 24.0,
              width: 24.0,
            ),
          if (iconData != null)
            Icon(
              iconData,
              size: 24.0,
              color: Colors.white,
            ),
          const SizedBox(width: 10.0),
          Text(
            buttonText,
            style: TextStyle(
              color: textColor,  // Use the user-specified or default text color
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
