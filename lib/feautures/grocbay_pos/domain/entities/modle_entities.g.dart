// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modle_entities.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ModelEntitiesAdapter extends TypeAdapter<ModelEntities> {
  @override
  final int typeId = 1;

  @override
  ModelEntities read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ModelEntities(
      fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ModelEntities obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModelEntitiesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
