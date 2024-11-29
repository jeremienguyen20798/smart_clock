import 'package:flutter/material.dart';

import '../../core/constants/app_constants.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 36.0),
          child: Text(AppConstants.emptyText,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ))),
    );
  }
}
