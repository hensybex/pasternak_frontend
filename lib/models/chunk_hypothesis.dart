class ChunkHypothesis {
  final int letterChunkId;
  final int hypothesisId;
  final String proof;
  final int version;
  bool accepted;
  final int quoteStart;
  final int quoteEnd;
  final bool incomplete;
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
