import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChangeLanguage extends StatefulWidget {
  const ChangeLanguage({super.key});

  @override
  State<ChangeLanguage> createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {
  Locale _selectedLocale = const Locale('vi', 'VN');

  @override
  void didChangeDependencies() {
    _selectedLocale = context.locale;
    super.didChangeDependencies();
  }

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
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: Image.asset(
              'assets/images/vietnam.svg',
              width: 30.0,
              height: 30.0,
            ),
            title: const Text('Vietnamese',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                )),
            trailing: Radio(
              value: const Locale('vi', 'VN'),
              onChanged: (value) {
                setState(() {
                  _selectedLocale = value ?? const Locale('vi', 'VN');
                });
              },
              groupValue: _selectedLocale,
            ),
            onTap: () {
              setState(() {
                _selectedLocale = const Locale('vi', 'VN');
              });
            },
          ),
          ListTile(
            leading: Image.asset(
              'assets/images/united_kingdom.svg',
              width: 30.0,
              height: 30.0,
            ),
            title: const Text('English',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                )),
            trailing: Radio(
              value: const Locale('en', 'US'),
              onChanged: (value) {
                setState(() {
                  _selectedLocale = value ?? const Locale('en', 'US');
                });
              },
              groupValue: _selectedLocale,
            ),
            onTap: () {
              setState(() {
                _selectedLocale = const Locale('en', 'US');
              });
            },
          ),
          kDebugMode
              ? ListTile(
                  leading:
                      const Icon(Icons.g_translate, color: Colors.deepPurple),
                  title: Text('translateWithAI'.tr(),
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      )),
                  trailing: MaterialButton(
                      onPressed: () {},
                      color: Colors.deepOrange,
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      child: Text('upgradePro'.tr(),
                          style: const TextStyle(color: Colors.white))),
                  onTap: () {},
                )
              : const SizedBox(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: MaterialButton(
                onPressed: () {
                  Navigator.pop(context, _selectedLocale);
                },
                color: Colors.deepPurple,
                textColor: Colors.white,
                elevation: 0.0,
                minWidth: MediaQuery.of(context).size.width * 0.35,
                height: 48.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text('confirmChange'.tr()),
              ),
            ),
          )
        ],
      ),
    );
  }
}
