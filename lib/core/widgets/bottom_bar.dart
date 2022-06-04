import 'package:flutter/material.dart';
import '../utils/button_data.dart';
import 'package:provider/provider.dart';

import '../../config/app_theme.dart';
import '../classes/route_manager.dart';
import '../utils/bottom_util.dart';

// ignore: must_be_immutable
class BottomBar extends StatelessWidget {
  int index = 0;
  int len = 0;

  List<ButtonData>? buttonDatas;
  BottomBar({Key? key, this.buttonDatas}) : super(key: key) {
    buttonDatas = buttonDatas ??
        [
          ButtonData(icon: Icons.home, label: 'Home', link: '/'),
          ButtonData(icon: Icons.people, label: 'About', link: '/about'),
          ButtonData(
              icon: Icons.contact_mail, label: 'Contact', link: '/contact'),
          ButtonData(icon: Icons.newspaper, label: 'News', link: '/news'),
          ButtonData(icon: Icons.ac_unit, label: 'Features', link: '/feature'),
        ];
  }

  List<ButtonData> get buttonData => buttonDatas!;

  @override
  Widget build(BuildContext context) {
    len = buttonDatas!.length;
    var tm = context.read<ThemeProvider>();
    index = tm.index;

    if (len > 1) {
      return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: index,
        onTap: (val) {
          tm.setNavIndex(val);
          index = val;
          navigator(context, buttonData[index].link!);
        },
        items: buttonData
            .map(
              (e) => bottomNavigationBarItem(
                icon: Icon(e.icon),
                label: e.label,
              ),
            )
            .toList(),
      );
    } else {
      return Container();
    }
  }

  void navigator(BuildContext context, String url) {
    Nav.toReplace(context, url);
  }
}
