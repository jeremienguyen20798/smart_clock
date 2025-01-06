import 'package:flutter/material.dart';

class WarningDialog extends StatelessWidget {
  final String title;
  final String content;

  const WarningDialog({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop("settings");
          },
          child: const Text('Cài đặt'),
        ),
      ],
    );
  }
}
