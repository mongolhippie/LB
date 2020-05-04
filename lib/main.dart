import 'package:flutter/material.dart';
import 'package:littlebusiness/screens/edit_category.dart';
import 'screens/sales.dart';
import 'screens/performance.dart';
import 'screens/categories.dart';
import 'screens/form_category.dart';
import 'screens/edit_category.dart';
import 'logic/Category.dart';
import 'logic/Item.dart';
import 'screens/form_item.dart';
import 'screens/edit_item.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'constants.dart';

void main() async {
//  Hive.deleteFromDisk();
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  pathAPP = appDocumentDir.path;
  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(ItemAdapter());

  runApp(MyApp());
  // We open the box here and It can be accessed by any screen
  await Hive.openBox<Category>('categories');
  await Hive.openBox<Item>('items');
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
//      home: MyHomePage(title: 'Flutter Demo Home Page'),
      initialRoute: '/',
      routes: {
        '/': (context) => SalesPage(title: 'SALES'),
        '/performance': (context) => PerformancePage(),
        '/sales': (context) => SalesPage(title: 'SALES'),
        '/categories': (context) => CategoriesPage(title: 'CATEGORIES'),
        '/categoryform': (context) => FormCategoryPage(),
        '/itemform': (context) => FormItemPage(),
        '/editcategory': (context) => FormEditCategoryPage(),
        '/edititem': (context) => FormEditItemPage(),
      },
    );
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
