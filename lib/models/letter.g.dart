// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'letter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LetterAdapter extends TypeAdapter<Letter> {
  @override
  final int typeId = 0;

  @override
  Letter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Letter(
      id: fields[0] as int,
      originalName: fields[1] as String,
      name: fields[2] as String,
      dateWithLocation: fields[3] as String,
      sentAt: fields[4] as String,
      sentFrom: fields[5] as String,
      sentTo: fields[6] as String,
      location: fields[7] as String,
      fullLetter: fields[8] as String,
      letterNotes: fields[9] as String,
      brief: fields[10] as String,
      createdAt: fields[11] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Letter obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.originalName)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.dateWithLocation)
      ..writeByte(4)
      ..write(obj.sentAt)
      ..writeByte(5)
      ..write(obj.sentFrom)
      ..writeByte(6)
      ..write(obj.sentTo)
      ..writeByte(7)
      ..write(obj.location)
      ..writeByte(8)
      ..write(obj.fullLetter)
      ..writeByte(9)
      ..write(obj.letterNotes)
      ..writeByte(10)
      ..write(obj.brief)
      ..writeByte(11)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LetterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
