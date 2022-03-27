import 'package:flutter/material.dart';

import '../../Screens/mobile/home.dart' as mobile;
import '../../Screens/tablet/home.dart' as tablet;
import '../../Screens/desktop/home.dart' as desktop;

class HomeController extends StatelessWidget {
  final String _title = 'Home Page';
  const HomeController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // log(size.width.toString());

    double width = size.width;

    return Container(
      child: width < 500
          ? mobile.Home(
              title: _title,
            )
          : width < 1024
              ? tablet.Home(
                  title: _title,
                )
              : desktop.Home(
                  title: _title,
                ),
    );
  }
}
