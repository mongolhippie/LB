import 'dart:io';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:littlebusiness/logic/Item.dart';
import 'package:littlebusiness/logic/Accout.dart';

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
  print('This is the list at the begining: ');
  print(listItems);
  var sol = List<ItemShopModel>();
  ItemShopModel itemModel;
  var instances = 1;

  for (int i = 0; i < prov.length; i++) {
    Item item = prov[i];

    print('Vualta numero i: ');
    print(i);
    var appear = false;
    for (int j = 0; j < sol.length; j++) {
      print('Vualta numero j: ');
      print(j);
      if (sol[j].getItem() == prov[i]) {
        print('--49--');
        appear = true;
        sol[j].addOne();
      }
    }
    if (!appear) {
      print('--56--');
      sol.add(ItemShopModel(item, instances));
    }
    instances = 1;
  }
  print('This is listItems at the END: ');
  print(listItems);
  print('This is sol at the end: ');
  for (int i = 0; i < prov.length; i++) {
    print(prov[i].getName());
  }

  print('This is sol at the END: ');
  print(sol);

  return sol;
}
