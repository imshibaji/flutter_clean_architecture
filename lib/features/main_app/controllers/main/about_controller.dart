import 'package:clean_archetructure/core/classes/controller_manager.dart';
import 'package:clean_archetructure/core/classes/display_manager.dart';
import 'package:flutter/material.dart';

import '../../Screens/mobile/about.dart' as mobile;
import '../../Screens/tablet/about.dart' as tablet;
import '../../Screens/desktop/about.dart' as desktop;

class AboutController extends Controller {
  final String _title = 'About Page';
  const AboutController({Key? key}) : super(key: key);

  @override
  bool get auth => true;

  @override
  Display view(BuildContext context) {
    return Display(
      title: _title,
      xs: mobile.About(
        title: _title,
      ),
      md: tablet.About(title: _title),
      lg: desktop.About(title: _title),
    );
  }
}
