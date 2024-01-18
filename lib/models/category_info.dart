import 'package:hive_flutter/hive_flutter.dart';

part 'category_info.g.dart';

@HiveType(typeId: 2)
class CategoryInfo extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;

  CategoryInfo({required this.id, required this.name});
}
