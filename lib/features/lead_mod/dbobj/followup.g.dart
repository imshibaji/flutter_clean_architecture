// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'followup.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FollowupAdapter extends TypeAdapter<Followup> {
  @override
  final int typeId = 1;

  @override
  Followup read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Followup()
      ..id = fields[0] as String?
      ..uid = fields[1] as String?
      ..discuss = fields[2] as String?
      ..status = fields[3] as String?
      ..schedule = fields[4] as DateTime?
      ..leadUid = fields[5] as String?;
  }

  @override
  void write(BinaryWriter writer, Followup obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.uid)
      ..writeByte(2)
      ..write(obj.discuss)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.schedule)
      ..writeByte(5)
      ..write(obj.leadUid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FollowupAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
