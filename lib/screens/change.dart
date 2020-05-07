import 'package:flutter/material.dart';
import 'package:littlebusiness/logic/Category.dart';
import 'package:hive/hive.dart';
import 'package:littlebusiness/logic/Item.dart';

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
  }

  String _name;
  Color _color;
  String _selectedValue;

  void addCategory(Category cat) {
    Hive.box('categories').add(cat);
  }

  void getColor(String value) {
    _selectedValue = value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CALCULATOR'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[],
            ),
          ),
        ),
      ),
    );
  }
}
