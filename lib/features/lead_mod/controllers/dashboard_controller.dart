import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/core.dart';
import '../lead_mod.dart';

class DashboardController extends StatelessController {
  const DashboardController({Key? key}) : super(key: key);

  // @override
  // bool get auth => true;

  @override
  Display view(BuildContext context) {
    // var ep = context.read<EnqueryProvider>();
    // ep.setEnquery();

    // Navigation Bug Fixes
    // var tm = context.read<ThemeProvider>();
    // tm.setNavIndex(0);

    var sp = context.read<ServiceProvider>();
    sp.init();

    return Display(
        title: 'LeadsBook - Dashboard', mobile: const DashboardForMobile());
  }
}
