import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/config.dart';
import '../core.dart';

// ignore: must_be_immutable
class ActionButtons extends StatelessWidget {
  List<ButtonData>? buttonDatas;
  ActionButtons({
    Key? key,
    this.buttonDatas,
  }) : super(key: key) {
    buttonDatas = buttonDatas ??
        [
          ButtonData(icon: Icons.home, label: 'Home', link: '/'),
          ButtonData(icon: Icons.people, label: 'About', link: '/about'),
          ButtonData(icon: Icons.logout, label: 'Logout', link: '/logout'),
        ];
  }

  @override
  Widget build(BuildContext context) {
    return getMenuDropdown(context);
  }

  getMenuDropdown(BuildContext context) {
    var tm = context.watch<ThemeProvider>();
    return PopupMenuButton(
      tooltip: 'Menu Buttons',
      onSelected: (ButtonData bd) => handleClick(bd.link!, context),
      itemBuilder: (context) {
        return buttonDatas!
            .map((choice) => PopupMenuItem<ButtonData>(
                  value: choice,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        choice.icon,
                        color:
                            tm.isDarkMode == true ? Colors.white : Colors.black,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(choice.label),
                    ],
                  ),
                ))
            .toList();
      },
    );
  }

  void handleClick(String link, BuildContext context) {
    if (link == '/logout') {
      doLogout(context);
    }
    Nav.to(context, link);
    // switch (index) {
    //   case 'Home':
    //     Nav.to(context, '/');
    //     break;
    //   case 'About':
    //     Nav.to(context, '/about');
    //     break;
    //   case 'Contact':
    //     Nav.to(context, '/contact');
    //     break;
    //   case 'News':
    //     Nav.to(context, '/news');
    //     break;
    //   default:
    // }
  }
}
