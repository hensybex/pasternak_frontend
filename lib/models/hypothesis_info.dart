import 'package:hive_flutter/hive_flutter.dart';

part 'hypothesis_info.g.dart';

@HiveType(typeId: 3)
class HypothesisInfo extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  int numOfAppearances;

  HypothesisInfo(
      {required this.id, required this.name, this.numOfAppearances = 0});
}
