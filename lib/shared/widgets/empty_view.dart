import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36.0),
          child: Text('emptyText'.tr(),
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ))),
    );
  }
}
