import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/classes/controller_manager.dart';
import '../../../core/classes/display_manager.dart';
import '../lead_mod.dart';

class DashboardController extends StatelessController {
  const DashboardController({Key? key}) : super(key: key);

  @override
  bool get auth => true;

  @override
  Display view(BuildContext context) {
    var ep = context.read<EnqueryProvider>();
    ep.setEnquery();

    return Display(title: 'Dashboard', mobile: const DashboardForMobile());
  }
}
