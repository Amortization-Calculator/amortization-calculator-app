import 'package:flutter/material.dart';

class PopUpAlertDialog extends StatelessWidget {
  final String? title;
  final String? content;
  const PopUpAlertDialog({super.key,
    this.title,
    this.content});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title!),
      content: Text(content!),
      actions: <Widget>[
        TextButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
