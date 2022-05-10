import 'package:clean_archetructure/core/classes/controller_manager.dart';
import 'package:clean_archetructure/core/classes/display_manager.dart';
import 'package:flutter/material.dart';

import '../../Screens/mobile/about.dart' as mobile;
import '../../Screens/tablet/about.dart' as tablet;
import '../../Screens/desktop/about.dart' as desktop;

class AboutController extends StatefulController {
  final String _title = 'About Page';
  const AboutController({Key? key}) : super(key: key);

  @override
  _AboutControllerState createState() => _AboutControllerState();
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
