import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class EditMessageDialog extends StatefulWidget {
  const EditMessageDialog({super.key});

  @override
  State<EditMessageDialog> createState() => _EditMessageDialogState();
}

class _EditMessageDialogState extends State<EditMessageDialog> {
  TextEditingController inputController = TextEditingController();

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
        controller: inputController,
        decoration: InputDecoration(hintText: 'inputContent'.tr()),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('cancel'.tr())),
        TextButton(
            onPressed: () {
              Navigator.pop(context, inputController.text);
            },
            child: Text('confirmChange'.tr()))
      ],
    );
  }
}
