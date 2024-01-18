import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pasternak_frontend/models/category.dart';
import '../models/chunk_hypothesis.dart';
import '../models/hypothesis.dart';
import '../models/letter.dart';
import '../models/letter_chunk.dart'; // Import the Letter model

class LettersService {
  static const String _baseUrl = 'http://localhost:8080';

  Future<List<Letter>> fetchLetters(int pageKey, int pageSize) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/get-letters-paginated').replace(queryParameters: {
        'pageIndex': pageKey.toString(),
        'pageSize': pageSize.toString(),
      }));

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
      print('Error fetching letters: $e');
      return [];
    }
  }

  Future<Letter> fetchLetterById(int letterId) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/letters/$letterId'));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return Letter.fromMap(data);
      } else if (response.statusCode == 404) {
        print("IM HERE!");
        print(response.body);
        // Handle no more letters
        return Letter(id: 0, createdAt: DateTime.now());
      } else {
        print("IM HERE2!");
        print(response.body);
        throw Exception('Failed to load letter');
      }
    } catch (e) {
      print('Error fetching letter by id: $e');
      return Letter(id: 0, createdAt: DateTime.now());
    }
  }

  Future<List<Hypothesis>> fetchHypotheses() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/get-all-hypotheses'));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((e) => Hypothesis.fromMap(e)).toList();
      } else {
        // Handle errors
        return [];
      }
    } catch (e) {
      print('Error fetching hypotheses: $e');
      return [];
    }
  }

  Future<List<Category>> fetchCategories() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/get-all-categories'));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((e) => Category.fromMap(e)).toList();
      } else {
        // Handle errors
        return [];
      }
    } catch (e) {
      print('Error fetching hypotheses: $e');
      return [];
    }
  }

  // New method to fetch letter chunks
  Future<List<LetterChunk>> fetchLetterChunks(int letterId) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/get-letter-chunks-by-letter-id/$letterId'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((e) => LetterChunk.fromMap(e)).toList();
      } else {
        throw Exception('Failed to load letter chunks');
      }
    } catch (e) {
      print('Error fetching letter chunks: $e');
      return [];
    }
  }

  // New method to fetch chunk hypotheses
  Future<List<ChunkHypothesis>> fetchChunkHypotheses(int letterChunkId) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/get-chunk-hypotheses-by-chunk-id/$letterChunkId'));
      print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((e) => ChunkHypothesis.fromMap(e)).toList();
      } else {
        throw Exception('Failed to load chunk hypotheses');
      }
    } catch (e) {
      //print('Error fetching chunk hypotheses: $e');
      return [];
    }
  }
}
