import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChangeLanguage extends StatelessWidget {
  const ChangeLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'changeLanguage'.tr(),
              style: const TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: SvgPicture.asset('assets/images/vietnam.svg'),
            title: const Text('Vietnamese',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                )),
            trailing: Radio(
              value: false,
              onChanged: (value) {},
              groupValue: null,
            ),
            onTap: () {},
          ),
          ListTile(
            leading: SvgPicture.asset('assets/images/united_kingdom.svg'),
            title: const Text('English',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                )),
            trailing: Radio(
              value: false,
              onChanged: (value) {},
              groupValue: null,
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
