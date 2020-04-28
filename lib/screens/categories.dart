import 'package:flutter/material.dart';
import 'package:littlebusiness/constants.dart';
import 'package:littlebusiness/logic/Category.dart';
import '../elements/menu_button.dart';
import 'package:hive/hive.dart';
import 'package:littlebusiness/logic/Item.dart';

class CategoriesPage extends StatefulWidget {
  CategoriesPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  int _counter = 0;
  int _indexTab = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

//  final categoriesBox = Hive.openBox('categories');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
//      future: Hive.openBox('items'), We already opened in the beginning so it in loaded in memory
      future: Hive.openBox<Item>('items'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            print('has error, line 29');
            return Text(snapshot.error.toString());
          } else {
            print('no error, line 32');
            return DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: AppBar(
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        if (_indexTab == 0) {
                          Navigator.pushNamed(context, '/itemform');
                        } else {
                          Navigator.pushNamed(context, '/categoryform');
                        }
                      },
                    ),
                  ],
                  bottom: TabBar(
                    onTap: (index) {
                      _indexTab = index;
                    },
                    tabs: [
                      Tab(
                        icon: Icon(Icons.directions_car),
                        text: 'Items',
                      ),
                      Tab(
                        icon: Icon(Icons.directions_transit),
                        text: 'categories',
                      ),
                    ],
                  ),
                  title: Text(widget.title),
                ),
                body: TabBarView(
                  children: [
                    DataTable(
                      columns: [
                        DataColumn(label: Text('Name')),
                        DataColumn(label: Text('Category')),
                        DataColumn(label: Text('Quantity')),
                      ],
                      rows: getListItems(),
                    ),
                    DataTable(
                      columns: [
                        DataColumn(label: Text('Name')),
                        DataColumn(label: Text('Color')),
                      ],
                      rows: getListCategories(),
                    )
                  ],
                ),
                floatingActionButton: MenuButton(current: parts.categories),
              ),
            );
          }
        }
        // Although opening a Box takes a very short time,
        // we still need to return something before the Future completes.
        else
          print('caca de vaca, line 105');
        return CircularProgressIndicator();
      },
    );
  }

  List<DataRow> getListCategories() {
    final categoriesBox = Hive.box<Category>('categories');
    List<DataRow> list = new List<DataRow>();
    Category cat;
    for (var i = 0; i < categoriesBox.length; i++) {
      cat = categoriesBox.get(i) as Category;
      list.add(DataRow(cells: [
        DataCell(Text(cat.getName())),
        DataCell(Text(cat.getColor().toString()))
      ]));
    }
    return list;
  }

  List<DataRow> getListItems() {
    final itemsBox = Hive.box<Item>('items');
    List<DataRow> list = new List<DataRow>();
    Item item;
    for (var i = 0; i < itemsBox.length; i++) {
      item = itemsBox.get(i) as Item;
      list.add(DataRow(cells: [
        DataCell(Text(item.getName())),
        DataCell(Text(item.getName())),
        DataCell(Text(item.getQuantity().toString())),
      ]));
    }
    return list;
  }
}
