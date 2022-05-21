// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leads.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LeadAdapter extends TypeAdapter<Lead> {
  @override
  final int typeId = 0;

  @override
  Lead read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Lead(
      id: fields[0] as int?,
      name: fields[1] as String?,
      email: fields[2] as String?,
      mobile: fields[3] as String?,
      status: (fields[4] as Map?)?.cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, Lead obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.mobile)
      ..writeByte(4)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LeadAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
