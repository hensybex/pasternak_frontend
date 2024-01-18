import 'package:hive_flutter/hive_flutter.dart';

import 'hive_type_ids.dart';

part 'category_info.g.dart';

@HiveType(typeId: HiveTypeIds.categoryInfo)
class CategoryInfo extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;

  CategoryInfo({required this.id, required this.name});

  factory CategoryInfo.fromJson(Map<String, dynamic> map) {
    return CategoryInfo(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
    );
  }
}
