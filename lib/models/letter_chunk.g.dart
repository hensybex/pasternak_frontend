// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'letter_chunk.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LetterChunkAdapter extends TypeAdapter<LetterChunk> {
  @override
  final int typeId = 4;

  @override
  LetterChunk read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LetterChunk(
      id: fields[0] as int,
      letterId: fields[1] as int,
      chunkOrder: fields[2] as int,
      chunk: fields[3] as String,
      numSymbols: fields[4] as int,
      createdAt: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, LetterChunk obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.letterId)
      ..writeByte(2)
      ..write(obj.chunkOrder)
      ..writeByte(3)
      ..write(obj.chunk)
      ..writeByte(4)
      ..write(obj.numSymbols)
      ..writeByte(5)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LetterChunkAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
