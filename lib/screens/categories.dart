import 'package:flutter/material.dart';
import 'package:littlebusiness/constants.dart';
import 'package:littlebusiness/logic/Category.dart';
import '../elements/menu_button.dart';
import 'package:hive/hive.dart';
import 'package:littlebusiness/logic/Item.dart';
import 'package:littlebusiness/DAO.dart';
import 'edit_category.dart';
import 'edit_item.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoriesPage extends StatefulWidget {
  CategoriesPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage>
    with SingleTickerProviderStateMixin {
  int _indexTab = 0;

  // final categoriesBox = Hive.openBox<Category>('categories');

  var colT1 = 0;
  var asT1 = false;
  var colT2 = 0;
  var asT2 = false;
  TabController _tabController;
  List<Category> categories;
  List<Item> items;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2, initialIndex: 1);
    categories = getListCategories();
    items = getListItems();
  }

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
            return Scaffold(
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
                  labelStyle: TextStyle(fontFamily: "Comfortaa"),
                  controller: _tabController,
                  onTap: (index) {
                    _indexTab = index;
                  },
                  tabs: [
                    Tab(
                      icon: SvgPicture.asset(
                        'svg/item.svg',
                        semanticsLabel: 'Items',
                        width: 40,
                      ),
                      text: 'Items',
                    ),
                    Tab(
                      icon: SvgPicture.asset(
                        'svg/categories.svg',
                        semanticsLabel: 'Items',
                        width: 40,
                      ),
                      text: 'Categories',
                    ),
                  ],
                ),
                title: Text(
                  "Items and Categories",
                  style: TextStyle(fontFamily: 'Comfortaa', fontSize: 25),
                ),
              ),
              body: TabBarView(
                controller: _tabController,
                children: [
                  DataTable(
                    sortColumnIndex: colT1,
                    sortAscending: asT1,
                    columns: [
                      DataColumn(
                        label: Text(
                          'Name',
                          style: TextStyle(fontFamily: 'Comfortaa'),
                        ),
                        onSort: (index, bool) {
                          setState(() {
                            colT1 = index;
                            asT1 = bool;
                            if (!bool) {
                              items.sort(
                                  (a, b) => a.getName().compareTo(b.getName()));
                            } else {
                              items.sort(
                                  (a, b) => b.getName().compareTo(a.getName()));
                            }
                          });
                        },
                      ),
                      DataColumn(
                        label: Text(
                          'Category',
                          style: TextStyle(fontFamily: 'Comfortaa'),
                        ),
                        onSort: (index, bool) {
                          setState(() {
                            colT1 = index;
                            asT1 = bool;
                            if (!bool) {
                              items.sort((a, b) =>
                                  a.getCategory().compareTo(b.getCategory()));
                            } else {
                              items.sort((a, b) =>
                                  b.getCategory().compareTo(a.getCategory()));
                            }
                          });
                        },
                      ),
                      DataColumn(
                        label: Text(
                          'Quantity',
                          style: TextStyle(fontFamily: 'Comfortaa'),
                        ),
                        onSort: (index, bool) {
                          setState(() {
                            colT1 = index;
                            asT1 = bool;
                            if (!bool) {
                              items.sort((a, b) =>
                                  a.getQuantity().compareTo(b.getQuantity()));
                            } else {
                              items.sort((a, b) =>
                                  b.getQuantity().compareTo(a.getQuantity()));
                            }
                          });
                        },
                      ),
                    ],
                    rows: getListItemsTable(),
                  ),
                  DataTable(
                    sortColumnIndex: colT2,
                    sortAscending: asT2,
                    columns: [
                      DataColumn(
                        label: Text(
                          'Name',
                          style: TextStyle(fontFamily: 'Comfortaa'),
                        ),
                        onSort: (index, bool) {
                          setState(() {
                            colT2 = index;
                            asT2 = bool;
                            if (!bool) {
                              categories.sort(
                                  (a, b) => a.getName().compareTo(b.getName()));
                            } else {
                              categories.sort(
                                  (a, b) => b.getName().compareTo(a.getName()));
                            }
                          });
                        },
                      ),
                      DataColumn(
                        label: Text(
                          'Color',
                          style: TextStyle(fontFamily: 'Comfortaa'),
                        ),
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

  List<DataRow> getListCategoriesTable() {
    List<DataRow> list = List<DataRow>();
    for (var i = 0; i < categories.length; i++) {
      list.add(DataRow(cells: [
        DataCell(Text(
          categories[i].getName(),
          style: TextStyle(fontFamily: 'Comfortaa'),
        )),
        DataCell(
            Container(
                height: 25.0,
                width: 25.0,
                decoration: BoxDecoration(
                  color: Color(categories[i].getColor()),
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(15)),
                )),
            //     Text(categories[i].getColor().toString()),
            showEditIcon: true, onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  FormEditCategoryPage(id: categories[i].getID()),
            ),
          );
        })
      ]));
    }
    return list;
  }

  List<DataRow> getListItemsTable() {
    final categoriesBox = Hive.box<Category>('categories');
    List<DataRow> list = new List<DataRow>();
    for (var i = 0; i < items.length; i++) {
      list.add(DataRow(cells: [
        DataCell(Text(
          items[i].getName(),
          style: TextStyle(fontFamily: 'Comfortaa'),
        )),
        DataCell(Text(
          categoriesBox.get(items[i].getCategory()).getName(),
          style: TextStyle(fontFamily: 'Comfortaa'),
        )),
        DataCell(
          Text(
            items[i].getQuantity().toString(),
            style: TextStyle(fontFamily: 'Comfortaa'),
          ),
          showEditIcon: true,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FormEditItemPage(id: items[i].getID()),
              ),
            );
          },
        ),
      ]));
    }
    return list;
  }
}
