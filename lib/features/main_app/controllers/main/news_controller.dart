import 'package:clean_archetructure/core/classes/controller_manager.dart';
import 'package:clean_archetructure/core/classes/display_manager.dart';
import 'package:flutter/material.dart';

import '../../Screens/desktop/news.dart' as desktop;
import '../../Screens/mobile/news.dart' as mobile;
import '../../Screens/tablet/news.dart' as tablet;

class NewsController extends Controller {
  const NewsController({Key? key}) : super(key: key);

  @override
  bool get auth => true;

  @override
  Display view(BuildContext context) {
    return Display(
      title: 'News Area',
      xs: const mobile.News(),
      md: const tablet.News(),
      lg: const desktop.News(),
    );
  }
}
