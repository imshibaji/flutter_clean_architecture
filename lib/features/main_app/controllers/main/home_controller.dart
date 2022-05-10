import 'package:clean_archetructure/core/classes/controller_manager.dart';
import 'package:clean_archetructure/core/classes/display_manager.dart';
import 'package:flutter/material.dart';

import '../../Screens/mobile/home.dart' as mobile;
import '../../Screens/tablet/home.dart' as tablet;
import '../../Screens/desktop/home.dart' as desktop;

class HomeController extends Controller {
  final String _title = 'Home Page';
  const HomeController({Key? key}) : super(key: key);

  @override
  bool get auth => true;

  @override
  Display view(BuildContext context) {
    return Display(
      title: _title,
      xs: mobile.Home(title: _title),
      md: tablet.Home(title: _title),
      lg: desktop.Home(title: _title),
    );
  }
}
