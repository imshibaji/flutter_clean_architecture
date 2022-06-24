import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../lead_mod.dart';

class ListLeadController extends StatelessController {
  const ListLeadController({Key? key}) : super(key: key);

  @override
  Display view(BuildContext context) {
    var sp = context.read<ServiceProvider>();
    sp.getAllLeads();
    return Display(
      title: 'Enqueries / Leads',
      mobile: const ListLeadForMobile(),
    );
  }
}
