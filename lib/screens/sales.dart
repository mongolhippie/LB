import 'package:flutter/material.dart';
import 'package:littlebusiness/constants.dart';
import 'package:littlebusiness/logic/Accout.dart';
import 'package:littlebusiness/logic/Category.dart';
import 'package:littlebusiness/logic/Item.dart';
import 'package:littlebusiness/DAO.dart';
import 'package:hive/hive.dart';
import '../elements/menu_button.dart';
import 'package:build_daemon/constants.dart';
import '../elements/ext.dart';

class SalesPage extends StatefulWidget {
  SalesPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _SalesPageState createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  List<Category> categories;
  List<Item> items;

  var account = List<Widget>();
  var itemsSelected = List<Item>();

  @override
  void initState() {
    super.initState();
    categories = getListCategories();
    items = getListItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Visibility(
              visible: itemsSelected.length == 0 ? false : true,
              child: Container(
                decoration: BoxDecoration(
                  color: kSelectedGreen,
                ),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  childAspectRatio: .85, // space between rows in the grid
                  crossAxisCount: 4,
                  mainAxisSpacing: 7.0,
                  crossAxisSpacing: 0,
                  // children: account,
                  children: getItemBought(unifyList(itemsSelected)),
                ),
              ),
            ),
            GridView.count(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              childAspectRatio: .85, // space between rows in the grid
              padding: EdgeInsets.only(top: 15),
              crossAxisCount: 4,
              mainAxisSpacing: 7.0,
              crossAxisSpacing: 0,
              children: getItemTouch(),
            ),
          ],
        ),
      ),
      floatingActionButton: MenuButton(current: parts.sales),
    );
  }

  List<Widget> getItemBought(List<ItemShopModel> list) {
    print('This is shop model');
    print(list);
    var sol = List<Widget>();
    Category cat;
    for (var i = 0; i < list.length; i++) {
      cat = getCategoryByID(list[i].getItem().getCategory());
      print('This is quantity');
      print(list[i].getQuantity());
      sol.add(itemsShop(list[i].getItem(), cat, list[i].getQuantity()));
    }
    print('and this is sol');
    print(sol);
    return sol;
  }

  List<Widget> getItemTouch() {
    var list = List<Widget>();
    Category cat;
    for (var i = 0; i < items.length; i++) {
      cat = getCategoryByID(items[i].getCategory());
      list.add(itemsShop(items[i], cat, -1));
    }
    return list;
  }

  Widget itemsShop(Item item, Category cat, int price) {
    return Center(
      child: InkWell(
        splashColor: Color(cat.getColor()),
        onTap: () {
          setState(() {
            print('Tapped!');
            print('lista antes: ');
            print(itemsSelected);
            print('item: ');
            print(item.getName());
            itemsSelected = List.from(itemsSelected..add(item));
            print('lista despues: ');
            print(itemsSelected);

            print('account: ');
            print(account);
          });
        },
        child: itemShop(item, cat, price),
      ),
    );
  }

  Widget itemShop(Item item, Category cat, int price) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          //    margin: EdgeInsets.only(top: 15),
          height: 101,
          width: 81,
          decoration: BoxDecoration(
            color: Color(cat.getColor()),
            boxShadow: [
              BoxShadow(
                offset: Offset(0.00, 1.00),
                color: Color(0xff000000).withOpacity(0.20),
                blurRadius: 3,
              ),
            ],
            borderRadius: BorderRadius.circular(4.00),
          ),
          child: Column(
            children: <Widget>[
              Container(
                height: 80,
                width: 81,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(item.getName()),
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4.00),
                    topRight: Radius.circular(4.00),
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 25.00,
                    width: 82.00,
                    color: Color(0x99000000),
                    child: Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        item.getName(),
                        style: TextStyle(
                          fontFamily: "Indie",
                          fontSize: 21,
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                price <= 0 ? item.getPrice().toString() : price.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Comfortaa",
                  fontSize: 16,
                  color: Color(0xffffffff),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
