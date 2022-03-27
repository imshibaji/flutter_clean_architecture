import 'package:flutter/material.dart';

import '../../Screens/mobile/about.dart' as mobile;
import '../../Screens/tablet/about.dart' as laptop;
import '../../Screens/desktop/about.dart' as desktop;

class AboutController extends StatelessWidget {
  final String _title = 'About Page';
  const AboutController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    return Container(
      child: width < 500
          ? mobile.About(
              title: _title,
            )
          : width < 1024
              ? laptop.About(
                  title: _title,
                )
              : desktop.About(
                  title: _title,
                ),
    );
  }
}
