import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          'lib/assets/logo-transparent-png.png',
          height: 150.0,
        ),
        const SizedBox(height: 24.0),
        const Text(
          'Welcome back,',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),
        const Text(
          'Understand Your Repayment Plan.',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF94364a),
          ),
        ),
      ],
    );
  }
}
