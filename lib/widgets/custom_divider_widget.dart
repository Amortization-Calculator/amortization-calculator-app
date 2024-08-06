import 'package:flutter/material.dart';

class CustomDividerWidget extends StatelessWidget {
  const CustomDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Divider(
        height: 20,
        thickness: 2,
        indent: 150,
        endIndent: 150,
        color: Color(0xFF94364a),
      ),
    );
  }
}
