import 'package:hive_flutter/hive_flutter.dart';

import 'hive_type_ids.dart';

part 'letter_chunk.g.dart';

@HiveType(typeId: HiveTypeIds.letterChunk)
class LetterChunk extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final int letterId;
  @HiveField(2)
  final int chunkOrder;
  @HiveField(3)
  final String chunk;
  @HiveField(4)
  final int numSymbols;
  @HiveField(5)
  final DateTime createdAt;

  LetterChunk({
    required this.id,
    required this.letterId,
    required this.chunkOrder,
    required this.chunk,
    required this.numSymbols,
    required this.createdAt,
  });

  factory LetterChunk.fromMap(Map<String, dynamic> map) {
    return LetterChunk(
      id: map['id'] ?? 0,
      letterId: map['letter_id'] ?? 0,
      chunkOrder: map['chunk_order'] ?? 0,
      chunk: map['chunk'] ?? '',
      numSymbols: map['num_symbols'] ?? 0,
      createdAt: map['created_at'] != null ? DateTime.parse(map['created_at']) : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'letter_id': letterId,
      'chunk_order': chunkOrder,
      'chunk': chunk,
      'num_symbols': numSymbols,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
