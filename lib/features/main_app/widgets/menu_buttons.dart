import 'package:flutter/material.dart';

import '../../../core/classes/classes.dart';

class MenuButtons extends StatelessWidget {
  const MenuButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      tooltip: 'Menu Buttons',
      onSelected: (value) => handleClick(value.toString(), context),
      itemBuilder: (context) {
        return ['Home', 'About', 'Contact', 'News']
            .map((choice) => PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                ))
            .toList();
      },
    );
  }

  void handleClick(String index, BuildContext context) {
    switch (index) {
      case 'Home':
        Nav.to(context, '/');
        break;
      case 'About':
        Nav.to(context, '/about');
        break;
      case 'Contact':
        Nav.to(context, '/contact');
        break;
      case 'News':
        Nav.to(context, '/news');
        break;
      default:
    }
  }
}
