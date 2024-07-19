import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormWidget extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final IconData icon;

  const TextFormWidget({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.controller,
    required this.focusNode,
    required this.nextFocusNode,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hintText,
          contentPadding: EdgeInsets.all(20),
          border: OutlineInputBorder(),
          labelText: labelText,
        ),
        validator: (value) {
          if (value == null || value.isEmpty||value==0) {
            return 'Please enter $labelText';
          }
          return null;
        },
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(nextFocusNode);
        },
      ),
    );
  }
}
