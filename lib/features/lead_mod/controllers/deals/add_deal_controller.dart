import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../providers/providers.dart';
import '../../views/views.dart';

class AddDealController extends StatelessController {
  const AddDealController({Key? key}) : super(key: key);

  @override
  Display view(BuildContext context) {
    var sp = context.read<ServiceProvider>();
    sp.getAllLeads();
    sp.getAllDeals();
    return Display(
      title: 'Add Proposals / Deals',
      mobile: const AddDeal(),
    );
  }
}
