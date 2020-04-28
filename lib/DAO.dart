import 'package:littlebusiness/logic/Category.dart';
import 'package:littlebusiness/logic/Item.dart';
import 'package:crossplat_objectid/crossplat_objectid.dart';

import 'package:hive/hive.dart';

bool addCategory(Category newCat) {
//  final itemBox = await Hive.openBox<Category>('categories');
  var categoriesBox = Hive.box<Category>('categories');
  Category oldCat;
  for (var i = 0; i < categoriesBox.length; i++) {
    oldCat = categoriesBox.get(i);
    if (oldCat.getName() == newCat.getName()) return false;
  }
  categoriesBox.put(newCat.getID().toString(), newCat);
  return true;
}

bool addItem(Item newItem) {
//  final itemBox = await Hive.openBox<Category>('categories');
  var itemsBox = Hive.box<Item>('items');
  Item oldItem;
  for (var i = 0; i < itemsBox.length; i++) {
    oldItem = itemsBox.get(i);
    if (oldItem.getName() == newItem.getName()) return false;
  }
  itemsBox.put(ObjectId().toString(), newItem);
  return true;
}
