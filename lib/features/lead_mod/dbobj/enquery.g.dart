// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enquery.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EnqueryAdapter extends TypeAdapter<Enquery> {
  @override
  final int typeId = 1;

  @override
  Enquery read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Enquery()
      ..id = fields[0] as String?
      ..name = fields[1] as String?
      ..email = fields[2] as String?
      ..mobile = fields[3] as String?
      ..status = fields[4] as String?
      ..follows = (fields[5] as List?)?.cast<Follow>();
  }

  @override
  void write(BinaryWriter writer, Enquery obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.mobile)
      ..writeByte(4)
      ..write(obj.status)
      ..writeByte(5)
      ..write(obj.follows);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EnqueryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FollowAdapter extends TypeAdapter<Follow> {
  @override
  final int typeId = 2;

  @override
  Follow read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Follow()
      ..details = fields[0] as String?
      ..status = fields[1] as String?;
  }

  @override
  void write(BinaryWriter writer, Follow obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.details)
      ..writeByte(1)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FollowAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
