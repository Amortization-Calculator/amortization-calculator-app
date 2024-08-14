import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CustomCircularIndicator extends StatelessWidget {
  final double percentage;

  const CustomCircularIndicator({required this.percentage, super.key});

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 100.0,
      lineWidth: 15.0,
      animation: true,
      percent: percentage,
      center: Text(
        "${(percentage * 100).toStringAsFixed(1)}%",
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
      ),
      footer: const Text(
        "Financing Ratio",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17.0,
        ),
      ),
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: const Color(0xFF94364a),
    );
  }
}
