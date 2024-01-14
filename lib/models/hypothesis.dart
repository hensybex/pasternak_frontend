class Hypothesis {
  final int id;
  final String name;
  final int categoryId;
  final DateTime createdAt;

  Hypothesis({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.createdAt,
  });

  factory Hypothesis.fromMap(Map<String, dynamic> map) {
    return Hypothesis(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      categoryId: map['category_id'] ?? 0,
      createdAt: map['created_at'] != null ? DateTime.parse(map['created_at']) : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category_id': categoryId,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
