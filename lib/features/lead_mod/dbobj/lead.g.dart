// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lead.dart';

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
    return Lead()
      ..id = fields[0] as String?
      ..uid = fields[1] as String?
      ..purpose = fields[2] as String?
      ..name = fields[3] as String?
      ..email = fields[4] as String?
      ..mobile = fields[5] as String?
      ..altMobile = fields[11] as String?
      ..address = fields[12] as String?
      ..source = fields[6] as String?
      ..status = fields[7] as String?
      ..followups = (fields[8] as HiveList?)?.castHiveList()
      ..deals = (fields[9] as HiveList?)?.castHiveList()
      ..payments = (fields[10] as HiveList?)?.castHiveList();
  }

  @override
  void write(BinaryWriter writer, Lead obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.uid)
      ..writeByte(2)
      ..write(obj.purpose)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.mobile)
      ..writeByte(11)
      ..write(obj.altMobile)
      ..writeByte(12)
      ..write(obj.address)
      ..writeByte(6)
      ..write(obj.source)
      ..writeByte(7)
      ..write(obj.status)
      ..writeByte(8)
      ..write(obj.followups)
      ..writeByte(9)
      ..write(obj.deals)
      ..writeByte(10)
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
