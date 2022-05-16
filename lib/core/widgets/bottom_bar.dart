import 'package:flutter/material.dart';
import 'package:lead_book/core/utils/button_data.dart';
import 'package:provider/provider.dart';

import '../../config/app_theme.dart';
import '../classes/route_manager.dart';
import '../utils/bottom_util.dart';

// ignore: must_be_immutable
class BottomBar extends StatefulWidget {
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

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int index = 0;
  int len = 0;

  List<ButtonData> get buttonDatas => widget.buttonDatas!;

  @override
  void initState() {
    super.initState();
    len = buttonDatas.length;
    var tm = context.read<ThemeProvider>();
    index = tm.index;
  }

  @override
  Widget build(BuildContext context) {
    var tm = context.read<ThemeProvider>();
    if (len > 1) {
      return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: index,
          onTap: (val) {
            tm.setNavIndex(val);
            setState(() {
              index = val;
              navigator();
            });
          },
          items: [
            for (ButtonData bd in buttonDatas)
              bottomNavigationBarItem(
                icon: Icon(bd.icon),
                label: bd.label,
              ),
          ]);
    } else {
      return Container();
    }
  }

  void navigator() {
    Nav.to(context, buttonDatas[index].link!);
  }
}
