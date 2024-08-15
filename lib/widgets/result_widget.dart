import 'package:flutter/material.dart';


class ResultWidget extends StatelessWidget {
  final int value;
  final String title;
  final String suffix;

  const ResultWidget({
    super.key,
    required this.value,
    required this.title,
    required this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    final formattedValue = (value).toString();
    return Container(
      padding: const EdgeInsets.all(24.0),
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: double.infinity),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          Text(
            title,
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
                  text: formattedValue,
                  style: const TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                TextSpan(
                  text: ' $suffix',
                  style: const TextStyle(
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
