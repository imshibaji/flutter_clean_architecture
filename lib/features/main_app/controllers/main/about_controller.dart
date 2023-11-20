import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../Screens/desktop/about.dart' as desktop;
import '../../Screens/mobile/about.dart' as mobile;
import '../../Screens/tablet/about.dart' as tablet;


class AboutController extends StatefulController {
  final String _title = 'About Page';
  const AboutController({Key? key}) : super(key: key);

  @override
  State<AboutController> createState() => _AboutControllerState();
}

class _AboutControllerState extends ControllerState<AboutController> {
  @override
  bool get auth => true;

  @override
  Display view(BuildContext context) {
    return Display(
      title: widget._title,
      mobile: mobile.About(
        title: widget._title,
      ),
      tabletLandscape: tablet.About(title: widget._title),
      desktop: desktop.About(title: widget._title),
    );
  }
}
