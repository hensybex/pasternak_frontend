// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'letter_composite.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LetterCompositeAdapter extends TypeAdapter<LetterComposite> {
  @override
  final int typeId = 1;

  @override
  LetterComposite read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LetterComposite(
      id: fields[0] as int,
      sentTo: fields[1] as String,
      sentAt: fields[2] as String,
      location: fields[3] as String,
      brief: fields[4] as String,
      categoriesIds: (fields[5] as List).cast<int>(),
      hypothesesCounts: (fields[6] as Map).cast<int, int>(),
      year: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LetterComposite obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.sentTo)
      ..writeByte(2)
      ..write(obj.sentAt)
      ..writeByte(3)
      ..write(obj.location)
      ..writeByte(4)
      ..write(obj.brief)
      ..writeByte(5)
      ..write(obj.categoriesIds)
      ..writeByte(6)
      ..write(obj.hypothesesCounts)
      ..writeByte(7)
      ..write(obj.year);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LetterCompositeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
