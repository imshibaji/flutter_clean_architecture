import 'package:flutter/material.dart';

import '../../Screens/desktop/news.dart' as desktop;
import '../../Screens/mobile/news.dart' as mobile;
import '../../Screens/tablet/news.dart' as tablet;

class NewsController extends StatelessWidget {
  const NewsController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: size.width < 500
          ? const mobile.News()
          : size.width < 1024
              ? const tablet.News()
              : const desktop.News(),
    );
  }
}
