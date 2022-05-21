import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../Screens/desktop/home.dart' as desktop;
import '../../Screens/mobile/home.dart' as mobile;
import '../../Screens/tablet/home.dart' as tablet;

class HomeController extends StatelessController {
  final String _title = 'Home Page';
  const HomeController({Key? key}) : super(key: key);

  @override
  bool get auth => true;

  @override
  Display view(BuildContext context) {
    // Navigation Bug Fixes
    var tm = context.read<ThemeProvider>();
    tm.setNavIndex(0);

    return Display(
      title: _title,
      mobile: mobile.Home(title: _title),
      tabletLandscape: tablet.Home(title: _title),
      desktop: desktop.Home(title: _title),
    );
  }
}
