import 'package:flutter/material.dart';
import 'package:littlebusiness/constants.dart';
import 'package:littlebusiness/logic/Category.dart';
import 'package:littlebusiness/logic/Item.dart';
import 'package:littlebusiness/DAO.dart';
import 'package:hive/hive.dart';
import '../elements/menu_button.dart';
import 'package:build_daemon/constants.dart';
import '../elements/ext.dart';
import 'change.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SalesPage extends StatefulWidget {
  SalesPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _SalesPageState createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  List<Category> categories;
  List<Item> items;

  var itemsSelected = List<Item>();
  var total = 0.0;

  void updatePrice() {
    total = 0;
    for (var i = 0; i < itemsSelected.length; i++) {
      total += itemsSelected[i].getPrice();
    }
  }

  @override
  void initState() {
    super.initState();
    categories = getListCategories();
    items = getListItems()..sort((a, b) => a.getName().compareTo(b.getName()));
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
                  crossAxisCount: 3,
                  mainAxisSpacing: 3,
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
    var sol = List<Widget>();
    Category cat;
    for (var i = 0; i < list.length; i++) {
      cat = getCategoryByID(list[i].getItem().getCategory());
      sol.add(itemsShop(list[i].getItem(), cat, list[i].getQuantity()));
    }
    sol.add(Column(
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        IconButton(
            iconSize: 100,
            icon: SvgPicture.asset(
              'svg/calc.svg',
              semanticsLabel: 'Calculator',
              width: 100,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CalculatorPage(items: itemsSelected),
                ),
              );
            }),
        Center(
          child: Text(
            total.toString(),
            style: TextStyle(
              fontFamily: "Comfortaa",
              fontSize: 23,
              fontWeight: FontWeight.w600,
              color: kBorderGreen,
            ),
          ),
        )
      ],
    ));
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
            if (price < 0) {
              itemsSelected = List.from(itemsSelected..add(item))
                ..sort((a, b) => a.getName().compareTo(b.getName()));
            } else {
              itemsSelected = List.from(itemsSelected..remove(item));
            }
            updatePrice();
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
          height: price <= 0 ? 101 : 131,
          width: price <= 0 ? 81 : 121,
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
                height: price <= 0 ? 80 : 90,
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
                    width: double.infinity,
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
                height: price <= 0 ? 3 : 8,
              ),
              Text(
                price <= 0 ? item.getPrice().toString() : price.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Comfortaa",
                  fontSize: price <= 0 ? 16 : 24,
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
