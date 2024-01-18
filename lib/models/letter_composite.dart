import 'dart:convert';

import 'package:hive/hive.dart';

import 'hive_type_ids.dart';

part 'letter_composite.g.dart';

@HiveType(typeId: HiveTypeIds.letterComposite)
class LetterComposite extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String sentTo;
  @HiveField(2)
  final String sentAt;
  @HiveField(3)
  final String location;
  @HiveField(4)
  final String brief;
  @HiveField(5)
  final List<int> categoriesIds;
  @HiveField(6)
  final Map<int, int> hypothesesCounts;
  @HiveField(7)
  final String year;

  LetterComposite({
    required this.id,
    required this.sentTo,
    required this.sentAt,
    required this.location,
    required this.brief,
    required this.categoriesIds,
    required this.hypothesesCounts,
    required this.year,
  });

  factory LetterComposite.fromJson(Map<String, dynamic> map) {
    return LetterComposite(
      id: map['id'] ?? 0,
      sentTo: map['sent_to'] ?? '',
      sentAt: map['sent_at'] ?? '',
      location: map['location'] ?? '',
      brief: map['brief'] ?? '',
      categoriesIds: map['categories_ids'] ?? [],
      hypothesesCounts: map['hypotheses_counts'] ?? [],
      year: map['year'] ?? '',
    );
  }

  factory LetterComposite.fromMap(Map<String, dynamic> map) {
    // Convert the hypothesesCounts from List to Map<int, int>
    Map<int, int> hypothesesCounts = {};
    var hypothesesCountsRaw = map['hypotheses_counts'];

    if (hypothesesCountsRaw != null) {
      if (hypothesesCountsRaw is String) {
        // If the JSONB comes as a string, parse it
        hypothesesCounts = (json.decode(hypothesesCountsRaw) as Map).map((key, value) => MapEntry(int.parse(key), value));
      } else if (hypothesesCountsRaw is Map) {
        // If it's already a Map, cast the keys to int
        hypothesesCounts = hypothesesCountsRaw.map((key, value) => MapEntry(int.parse(key), value));
      }
    }

    String categoriesIdsRaw = map['categories_ids'] as String? ?? '';
    List<int> categoriesIds = [];
    if (categoriesIdsRaw.isNotEmpty) {
      // Remove curly braces and split the string
      categoriesIds = categoriesIdsRaw.substring(1, categoriesIdsRaw.length - 1).split(',').map((id) => int.tryParse(id) ?? 0).toList();
    }

    return LetterComposite(
      id: map['id'] ?? 0,
      sentTo: map['sent_to'] ?? '',
      sentAt: map['sent_at'] ?? '',
      location: map['location'] ?? '',
      brief: map['brief'] ?? '',
      categoriesIds: categoriesIds,
      hypothesesCounts: hypothesesCounts,
      year: map['year'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sent_to': sentTo,
      'sent_at': sentAt,
      'location': location,
      'brief': brief,
      'categories_ids': categoriesIds,
      'hypotheses_counts': hypothesesCounts,
      'year': year,
    };
  }
}
