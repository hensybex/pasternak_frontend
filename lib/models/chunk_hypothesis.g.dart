// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chunk_hypothesis.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChunkHypothesisAdapter extends TypeAdapter<ChunkHypothesis> {
  @override
  final int typeId = 3;

  @override
  ChunkHypothesis read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChunkHypothesis(
      letterChunkId: fields[0] as int,
      hypothesisId: fields[1] as int,
      proof: fields[2] as String,
      version: fields[3] as int,
      accepted: fields[4] as bool,
      quoteStart: fields[5] as int,
      quoteEnd: fields[6] as int,
      incomplete: fields[7] as bool,
      createdAt: fields[8] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ChunkHypothesis obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.letterChunkId)
      ..writeByte(1)
      ..write(obj.hypothesisId)
      ..writeByte(2)
      ..write(obj.proof)
      ..writeByte(3)
      ..write(obj.version)
      ..writeByte(4)
      ..write(obj.accepted)
      ..writeByte(5)
      ..write(obj.quoteStart)
      ..writeByte(6)
      ..write(obj.quoteEnd)
      ..writeByte(7)
      ..write(obj.incomplete)
      ..writeByte(8)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChunkHypothesisAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
