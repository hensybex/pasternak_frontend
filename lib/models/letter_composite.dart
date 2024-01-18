import 'dart:convert';

import 'package:hive/hive.dart';

part 'letter_composite.g.dart';

@HiveType(typeId: 1)
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

  LetterComposite({
    required this.id,
    required this.sentTo,
    required this.sentAt,
    required this.location,
    required this.brief,
    required this.categoriesIds,
    required this.hypothesesCounts,
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
    );
  }

  factory LetterComposite.fromMap(Map<String, dynamic> map) {
    // Convert the hypothesesCounts from List to Map<int, int>
    Map<int, int> hypothesesCounts = {};
    var hypothesesCountsRaw = map['hypothesesCounts'];

    if (hypothesesCountsRaw != null) {
      if (hypothesesCountsRaw is String) {
        // If the JSONB comes as a string, parse it
        hypothesesCounts = (json.decode(hypothesesCountsRaw) as Map)
            .map((key, value) => MapEntry(int.parse(key), value));
      } else if (hypothesesCountsRaw is Map) {
        // If it's already a Map, cast the keys to int
        hypothesesCounts = hypothesesCountsRaw
            .map((key, value) => MapEntry(int.parse(key), value));
      }
    }

    return LetterComposite(
      id: map['id'] ?? 0,
      sentTo: map['sentTo'] ?? '',
      sentAt: map['sentAt'] ?? '',
      location: map['location'] ?? '',
      brief: map['brief'] ?? '',
      categoriesIds: (map['categoriesIds'] as List<dynamic>).cast<int>(),
      hypothesesCounts: hypothesesCounts,
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
    };
  }
}
