import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../providers/providers.dart';
import '../../views/views.dart';

class FollowupController extends StatelessController {
  const FollowupController({Key? key}) : super(key: key);

  @override
  Display view(BuildContext context) {
    var sp = context.read<ServiceProvider>();
    sp.getAllLeads();
    sp.getAllFollowups();
    return Display(
      title: 'LeadBook - Followup',
      mobile: const FollowupForMobile(),
    );
  }
}
