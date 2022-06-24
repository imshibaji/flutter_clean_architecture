import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../providers/providers.dart';
import '../../views/views.dart';

class AddLeadController extends StatelessController {
  const AddLeadController({Key? key}) : super(key: key);

  @override
  Display view(BuildContext context) {
    FirebaseTracker().setScreen('Leads Screen');
    return Display(
      title: 'Add Lead',
      mobile: const AddLeadForMobile(),
    );
  }
}
