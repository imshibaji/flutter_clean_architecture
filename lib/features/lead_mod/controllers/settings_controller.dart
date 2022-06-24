// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';

import '../../../core/core.dart';
import '../views/views.dart';

class SettingsController extends StatelessController {
  const SettingsController({Key? key}) : super(key: key);

  @override
  Display view(BuildContext context) {
    return Display(title: 'Settings', mobile: const Settings());
  }
}
