// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hypothesis_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HypothesisInfoAdapter extends TypeAdapter<HypothesisInfo> {
  @override
  final int typeId = 2;

  @override
  HypothesisInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HypothesisInfo(
      id: fields[0] as int,
      name: fields[1] as String,
      numOfAppearances: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, HypothesisInfo obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.numOfAppearances);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HypothesisInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
