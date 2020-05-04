import 'package:littlebusiness/logic/Category.dart';
import 'package:littlebusiness/constants.dart';
import 'package:crossplat_objectid/crossplat_objectid.dart';
import 'package:hive/hive.dart';

part 'Item.g.dart';

@HiveType(typeId: 1)
class Item extends HiveObject {
  @HiveField(0)
  String _ID = ObjectId().toString();
  @HiveField(1)
  String _name;
  @HiveField(2)
  String _categoryID;
  @HiveField(3)
  units _unit;
  @HiveField(4)
  double _price;
  @HiveField(5)
  double _cost;
  @HiveField(6)
  double _quantity;
  @HiveField(7)
  String _photo;

  Item(this._name, this._categoryID, this._unit, this._price, this._cost,
      this._quantity);

  String getID() => _ID;

  String getName() => _name;
  void changeName(String newName) {
    _name = newName;
  }

  String getCategory() => _categoryID;
  void changeCategory(String newCategory) {
    _categoryID = newCategory;
  }

  units getUnit() => _unit;
  void changeUnit(units newSoldBy) {
    _unit = newSoldBy;
  }

  double getPrice() => _price;
  void changePrice(double newPrice) {
    _price = newPrice;
  }

  double getCost() => _cost;
  void changeCost(double newCost) {
    _cost = newCost;
  }

  double getQuantity() => _quantity;
  void changeQuantity(double newQuantity) {
    _quantity = newQuantity;
  }

  String getPhoto() => _photo;
  void changePhoto(String newPhoto) {
    _photo = newPhoto;
  }
}
