import 'dart:convert';
import 'package:http/http.dart' as http;
// Import the Letter model

class VersionService {
  static const String _baseUrl = 'http://localhost:8080';

  Future<String> fetchServerVersion() async {
    final uri = Uri.parse('$_baseUrl/get-version');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['version'];
    } else {
      throw Exception('Failed to load version from server');
    }
  }
}
