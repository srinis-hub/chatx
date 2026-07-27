import 'dart:convert';

import 'package:chatx/config/secret.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';

class DataSources {
  static Future<String> askGemini(
    List<Map<String, dynamic>> chatHistory,
    String systemInstruction,
  ) async {
    final response = await post(
      Uri.parse(Secret.Endpointurl),

      headers: {
        'x-goog-api-key': Secret.apiKey,
        'Content-Type': 'application/json',
      },

      body: jsonEncode({
        "contents": chatHistory,
        "system_instruction": {
          "parts": [
            {"text": systemInstruction},
          ],
        },
        "generationConfig": {
          "thinkingConfig": {"thinkingBudget": 0},
        },
      }),
    );
    print(response.body.toString());

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var jsondata = data['candidates'];

      if (jsondata != null && jsondata.isNotEmpty) {
        return data['candidates'][0]['content']['parts'][0]['text'];
      }

      return "No response from Gemini.";
    } else {
      return "Facing Issue: ${response.statusCode}";
    }
  }

  static Future<void> updateAssistantBehavior({
    required bool isdefault,
    required User user,
    required String assistantName,
    required String systemInstruction,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('assistant_behavior')
          .doc('config')
          .collection('history')
          .add({
            'assistantName': assistantName.trim(),
            'systemInstruction': systemInstruction.trim(),
            'changedAt': FieldValue.serverTimestamp(),
            'isDefault': isdefault,
          });
    } catch (e) {
      rethrow;
    }
  }
}
