import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import '../models/letter_composite.dart';

class LetterCompositeService {
  // The URL of your endpoint
  static const String _baseUrl = 'https://pasternak-gpt.duckdns.org/api';

  // Fetch LetterComposites from the server
  Future<List<LetterComposite>> fetchLetterComposites(int pageIndex, int pageSize) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/get-letter-composites-paginated?pageIndex=$pageIndex&pageSize=$pageSize'));

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        List<LetterComposite> composites = body.map((dynamic item) => LetterComposite.fromMap(item)).toList();
        return composites;
      } else {
        throw Exception('Failed to load LetterComposites');
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  // Optional: Store LetterComposites in Hive
  Future<void> storeLetterCompositesInHive(List<LetterComposite> composites) async {
    final box = await Hive.openBox<LetterComposite>('letterComposites');
    await box.clear();
    await box.addAll(composites);
  }

  // Add more methods as needed, like fetching by filters, etc.
}
