// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getRestaraunt.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GetRestarauntAdapter extends TypeAdapter<getUser> {
  @override
  final int typeId = 0;

  @override
  getUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return getUser(
      id: fields[0] as int?,
      firstName: fields[1] as String?,
      lastName: fields[2] as String?,
      mobileNumber: fields[3] as String?,
      email: fields[4] as String?,
      branch: fields[5] as String?,
      apiKey: fields[6] as String?,
      registrationKey: fields[7] as String?,
      userType: fields[8] as String?,
      isActive: fields[9] as bool?,
      roles: (fields[10] as List?)?.cast<String>(),
      branchtype: fields[11] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, getUser obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.mobileNumber)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.branch)
      ..writeByte(6)
      ..write(obj.apiKey)
      ..writeByte(7)
      ..write(obj.registrationKey)
      ..writeByte(8)
      ..write(obj.userType)
      ..writeByte(9)
      ..write(obj.isActive)
      ..writeByte(10)
      ..write(obj.roles)
      ..writeByte(11)
      ..write(obj.branchtype);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetRestarauntAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
