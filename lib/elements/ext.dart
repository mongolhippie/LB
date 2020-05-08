import 'dart:io';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:littlebusiness/logic/Item.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

// Creates or returns the directory given inside the APP Path
class AppUtil {
  static Future<String> createFolderInAppDir(String folderName) async {
    //Get this App Document Directory
    final Directory _appDocDir =
        await path_provider.getApplicationDocumentsDirectory();
    //App Document Directory + folder name
    final Directory _appDocDirFolder =
        Directory('${_appDocDir.path}/$folderName/');

    if (await _appDocDirFolder.exists()) {
      //if folder already exists return path
      return _appDocDirFolder.path;
    } else {
      //if folder not exists create folder and then return its path
      final Directory _appDocDirNewFolder =
          await _appDocDirFolder.create(recursive: true);
      return _appDocDirNewFolder.path;
    }
  }
}

List<ItemShopModel> unifyList(List<Item> listItems) {
  List<Item> prov;
  prov = List.from(listItems);
  var sol = List<ItemShopModel>();
  ItemShopModel itemModel;
  var instances = 1;

  for (int i = 0; i < prov.length; i++) {
    Item item = prov[i];
    var appear = false;
    for (int j = 0; j < sol.length; j++) {
      if (sol[j].getItem() == prov[i]) {
        appear = true;
        sol[j].addOne();
      }
    }
    if (!appear) {
      sol.add(ItemShopModel(item, instances));
    }
    instances = 1;
  }
  for (int i = 0; i < prov.length; i++) {
    print(prov[i].getName());
  }
  return sol;
}

class ItemShopModel {
  final Item _item;
  int _quantity;
  double _finalPrice;
  ItemShopModel(this._item, this._quantity) {
    _finalPrice = _item.getPrice() * _quantity;
  }

  Item getItem() => _item;
  int getQuantity() => _quantity;
  double getFinalPrice() => _finalPrice;

  void addOne() {
    _quantity++;
    _finalPrice = _item.getPrice() * _quantity;
  }
}
