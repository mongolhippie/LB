// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItemAdapter extends TypeAdapter<Item> {
  @override
  Item read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Item(
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as double,
      fields[5] as double,
      fields[6] as double,
    )
      .._ID = fields[0] as String
      .._photo = fields[7] as String;
  }

  @override
  void write(BinaryWriter writer, Item obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj._ID)
      ..writeByte(1)
      ..write(obj._name)
      ..writeByte(2)
      ..write(obj._categoryID)
      ..writeByte(3)
      ..write(obj._unit)
      ..writeByte(4)
      ..write(obj._price)
      ..writeByte(5)
      ..write(obj._cost)
      ..writeByte(6)
      ..write(obj._quantity)
      ..writeByte(7)
      ..write(obj._photo);
  }

  @override
  // TODO: implement typeId
  int get typeId => 1;
}
