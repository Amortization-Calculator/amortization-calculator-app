import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart';

class ResultWidget extends StatelessWidget {
  final double financeAmount;
  final String name;

  const ResultWidget({
    super.key,
    required this.financeAmount,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final NumberFormat currencyFormatter = NumberFormat('#,##0', 'en_US');

    return Container(
      padding: const EdgeInsets.all(24.0),
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 600),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16.0),
          Text(
            name,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 8.0),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: currencyFormatter.format(max(0, financeAmount).round()),
                  style: const TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                const TextSpan(
                  text: ' EGP',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
