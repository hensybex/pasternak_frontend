import 'package:hive_flutter/hive_flutter.dart';
import 'package:pasternak_frontend/models/hive_type_ids.dart';

part 'chunk_hypothesis.g.dart';

@HiveType(typeId: HiveTypeIds.chunkHypothesis)
class ChunkHypothesis extends HiveObject {
  @HiveField(0)
  final int letterChunkId;
  @HiveField(1)
  final int hypothesisId;
  @HiveField(2)
  final String proof;
  @HiveField(3)
  final int version;
  @HiveField(4)
  bool accepted;
  @HiveField(5)
  final int quoteStart;
  @HiveField(6)
  final int quoteEnd;
  @HiveField(7)
  final bool incomplete;
  @HiveField(8)
  final DateTime createdAt;

  ChunkHypothesis({
    required this.letterChunkId,
    required this.hypothesisId,
    required this.proof,
    required this.version,
    required this.accepted,
    required this.quoteStart,
    required this.quoteEnd,
    required this.incomplete,
    required this.createdAt,
  });

  factory ChunkHypothesis.fromMap(Map<String, dynamic> map) {
    return ChunkHypothesis(
      letterChunkId: map['letter_chunk_id'] ?? 0,
      hypothesisId: map['hypothesis_id'] ?? 0,
      proof: map['proof'] ?? '',
      version: map['version'] ?? 0,
      accepted: map['accepted'] ?? true,
      quoteStart: map['quote_start'] ?? 0,
      quoteEnd: map['quote_end'] ?? 0,
      incomplete: map['incomplete'] ?? false,
      createdAt: map['created_at'] != null ? DateTime.parse(map['created_at']) : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'letter_chunk_id': letterChunkId,
      'hypothesis_id': hypothesisId,
      'proof': proof,
      'version': version,
      'accepted': accepted,
      'quote_start': quoteStart,
      'quote_end': quoteEnd,
      'incomplete': incomplete,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
