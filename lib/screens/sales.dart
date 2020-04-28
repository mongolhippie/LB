import 'package:flutter/material.dart';
import 'package:littlebusiness/constants.dart';
import '../elements/menu_button.dart';

class SalesPage extends StatefulWidget {
  SalesPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SalesPageState createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many timssssssssses:',
            ),
//            Image
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: MenuButton(current: parts.sales),
    );
  }
}
