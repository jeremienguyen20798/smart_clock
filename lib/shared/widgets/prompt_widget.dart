import 'package:flutter/material.dart';

import '../../core/constants/app_constants.dart';

class PromptWidget extends StatefulWidget {
  final String input;

  const PromptWidget({super.key, required this.input});

  @override
  State<PromptWidget> createState() => _PromptWidgetState();
}

class _PromptWidgetState extends State<PromptWidget> {
  TextEditingController promptController = TextEditingController();

  @override
  void initState() {
    promptController.text = widget.input;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: TextField(
        autofocus: true,
        maxLines: 3,
        controller: promptController,
        decoration: const InputDecoration(
          labelText: AppConstants.titlePrompt,
          hintText: AppConstants.messagePrompt,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
