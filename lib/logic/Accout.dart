import 'dart:io';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:littlebusiness/logic/Item.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

// Creates or returns the directory given inside the APP Path
class Account {
  var _itemsSelected = List<Item>();
  var _itemsForSale = List();

  List<Item> getSelectedItems() => _itemsSelected;
  List getItemsForSale() => _itemsForSale;
  void addItem(Item i) => _itemsSelected.add(i);
  void removeItem(Item i) => _itemsSelected.remove(i);
  int length() {
    return _itemsSelected.length;
  }
}

class ItemShopModel {
  final Item _item;
  int _quantity;
  ItemShopModel(this._item, this._quantity);

  Item getItem() => _item;
  int getQuantity() => _quantity;

  void addOne() => _quantity++;
}
