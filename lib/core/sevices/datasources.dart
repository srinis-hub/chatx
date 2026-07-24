import 'dart:convert';

import 'package:chatx/config/secret.dart';
import 'package:http/http.dart';

class DataSources {
  static Future<String> askGemini(
    List<Map<String, dynamic>> chatHistory,
  ) async {
    final response = await post(
      Uri.parse(Secret.Endpointurl),

      headers: {
        'x-goog-api-key': Secret.apiKey,
        'Content-Type': 'application/json',
      },

      body: jsonEncode({
        "contents": chatHistory,
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
}
