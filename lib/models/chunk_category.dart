class ChunkCategory {
  final int letterChunkId;
  final int categoryId;
  final int version;
  final DateTime createdAt;

  ChunkCategory({
    required this.letterChunkId,
    required this.categoryId,
    required this.version,
    required this.createdAt,
  });

  factory ChunkCategory.fromMap(Map<String, dynamic> map) {
    return ChunkCategory(
      letterChunkId: map['letter_chunk_id'] ?? 0,
      categoryId: map['category_id'] ?? 0,
      version: map['version'] ?? 0,
      createdAt: map['created_at'] != null ? DateTime.parse(map['created_at']) : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'letter_chunk_id': letterChunkId,
      'category_id': categoryId,
      'version': version,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

