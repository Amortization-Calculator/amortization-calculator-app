import 'package:flutter/material.dart';

class CustomDividerWidget extends StatelessWidget {
  final double height;
  final double index;

  const CustomDividerWidget({super.key, this.height = 20, this.index=140.0});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Divider(
        height: height,
        thickness: 2,
        indent: index,
        endIndent: index,
        color: const Color(0xFF94364a),
      ),
    );
  }
}
