import 'package:flutter/material.dart';

class DropdownWidget extends StatelessWidget {
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final String labelText;

  const DropdownWidget({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items
          .map((e) => DropdownMenuItem(
        child: Text(e),
        value: e,
      ))
          .toList(),
      onChanged: onChanged,
      icon: const Icon(
        Icons.arrow_drop_down_circle,
        color: Color(0xFF94364a),
      ),
      dropdownColor: Colors.white,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
    );
  }
}
