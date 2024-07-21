import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormWidget extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final IconData icon;
  final String? Function(String?) validator;
  final bool isDouble;
  final bool isNumeric; // Add this line

  const TextFormWidget({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.controller,
    required this.focusNode,
    required this.nextFocusNode,
    required this.icon,
    required this.validator,
    required this.isDouble,
    required this.isNumeric, // Add this line
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text, // Modify this line
        inputFormatters: isNumeric
            ? (isDouble
            ? [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,3}'))]
            : [FilteringTextInputFormatter.digitsOnly])
            : [],
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hintText,
          contentPadding: EdgeInsets.all(20),
          border: OutlineInputBorder(),
          labelText: labelText,
        ),
        validator: validator,
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(nextFocusNode);
        },
      ),
    );
  }
}
