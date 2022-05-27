// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DealAdapter extends TypeAdapter<Deal> {
  @override
  final int typeId = 1;

  @override
  Deal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Deal()
      ..name = fields[0] as String
      ..details = fields[1] as String
      ..price = fields[2] as double;
  }

  @override
  void write(BinaryWriter writer, Deal obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.details)
      ..writeByte(2)
      ..write(obj.price);
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
