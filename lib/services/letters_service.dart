import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/letter.dart'; // Import the Letter model

class LettersService {
  static const String _baseUrl = 'http://localhost:8080';

  Future<List<Letter>> fetchLetters(int pageKey, int pageSize) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/get-letters-paginated').replace(queryParameters: {
        'pageIndex': pageKey.toString(),
        'pageSize': pageSize.toString(),
      }));

      print("IM HERE");
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((e) => Letter.fromMap(e)).toList();
      } else if (response.statusCode == 404) {
        // Handle no more letters
        return [];
      } else {
        throw Exception('Failed to load letters');
      }
    } catch (e) {
      print('Error fetching scenario skills: $e');
      return [];
    }
  }
}
