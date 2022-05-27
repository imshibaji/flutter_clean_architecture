// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lead.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LeadAdapter extends TypeAdapter<Lead> {
  @override
  final int typeId = 2;

  @override
  Lead read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Lead(
      id: fields[0] as String?,
      uid: fields[12] as String?,
      purpose: fields[7] as String?,
      name: fields[1] as String?,
      email: fields[2] as String?,
      mobile: fields[3] as String?,
      source: fields[10] as String?,
      status: fields[4] as String?,
      followups: (fields[5] as List?)?.cast<Followup>(),
      deals: (fields[6] as List?)?.cast<Deal>(),
      payments: (fields[11] as List?)?.cast<Payment>(),
    );
  }

  @override
  void write(BinaryWriter writer, Lead obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(12)
      ..write(obj.uid)
      ..writeByte(7)
      ..write(obj.purpose)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.mobile)
      ..writeByte(10)
      ..write(obj.source)
      ..writeByte(4)
      ..write(obj.status)
      ..writeByte(5)
      ..write(obj.followups)
      ..writeByte(6)
      ..write(obj.deals)
      ..writeByte(11)
      ..write(obj.payments);
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
