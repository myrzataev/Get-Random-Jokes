import 'dart:convert';
import 'package:http/http.dart' as http;

class GoogleTranslate {
  final String apiKey;
  final String baseUrl = "https://translation.googleapis.com/language/translate/v2";

  GoogleTranslate(this.apiKey);

  Future<String> translate(String text, String targetLanguage) async {
    final response = await http.post(
      Uri.parse('$baseUrl?key=$apiKey'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'q': text,
        'target': targetLanguage,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data['data']['translations'][0]['translatedText'];
    } else {
      throw Exception('Failed to translate text');
    }
  }
}
