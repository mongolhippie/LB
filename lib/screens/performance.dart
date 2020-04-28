import 'package:flutter/material.dart';
import 'package:littlebusiness/constants.dart';
import '../elements/menu_button.dart';

class PerformancePage extends StatefulWidget {
  @override
  _PerformancePageState createState() => _PerformancePageState();
}

class _PerformancePageState extends State<PerformancePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('asdf'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'PERFORMANCE',
            ),
//            Image
            Text(
              'asdfasdf',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: MenuButton(current: parts.performance),
    );
  }
}
