import 'package:flutter/material.dart';

class EditMessageDialog extends StatelessWidget {
  const EditMessageDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      title: const Text(
        'Chỉnh sửa thông báo',
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: const TextField(
        decoration: InputDecoration(hintText: 'Nhập nội dung'),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Huỷ')),
        TextButton(onPressed: () {}, child: const Text('Xác nhận'))
      ],
    );
  }
}
