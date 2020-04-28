import 'package:crossplat_objectid/crossplat_objectid.dart';
import 'package:hive/hive.dart';

part 'Category.g.dart';

@HiveType(typeId: 0)
class Category extends HiveObject {
  @HiveField(0)
  String _ID = ObjectId().toString();
  @HiveField(1)
  String _name;
  @HiveField(2)
  int _color;

  Category(this._name, this._color);

  String getID() => _ID;
  String getName() => _name;
  void changeName(String newName) {
    _name = newName;
  }

  int getColor() => _color;
  void changeColor(int newColor) {
    _color = newColor;
  }
}
