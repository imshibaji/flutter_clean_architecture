import 'package:clean_archetructure/core/classes/display_manager.dart';
import 'package:flutter/material.dart';

import '../../Screens/mobile/about.dart' as mobile;
import '../../Screens/tablet/about.dart' as tablet;
import '../../Screens/desktop/about.dart' as desktop;

class AboutController extends StatelessWidget {
  final String _title = 'About Page';
  const AboutController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
