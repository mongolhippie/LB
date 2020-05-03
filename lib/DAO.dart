import 'package:littlebusiness/logic/Category.dart';
import 'package:littlebusiness/logic/Item.dart';
import 'package:crossplat_objectid/crossplat_objectid.dart';

import 'package:hive/hive.dart';

bool addCategory(Category newCat) {
//  final itemBox = await Hive.openBox<Category>('categories');
  var categoriesBox = Hive.box<Category>('categories');
  Category oldCat;
  for (var i = 0; i < categoriesBox.length; i++) {
    oldCat = categoriesBox.getAt(i);
    if (oldCat.getName() == newCat.getName()) return false;
  }
  categoriesBox.put(newCat.getID().toString(), newCat);
  return true;
}

List<Category> getListCategories() {
  final categoriesBox = Hive.box<Category>('categories');
  List<Category> list = new List<Category>();
  for (var i = 0; i < categoriesBox.length; i++) {
    list.add(categoriesBox.getAt(i));
  }
  return list;
}

bool addItem(Item newItem) {
//  final itemBox = await Hive.openBox<Category>('categories');
  var itemsBox = Hive.box<Item>('items');
  Item oldItem;
  for (var i = 0; i < itemsBox.length; i++) {
    oldItem = itemsBox.getAt(i);
    if (oldItem.getName() == newItem.getName()) return false;
  }
  itemsBox.put(newItem.getID(), newItem);
  return true;
}

List<Item> getListItems() {
  final itemsBox = Hive.box<Item>('items');
  List<Item> list = new List<Item>();
  for (var i = 0; i < itemsBox.length; i++) {
    list.add(itemsBox.getAt(i));
  }
  return list;
}
