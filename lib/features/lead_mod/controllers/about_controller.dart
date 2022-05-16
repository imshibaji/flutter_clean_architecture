// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';

import '../../../core/core.dart';
import '../views/views.dart';

class AboutController extends StatelessController {
  const AboutController({Key? key}) : super(key: key);

  @override
  Display view(BuildContext context) {
    return Display(title: 'About', mobile: const AboutForMobile());
  }
}
