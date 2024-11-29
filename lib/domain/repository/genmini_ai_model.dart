import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_clock/di.dart';

class GenminiAIModel {
  late final GenerativeModel _model;
  final pref = getIt.get<SharedPreferences>();

  GenminiAIModel() {
    final apiKey = pref.getString('GeminiKey');
    _model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: apiKey ?? '');
  }

  Future<GenerateContentResponse?> createAlarmBySpeech(
      Iterable<Content> prompt) async {
    try {
      final response = await _model.generateContent(prompt);
      debugPrint(response.text);
      return response;
    } catch (error) {
      debugPrint("Error: ${error.toString()}");
      return null;
    }
  }
}
