import 'package:flutter/material.dart';
import 'package:littlebusiness/constants.dart';
import 'package:littlebusiness/logic/Category.dart';
import 'package:hive/hive.dart';
import 'package:littlebusiness/logic/Item.dart';
import '../elements/ext.dart';
import 'package:build_daemon/constants.dart';
import '../elements/table.dart';

class CalculatorPage extends StatefulWidget {
  CalculatorPage({Key key, this.items}) : super(key: key);
  final List<Item> items;
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    items = unifyList(widget.items);
    items.sort((a, b) => a.getQuantity().compareTo(b.getQuantity()));
    for (var i = 0; i < items.length; i++) {
      total += items[i].getFinalPrice();
    }
  }

  var colTable = 0;
  var asTable = true;
  List<ItemShopModel> items;
  var total = 0.0;
  var currency = getKenya();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CALCULATOR'),
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Center(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    DataTable(
                      columnSpacing: 30,
                      horizontalMargin: 0,
                      sortColumnIndex: colTable,
                      sortAscending: asTable,
                      columns: [
                        DataColumn(
                          numeric: true,
                          label: Text(
                            'Quantity',
                            style: TextStyle(fontFamily: 'Comfortaa'),
                          ),
                          onSort: (index, bool) {
                            setState(() {
                              colTable = index;
                              asTable = bool;
                              if (bool) {
                                items.sort((a, b) =>
                                    a.getQuantity().compareTo(b.getQuantity()));
                              } else {
                                items.sort((a, b) =>
                                    b.getQuantity().compareTo(a.getQuantity()));
                              }
                            });
                          },
                        ),
                        DataColumn(
                          label: Text(
                            'Item',
                            style: TextStyle(fontFamily: 'Comfortaa'),
                          ),
                          onSort: (index, bool) {
                            setState(() {
                              colTable = index;
                              asTable = bool;
                              if (bool) {
                                items.sort((a, b) => a
                                    .getItem()
                                    .getName()
                                    .compareTo(b.getItem().getName()));
                              } else {
                                items.sort((a, b) => b
                                    .getItem()
                                    .getName()
                                    .compareTo(a.getItem().getName()));
                              }
                            });
                          },
                        ),
                        DataColumn(
                          label: Text(
                            'Total price',
                            style: TextStyle(fontFamily: 'Comfortaa'),
                          ),
                          onSort: (index, bool) {
                            setState(() {
                              colTable = index;
                              asTable = bool;
                              if (bool) {
                                items.sort((a, b) => a
                                    .getFinalPrice()
                                    .compareTo(b.getFinalPrice()));
                              } else {
                                items.sort((a, b) => b
                                    .getItem()
                                    .getName()
                                    .compareTo(a.getItem().getName()));
                              }
                            });
                          },
                        ),
                      ],
                      rows: getListItemsAccount(),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 76.00,
                      width: 252.00,
                      decoration: BoxDecoration(
                        color: Color(0xff48a999),
                        border: Border.all(
                          width: 3.00,
                          color: Color(0xff00796b),
                        ),
                        borderRadius: BorderRadius.circular(21.00),
                      ),
                      child: Center(
                        child: Text(
                          total.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Indie Flower",
                            fontSize: 54,
                            color: Color(0xffffffff),
                          ),
                        ),
                      ),
                    ),
                    getChange(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void quantityPressed(int indexCol, bool ascending) {
    setState(() {
      setState(() {
        colTable = indexCol;
        asTable = ascending;
        if (ascending) {
          items.sort((a, b) => a.getQuantity().compareTo(b.getQuantity()));
        } else {
          items.sort((a, b) => b.getQuantity().compareTo(a.getQuantity()));
        }
      });
    });
  }

  List<DataRow> getListItemsAccount() {
    List<DataRow> list = List<DataRow>();
    for (var i = 0; i < items.length; i++) {
      list.add(DataRow(cells: [
        DataCell(Text(
          items[i].getQuantity().toString(),
          style: TextStyle(fontFamily: 'Comfortaa'),
        )),
        DataCell(Text(
          items[i].getItem().getName(),
          style: TextStyle(fontFamily: 'Comfortaa'),
        )),
        DataCell(Text(
          items[i].getFinalPrice().toString(),
          style: TextStyle(fontFamily: 'Comfortaa'),
        )),
      ]));
    }
    return list;
  }
}

Column getChange() {
  return Column(
    children: <Widget>[
      Row(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              height: 45.00,
              width: 137.00,
              decoration: BoxDecoration(
                color: Color(0xff48a999),
                border: Border.all(
                  width: 3.00,
                  color: Color(0xff00796b),
                ),
                borderRadius: BorderRadius.circular(23.00),
              ),
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  'Exact amount',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Indie",
                    fontSize: 24,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              height: 45.00,
              width: 137.00,
              decoration: BoxDecoration(
                color: Color(0xff48a999),
                border: Border.all(
                  width: 3.00,
                  color: Color(0xff00796b),
                ),
                borderRadius: BorderRadius.circular(23.00),
              ),
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  'Other amount',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Indie",
                    fontSize: 24,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
            ),
          )
        ],
      )
    ],
  );
}
