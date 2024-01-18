import 'package:hive_flutter/hive_flutter.dart';

import 'hive_type_ids.dart';

part 'hypothesis_info.g.dart';

@HiveType(typeId: HiveTypeIds.hypothesisInfo)
class HypothesisInfo extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  int numOfAppearances;

  HypothesisInfo({required this.id, required this.name, this.numOfAppearances = 0});

  factory HypothesisInfo.fromJson(Map<String, dynamic> map) {
    return HypothesisInfo(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
    );
  }
}
