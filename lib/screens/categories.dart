import 'package:flutter/material.dart';
import 'package:littlebusiness/constants.dart';
import 'package:littlebusiness/logic/Category.dart';
import '../elements/menu_button.dart';
import 'package:hive/hive.dart';
import 'package:littlebusiness/logic/Item.dart';
import 'package:littlebusiness/DAO.dart';

class CategoriesPage extends StatefulWidget {
  CategoriesPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage>
    with SingleTickerProviderStateMixin {
  int _counter = 0;
  int _indexTab = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // final categoriesBox = Hive.openBox<Category>('categories');

  var colT1 = 0;
  var asT1 = true;
  var colT2 = 0;
  var asT2 = true;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  var categories = getListCategories();

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Hive.openBox<Category>('categories'),
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
                      sortColumnIndex: colT1,
                      sortAscending: asT1,
                      columns: [
                        DataColumn(
                          label: Text('Name'),
                          onSort: (index, bool) {},
                        ),
                        DataColumn(label: Text('Category')),
                        DataColumn(label: Text('Quantity')),
                      ],
                      rows: getListItemsTable(),
                    ),
                    DataTable(
                      sortColumnIndex: colT2,
                      sortAscending: asT2,
                      columns: [
                        DataColumn(
                          label: Text('Name'),
                          onSort: (index, bool) {
                            setState(() {
                              colT2 = index;
                              asT2 = bool;
                              if (!bool) {
                                categories.sort((a, b) =>
                                    a.getName().compareTo(b.getName()));
                              } else {
                                categories.sort((a, b) =>
                                    b.getName().compareTo(a.getName()));
                              }
                            });
                          },
                        ),
                        DataColumn(
                          label: Text('Color'),
                          onSort: (index, bool) {
                            setState(() {
                              colT2 = index;
                              asT2 = bool;
                              if (!bool) {
                                categories.sort((a, b) =>
                                    a.getColor().compareTo(b.getColor()));
                              } else {
                                categories.sort((a, b) =>
                                    b.getColor().compareTo(a.getColor()));
                              }
                            });
                          },
                        ),
                      ],
                      rows: getListCategoriesTable(),
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

  onSortColum(int columnIndex, bool ascending) {
    var cat = getListCategories();
    if (columnIndex == 0) {
      if (ascending) {
        cat.sort((a, b) => a.toString().compareTo(b.toString()));
      } else {
        cat.sort((a, b) => b.toString().compareTo(a.toString()));
      }
    }
  }

  List<DataRow> getListCategoriesTable() {
    List<DataRow> list = new List<DataRow>();
    for (var i = 0; i < categories.length; i++) {
      list.add(DataRow(cells: [
        DataCell(Text(categories[i].getName())),
        DataCell(
          Text(categories[i].getColor().toString()),
          showEditIcon: true,
        )
      ]));
    }
    return list;
  }

  List<DataRow> getListItemsTable() {
    var items = getListItems();
    List<DataRow> list = new List<DataRow>();
    for (var i = 0; i < items.length; i++) {
      list.add(DataRow(cells: [
        DataCell(Text(items[i].getName())),
        DataCell(Text(items[i].getName())),
        DataCell(
          Text(items[i].getQuantity().toString()),
          showEditIcon: true,
        ),
      ]));
    }
    return list;
  }
}
