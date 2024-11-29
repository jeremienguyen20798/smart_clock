import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:smart_clock/core/utils/dialog_utils.dart';

TextEditingController promptController = TextEditingController();

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
          title: const Text(
            'Cài đặt',
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Column(
          children: [
            ListTile(
              title: const Text(
                'Xoá báo thức sau khi thông báo',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Switch(value: true, onChanged: (value) {}),
            ),
            ListTile(
              title: const Text(
                'Nội dung thông báo mặc định',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: RichText(
                  text: TextSpan(
                      text: 'Báo thức',
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                      ),
                      children: [
                    const TextSpan(text: '  '),
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            DialogUtils.showEditMessageNotiDialog(context);
                          },
                        text: 'Sửa',
                        style: const TextStyle(
                            color: Colors.deepPurple, fontSize: 14.0))
                  ])),
              trailing: Switch(value: true, onChanged: (value) {}),
            ),
            ListTile(
              title: const Text(
                'Nhạc chuông báo thức',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Ringtone',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 18.0,
                      ))
                ],
              ),
            ),
          ],
        ));
  }
}
