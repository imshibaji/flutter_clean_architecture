// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DealAdapter extends TypeAdapter<Deal> {
  @override
  final int typeId = 2;

  @override
  Deal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Deal()
      ..id = fields[0] as String?
      ..uid = fields[1] as String?
      ..name = fields[2] as String?
      ..details = fields[3] as String?
      ..price = fields[4] as double?
      ..discount = fields[8] as double?
      ..status = fields[5] as String?
      ..createdAt = fields[6] as DateTime?
      ..leadUid = fields[7] as String?;
  }

  @override
  void write(BinaryWriter writer, Deal obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.uid)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.details)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(8)
      ..write(obj.discount)
      ..writeByte(5)
      ..write(obj.status)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.leadUid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DealAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
