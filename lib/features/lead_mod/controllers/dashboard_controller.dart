import 'package:flutter/material.dart';

import '../../../core/classes/controller_manager.dart';
import '../../../core/classes/display_manager.dart';
import '../views/views.dart';

class DashboardController extends StatelessController {
  const DashboardController({Key? key}) : super(key: key);

  @override
  bool get auth => true;

  @override
  Display view(BuildContext context) {
    return Display(title: 'Dashboard', mobile: const DashboardForMobile());
  }
}
