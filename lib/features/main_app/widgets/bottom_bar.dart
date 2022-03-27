import 'package:clean_archetructure/classes/route_manager.dart';
import 'package:clean_archetructure/core/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        currentIndex: index,
        onTap: (val) {
          tm.setNavIndex(val);
          setState(() {
            index = val;
            navigator();
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.cyan,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'About',
            backgroundColor: Colors.blueAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_mail),
            label: 'Contact',
            backgroundColor: Colors.redAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'News',
            backgroundColor: Colors.pink,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.ac_unit),
            label: 'Feature',
            backgroundColor: Colors.cyan,
          ),
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
