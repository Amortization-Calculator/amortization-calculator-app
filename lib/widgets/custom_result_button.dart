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
  });

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
              color: textColor,  // Ensure icon color matches text color
            ),
          if (imagePath != null || iconData != null) // Add spacing only when an image or icon is present
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
