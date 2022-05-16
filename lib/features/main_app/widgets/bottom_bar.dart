import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/config.dart';
import '../../../core/core.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int index = 0;

  @override
  void initState() {
    super.initState();
    var tm = context.read<ThemeProvider>();
    index = tm.index;
  }

  @override
  Widget build(BuildContext context) {
    var tm = context.read<ThemeProvider>();
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
          bottomNavigationBarItem(icon: const Icon(Icons.home), label: 'Home'),
          bottomNavigationBarItem(
              icon: const Icon(Icons.people), label: 'About'),
          bottomNavigationBarItem(
              icon: const Icon(Icons.contact_mail), label: 'Contact'),
          bottomNavigationBarItem(
              icon: const Icon(Icons.newspaper), label: 'News'),
          bottomNavigationBarItem(
              icon: const Icon(Icons.ac_unit), label: 'Feature'),
        ]);
  }

  void navigator() {
    switch (index) {
      case 0:
        Nav.to(context, '/');
        break;
      case 1:
        Nav.to(context, '/about');
        break;
      case 2:
        Nav.to(context, '/contact');
        break;
      case 3:
        Nav.to(context, '/news');
        break;
      case 4:
        Nav.to(context, '/feature');
        break;
      default:
    }
  }
}
