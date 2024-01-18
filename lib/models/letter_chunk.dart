class LetterChunk {
  final int id;
  final int letterId;
  final int chunkOrder;
  final String chunk;
  final int numSymbols;
  final DateTime createdAt;

  LetterChunk({required this.id, required this.letterId, required this.chunkOrder, required this.chunk, required this.numSymbols, required this.createdAt,});

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
