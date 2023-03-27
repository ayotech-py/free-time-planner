// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'position_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserPositionAdapter extends TypeAdapter<UserPosition> {
  @override
  final int typeId = 11;

  @override
  UserPosition read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserPosition(
      long: fields[0] as double,
      lat: fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, UserPosition obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.long)
      ..writeByte(1)
      ..write(obj.lat);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserPositionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
