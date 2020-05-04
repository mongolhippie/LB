import 'package:flutter/material.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:littlebusiness/constants.dart';

class MenuButton extends StatelessWidget {
  final parts current;

  MenuButton({@required this.current});

  @override
  Widget build(BuildContext context) {
    return FabCircularMenu(
      children: <Widget>[
        IconButton(
            icon: getHoverIcon(0),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/performance');
            }),
        IconButton(
            icon: getHoverIcon(1),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/sales');
            }),
        IconButton(
            icon: getHoverIcon(2),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/categories');
            })
      ],
      ringDiameter: 230,
      ringWidth: 90,
    );
  }

  // Gets the popper icon for the situation
  Image getHoverIcon(int position) {
    if (position == 0) {
      if (current == parts.performance) {
        return Image.asset('img/performance-hover.png');
      } else {
        return Image.asset('img/performance.png');
      }
    }
    if (position == 1) {
      if (current == parts.sales) {
        return Image.asset('img/sales-hover.png');
      } else {
        return Image.asset('img/sales.png');
      }
    }
    if (position == 2) {
      if (current == parts.categories) {
        return Image.asset('img/category-hover.png');
      } else {
        return Image.asset('img/category.png');
      }
    }
  }
}
