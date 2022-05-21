import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../Screens/desktop/news.dart' as desktop;
import '../../Screens/mobile/news.dart' as mobile;
import '../../Screens/tablet/news.dart' as tablet;

class NewsController extends StatelessController {
  const NewsController({Key? key}) : super(key: key);

  @override
  bool get auth => true;

  @override
  Display view(BuildContext context) {
    return Display(
      title: 'News Area',
      mobile: const mobile.News(),
      tabletLandscape: const tablet.News(),
      desktop: const desktop.News(),
    );
  }
}
