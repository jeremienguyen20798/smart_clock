import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class EditMessageDialog extends StatelessWidget {
  const EditMessageDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      title: Text(
        'editNotification'.tr(),
        style: const TextStyle(
          fontSize: 16.0,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: TextField(
        decoration: InputDecoration(hintText: 'inputContent'.tr()),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('cancel'.tr())),
        TextButton(onPressed: () {}, child: Text('confirmChange'.tr()))
      ],
    );
  }
}
