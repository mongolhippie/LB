// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryAdapter extends TypeAdapter<Category> {
  @override
  Category read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Category(
      fields[1] as String,
      fields[2] as int,
    ).._ID = fields[0] as String;
  }

  @override
  void write(BinaryWriter writer, Category obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj._ID)
      ..writeByte(1)
      ..write(obj._name)
      ..writeByte(2)
      ..write(obj._color);
  }

  @override
  // TODO: implement typeId
  int get typeId => 0;
}
